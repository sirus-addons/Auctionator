AuctionatorInsetMixin = {}

function AuctionatorInsetMixin:OnLoad()
  self.Bg:SetAtlas("auctionhouse-background-index")

  local frameLevel = self:GetFrameLevel()
  self.NineSlice:SetFrameLevel(frameLevel)
end

AuctionatorInsetDarkMixin = {}

function AuctionatorInsetDarkMixin:OnLoad()
  self.Bg:SetAtlas("auctionhouse-background-sell-right")

  local frameLevel = self:GetParent():GetFrameLevel()
  self:SetFrameLevel(frameLevel)
  self.NineSlice:SetFrameLevel(frameLevel)
end

AuctionatorInsetLeaveScrollSpaceMixin = {}

function AuctionatorInsetLeaveScrollSpaceMixin:OnLoad()
  self.Bg:SetAtlas("auctionhouse-background-index")

  local frameLevel = self:GetParent():GetFrameLevel()
  self:SetFrameLevel(frameLevel)
  self.NineSlice:SetFrameLevel(frameLevel)
end