-- Returns just enough information that the BagItem mixin can display the item
-- and the SaleItemMixin can post it.
local classIdMap = {
  [ITEM_CLASS_0] = LE_ITEM_CLASS_CONSUMABLE,
  [ITEM_CLASS_1] = LE_ITEM_CLASS_CONTAINER,
  [ITEM_CLASS_2] = LE_ITEM_CLASS_WEAPON,
  [ITEM_CLASS_3] = LE_ITEM_CLASS_GEM,
  [ITEM_CLASS_4] = LE_ITEM_CLASS_ARMOR,
  [ITEM_CLASS_6] = LE_ITEM_CLASS_AMMO,
  [ITEM_CLASS_7] = LE_ITEM_CLASS_TRADEGOODS,
  [ITEM_CLASS_9] = LE_ITEM_CLASS_RECIPE,
  [ITEM_CLASS_11] = LE_ITEM_CLASS_QUIVER,
  [ITEM_CLASS_12] = LE_ITEM_CLASS_QUESTITEM,
  [ITEM_CLASS_15] = LE_ITEM_CLASS_MISCELLANEOUS,
  [ITEM_CLASS_16] = LE_ITEM_CLASS_GLYPH,
}

function Auctionator.Utilities.ItemInfoFromLocation(location)
  local itemKey = C_AuctionHouse.GetItemKeyFromItem(location)
  local itemType = C_AuctionHouse.GetItemCommodityStatus(location)

  local icon, itemCount, _, _, _, _, itemLink = GetContainerItemInfo(location:GetBagAndSlot())

  local _, _, quality, _, _, classID = GetItemInfo(itemLink or itemKey.itemID)
  classID = classIdMap[classID]

  -- The first time the AH is loaded sometimes when a full scan is running the
  -- quality info may not be available. This just gives a sensible fail value.
  if quality == -1 then
    Auctionator.Debug.Message("Missing quality", itemKey.itemID)
    quality = 1
  end

  return {
    itemKey = itemKey,
    itemLink = itemLink,
    count = itemCount,
    iconTexture = icon,
    itemType = itemType,
    location = location,
    quality = quality,
    classId = classID,
    auctionable = C_AuctionHouse.IsSellItemValid(location, false)
  }
end
