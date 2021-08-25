AuctionatorConfigurationCopyAndPasteMixin = CreateFromMixins(AuctionatorConfigTooltipMixin)

function AuctionatorConfigurationCopyAndPasteMixin:OnLoad()
  local labelText = self:GetAttribute("labelText")
  labelText = _G[labelText] or labelText

  local copyText = self:GetAttribute("copyText")
  copyText = _G[copyText] or copyText

  if labelText ~= nil then
    self.Label:SetText(labelText)
  end

  if copyText ~= nil then
    self.InputBox:SetText(copyText)
    self.InputBox:SetCursorPosition(0)
  end
end
