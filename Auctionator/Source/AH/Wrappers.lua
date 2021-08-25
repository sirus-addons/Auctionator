function Auctionator.AH.SendSearchQuery(...)
  local args = {...}
  Auctionator.AH.Queue:Enqueue(function()
    C_AuctionHouse.SendSearchQuery(unpack(args))
  end)
end

function Auctionator.AH.SendSellSearchQuery(...)
  local args = {...}
  Auctionator.AH.Queue:Enqueue(function()
    C_AuctionHouse.SendSellSearchQuery(unpack(args))
  end)
end

function Auctionator.AH.QueryOwnedAuctions(...)
  local args = {...}
  Auctionator.AH.Queue:Enqueue(function()
    C_AuctionHouse.QueryOwnedAuctions(unpack(args))
  end)
end

local sentBrowseQuery = true
function Auctionator.AH.SendBrowseQuery(query)
  local arg1 = query
  sentBrowseQuery = false
  Auctionator.AH.Queue:Enqueue(function()
    sentBrowseQuery = true
    if type(arg1) == "table" and not next(arg1.filters) then
      arg1.filters = {5, 6, 7, 9, 8, 4}
    end
    C_AuctionHouse.SendBrowseQuery(arg1)
  end)
end

function Auctionator.AH.HasFullBrowseResults()
  return sentBrowseQuery and C_AuctionHouse.HasFullBrowseResults()
end

function Auctionator.AH.RequestMoreBrowseResults(...)
  local args = {...}
  Auctionator.AH.Queue:Enqueue(function()
    C_AuctionHouse.RequestMoreBrowseResults(unpack(args))
  end)
end

-- Event ThrottleUpdate will fire whenever the state changes
function Auctionator.AH.IsNotThrottled()
  return Auctionator.AH.Internals.throttling:IsReady()
end

function Auctionator.AH.CancelAuction(...)
  -- Can't be queued, "protected" call
  C_AuctionHouse.CancelAuction(...)
end

function Auctionator.AH.ReplicateItems()
  C_AuctionHouse.ReplicateItems()
end

function Auctionator.AH.GetItemKeyInfo(itemKey, callback)
  Auctionator.AH.Internals.itemKeyLoader:Get(itemKey, callback)
end
