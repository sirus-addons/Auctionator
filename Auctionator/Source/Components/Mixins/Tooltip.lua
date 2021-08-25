AuctionatorConfigTooltipMixin = {}

function AuctionatorConfigTooltipMixin:OnEnter()
  local tooltipText = self:GetAttribute("tooltipText")
  tooltipText = _G[tooltipText] or tooltipText

  local tooltipTitleText = self:GetAttribute("tooltipTitleText")
  tooltipTitleText = _G[tooltipTitleText] or tooltipTitleText

  if tooltipText ~= nil then
    GameTooltip:SetOwner(self, "ANCHOR_LEFT")
    GameTooltip:SetText((tooltipTitleText or ""), 0.9, 1.0, 1.0)
    GameTooltip:AddLine(tooltipText, 0.5, 0.5, 1.0, 1)
    GameTooltip:Show()
  elseif tooltipTitleText ~= nil then
    GameTooltip:SetOwner(self, "ANCHOR_LEFT")
    GameTooltip:SetText(tooltipTitleText, 0.9, 1.0, 1.0)
    GameTooltip:Show()
  end
end

function AuctionatorConfigTooltipMixin:OnLeave()
  if self:GetAttribute("tooltipText") ~= nil or self:GetAttribute("tooltipTitleText") ~= nil then
    GameTooltip:Hide()
  end
end
