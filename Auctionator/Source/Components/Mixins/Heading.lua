AuctionatorConfigurationHeadingMixin = {}

function AuctionatorConfigurationHeadingMixin:OnLoad()
  local headingText = self:GetAttribute("headingText")
  headingText = _G[headingText] or headingText

  if headingText ~= nil then
    self.HeadingText:SetText(headingText)
  end
end