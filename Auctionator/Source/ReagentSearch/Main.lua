function Auctionator.ReagentSearch.DoTradeSkillReagentsSearch()
  local id = GetTradeSkillSelectionIndex()
  local skillName, _, _, _, altVerb = GetTradeSkillInfo(id);
  local items = {skillName}

  for i = 1, GetTradeSkillNumReagents(id) do
    local reagentName = GetTradeSkillReagentInfo(id, i);
    table.insert(items, reagentName)
  end

  if altVerb then
    -- Enchanting names are pretty unique, and we want to be able to find the
    -- enchantment (which has a name that isn't exactly skillName)
    -- Hence we do a non-exact search.
    Auctionator.API.v1.MultiSearch(AUCTIONATOR_L_REAGENT_SEARCH, items)
  else
    -- Exact search to avoid spurious results, say with "Shrouded Cloth"
    Auctionator.API.v1.MultiSearchExact(AUCTIONATOR_L_REAGENT_SEARCH, items)
    --Auctionator.API.v1.MultiSearch(AUCTIONATOR_L_REAGENT_SEARCH, items)
  end
end

function Auctionator.ReagentSearch.GetSkillReagentsTotal()
  local id = GetTradeSkillSelectionIndex()

  local total = 0

  for i = 1, GetTradeSkillNumReagents(id) do
    local reagentCount = select(3, GetTradeSkillReagentInfo(id, i))
    local link = GetTradeSkillReagentItemLink(id, i)
    if link ~= nil then
      local unitPrice

      local dbKey = Auctionator.Utilities.BasicDBKeyFromLink(link)
      if AUCTIONATOR_VENDOR_PRICE_CACHE[dbKey] ~= nil then
        unitPrice = AUCTIONATOR_VENDOR_PRICE_CACHE[dbKey]
      else
        unitPrice = Auctionator.API.v1.GetAuctionPriceByItemLink(AUCTIONATOR_L_REAGENT_SEARCH, link)
      end

      local unitPrice = Auctionator.API.v1.GetAuctionPriceByItemLink(AUCTIONATOR_L_REAGENT_SEARCH, link)
      if unitPrice ~= nil then
        total = total + reagentCount * unitPrice
      end
    end
  end

  return total
end

function Auctionator.ReagentSearch.GetAHProfit()
  local id = GetTradeSkillSelectionIndex()
  local link = GetTradeSkillItemLink(id)

  local currentAH = Auctionator.API.v1.GetAuctionPriceByItemLink(AUCTIONATOR_L_REAGENT_SEARCH, link)
  if currentAH == nil then
    currentAH = 0
  end
  local toCraft = Auctionator.ReagentSearch.GetSkillReagentsTotal()

  return math.max(0, math.floor(currentAH * 0.95 - toCraft))
end

-- Add a button to the tradeskill frame to search the AH for the reagents.
-- The button (see Mixins/Button.lua) will be hidden when the AH is closed.
-- The total price is shown in a FontString next to the button
local addedFunctionality = false
function Auctionator.ReagentSearch.InitializeSearchButton()
  if addedFunctionality then
    return
  end

  if TradeSkillFrame then
    addedFunctionality = true

    local buttonFrame = CreateFrame("BUTTON", "AuctionatorTradeSkillSearch", TradeSkillFrame, "AuctionatorReagentSearchButtonTemplate");
  end
end

function Auctionator.ReagentSearch.CacheVendorPrices()
  for i = 1, GetMerchantNumItems() do
    local price, _, numAvailable = select(3, GetMerchantItemInfo(i))
    local itemLink = GetMerchantItemLink(i)
    local dbKey = Auctionator.Utilities.BasicDBKeyFromLink(itemLink)
    if dbKey ~= nil and price ~= 0 and numAvailable == -1 then
      AUCTIONATOR_VENDOR_PRICE_CACHE[dbKey] = price
    elseif dbKey ~= nil then
      AUCTIONATOR_VENDOR_PRICE_CACHE[dbKey] = nil
    end
  end
end
