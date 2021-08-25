AuctionatorConfigNumericInputMixin = CreateFromMixins(AuctionatorConfigTooltipMixin)

function AuctionatorConfigNumericInputMixin:OnLoad()
  local labelText = self:GetAttribute("labelText")
  labelText = _G[labelText] or labelText

  if labelText ~= nil then
    self.InputBox.Label:SetText(labelText)
  end
  if self:GetAttribute("classID") then
    self.InputBox.Label:SetSize(120, 0)
  end
end

function AuctionatorConfigNumericInputMixin:OnMouseUp()
  self.InputBox:SetFocus()
end

function AuctionatorConfigNumericInputMixin:SetNumber(value)
  self.InputBox:SetNumber(value)
  self.InputBox:SetCursorPosition(0)
end

function AuctionatorConfigNumericInputMixin:GetNumber(value)
  return self.InputBox:GetNumber(value)
end
