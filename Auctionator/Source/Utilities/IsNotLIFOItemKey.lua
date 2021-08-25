function Auctionator.Utilities.IsNotLIFOItemKey(itemKey)
  local itemInfo = { GetItemInfo(itemKey.itemID) }

  return #itemInfo ~= 0 and itemKey.itemLevel ~= 1 and (
    itemInfo[Auctionator.Constants.ITEM_INFO.ITEM_TYPE] == ITEM_CLASS_2 or
    itemInfo[Auctionator.Constants.ITEM_INFO.ITEM_TYPE] == ITEM_CLASS_4
  )
end
