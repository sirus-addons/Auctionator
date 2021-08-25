AuctionatorConfigRadioButtonMixin = CreateFromMixins(AuctionatorConfigTooltipMixin)

function AuctionatorConfigRadioButtonMixin:OnLoad()
  -- This field is used by the RadioButtonGroup to ensure that the UI child it is positioning
  -- is an auctionator radio button
  self.isAuctionatorRadio = true

  if self:GetAttribute("value") == nil then
    error("A value is required for the radio button.")
  end

  local labelText = self:GetAttribute("labelText")
  labelText = _G[labelText] or labelText

  if labelText ~= nil then
    self.RadioButton.Label:SetText(labelText)
  end
end

function AuctionatorConfigRadioButtonMixin:OnMouseUp()
  self.RadioButton:Click()
end

function AuctionatorConfigRadioButtonMixin:OnEnter()
  self.RadioButton:LockHighlight()
end

function AuctionatorConfigRadioButtonMixin:OnLeave()
  self.RadioButton:UnlockHighlight()
end

function AuctionatorConfigRadioButtonMixin:SetChecked(value)
  self.RadioButton:SetChecked(value)
end

function AuctionatorConfigRadioButtonMixin:GetChecked()
  return self.RadioButton:GetChecked() == 1
end

function AuctionatorConfigRadioButtonMixin:GetValue()
  return self:GetAttribute("value")
end

function AuctionatorConfigRadioButtonMixin:OnClick()
  if self.onSelectedCallback ~= nil then
    self.onSelectedCallback()
  end
end
