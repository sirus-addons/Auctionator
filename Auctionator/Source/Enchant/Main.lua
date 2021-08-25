local armorClassID = {
  [ITEM_CLASS_2] = LE_ITEM_CLASS_WEAPON,
  [ITEM_CLASS_4] = LE_ITEM_CLASS_ARMOR,
}

local function isDisenchantable(itemInfo)
  return
    #itemInfo == 0 or (
      (
        itemInfo[Auctionator.Constants.ITEM_INFO.ITEM_TYPE] == ITEM_CLASS_2 or
        itemInfo[Auctionator.Constants.ITEM_INFO.ITEM_TYPE] == ITEM_CLASS_4
      ) and
      itemInfo[Auctionator.Constants.ITEM_INFO.RARITY] >= Enum.ItemQuality.Uncommon and
      itemInfo[Auctionator.Constants.ITEM_INFO.RARITY] <= Enum.ItemQuality.Epic
    )
end

function Auctionator.Enchant.DisenchantStatus(itemInfo)
  return {
    isDisenchantable = isDisenchantable(itemInfo),
    supportedXpac = false
--      itemInfo[Auctionator.Constants.ITEM_INFO.XPAC] >= -- TODO: Fix
--        LE_EXPANSION_WARLORDS_OF_DRAENOR
  }
end

function Auctionator.Enchant.GetDisenchantReagents(itemInfo)
  local classID = armorClassID[itemInfo[Auctionator.Constants.ITEM_INFO.ITEM_TYPE]]
  local deTable = classID and Auctionator.Enchant.DE_TABLE[Auctionator.Enchant.DE_KEY(classID, itemInfo[Auctionator.Constants.ITEM_INFO.RARITY] or 2)]
  if deTable then
    for i = 1, #deTable do
      if (itemInfo[Auctionator.Constants.ITEM_INFO.ILEVEL] >= deTable[i][1] and itemInfo[Auctionator.Constants.ITEM_INFO.ILEVEL] <= deTable[i][2]) then
        return deTable[i]
      end
    end
  else
    return nil
  end
end

function Auctionator.Enchant.GetDisenchantAuctionPrice(itemLink)
  local itemInfo = { GetItemInfo(itemLink) }

  if not isDisenchantable(itemInfo) then
    return nil
  end

  local disenchantInfo = Auctionator.Enchant.GetDisenchantReagents(itemInfo)

  if disenchantInfo == nil then
    return nil
  end

  local price = 0

  for i = 3, #disenchantInfo, 3 do
    local reagentPrice = Auctionator.Database:GetPrice(tostring(disenchantInfo[i + 2]));
    if reagentPrice then
      price = price + (disenchantInfo[i] * disenchantInfo[i + 1] * reagentPrice);
    end
  end

  return math.floor(price / 100)
end
