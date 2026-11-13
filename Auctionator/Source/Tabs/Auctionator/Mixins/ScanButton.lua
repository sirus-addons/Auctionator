AuctionatorScanButtonMixin = {}

function AuctionatorScanButtonMixin:OnLoad()
  DynamicResizeButton_Resize(self)
end

function AuctionatorScanButtonMixin:OnClick()
  Auctionator.State.IncrementalScanFrameRef:InitiateScan()
end
