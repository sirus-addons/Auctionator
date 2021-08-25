AuctionatorConfigurationTitleFrameMixin = {}

function AuctionatorConfigurationTitleFrameMixin:OnLoad()
  local titleText = self:GetAttribute("titleText")
  titleText = _G[titleText] or titleText

  local subTitleText = self:GetAttribute("subTitleText")
  subTitleText = _G[subTitleText] or subTitleText

  if titleText ~= nil then
    self.Title:SetText(titleText)
  end

  if subTitleText then
    self.SubTitle:SetText(subTitleText)

    -- Width value doesn't matter, but setting this makes the word wrap work
    -- The anchors in the frame xml set the actual width.
    self.SubTitle:SetWidth(200)
  end
end
