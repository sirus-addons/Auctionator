AuctionatorResultsRowTemplateMixin = {}

function AuctionatorResultsRowTemplateMixin:OnLoad()
  self.SelectedHighlight:SetAtlas("auctionhouse-ui-row-select")
  self.HighlightTexture:SetAtlas("auctionhouse-ui-row-highlight")
  self.NormalTexture:SetAtlas("auctionhouse-rowstripe-1")
end

function AuctionatorResultsRowTemplateMixin:OnClick(...)
  Auctionator.Debug.Message("AuctionatorResultsRowTemplateMixin:OnClick()", ...)
end

function AuctionatorResultsRowTemplateMixin:OnEnter(...)
  self.HighlightTexture:Show()
end

function AuctionatorResultsRowTemplateMixin:OnLeave(...)
  self.HighlightTexture:Hide()
end

function AuctionatorResultsRowTemplateMixin:Populate(rowData, dataIndex)
  self.rowData = rowData
  self.dataIndex = dataIndex
end