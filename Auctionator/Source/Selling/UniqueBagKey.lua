function Auctionator.Selling.UniqueBagKey(entry)
  local result = Auctionator.Utilities.ItemKeyString(entry.itemKey) .. " " .. entry.quality

  if not entry.auctionable then
    result = result .. " x"
  end

  return result
end
