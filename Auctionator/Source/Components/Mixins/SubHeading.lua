AuctionatorConfigurationSubHeadingMixin = {}

function AuctionatorConfigurationSubHeadingMixin:InitializeSubHeading()
  Auctionator.Debug.Message("AuctionatorConfigurationSubHeadingMixin:InitializeSubHeading()")

  local subHeadingText = self:GetAttribute("subHeadingText")
  subHeadingText = _G[subHeadingText] or subHeadingText

  if subHeadingText ~= nil then
    self.HeadingText:SetText(subHeadingText)
  end
end

function AuctionatorConfigurationSubHeadingMixin:SetText(newHeading)
  self:SetAttribute("subHeadingText", newHeading)
  self:OnLoad()
end
