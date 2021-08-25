AuctionatorKeyBindingConfigMixin = CreateFromMixins(AuctionatorConfigTooltipMixin)

function AuctionatorKeyBindingConfigMixin:OnLoad()
  self.isListening = false
  local labelText = self:GetAttribute("labelText")
  labelText = _G[labelText] or labelText
  self.Description:SetText(labelText)
  self.shortcut = ""
  self:EnableKeyboard(false)
  self:EnableMouseWheel(false)
end

function AuctionatorKeyBindingConfigMixin:SetShortcut(shortcut)
  self.shortcut = shortcut
  if self.shortcut == "" then
    self.Button:SetText(GRAY_FONT_COLOR:WrapTextInColorCode(NOT_BOUND))
  else
    self.Button:SetText(GetBindingText(self.shortcut))
  end
end

function AuctionatorKeyBindingConfigMixin:GetShortcut(shortcut)
  return self.shortcut
end

function AuctionatorKeyBindingConfigMixin:OnHide()
  self:StopListening()
end

function AuctionatorKeyBindingConfigMixin:StartListening()
  self.isListening = true
  self:SetScript("OnMouseWheel", self.OnMouseWheel)
  self:SetScript("OnKeyDown", self.OnKeyDown)
  self:EnableKeyboard(true)
  self:EnableMouseWheel(true)
  self.Button:SetScript("OnMouseWheel", function(button, ...)
    self:OnMouseWheel(...)
  end)
  self.Button.selectedHighlight:Show()
end
function AuctionatorKeyBindingConfigMixin:StopListening()
  self.isListening = false
  self:SetScript("OnMouseWheel", nil)
  self:SetScript("OnKeyDown", nil)
  self:EnableKeyboard(false)
  self:EnableMouseWheel(false)
  self.Button:SetScript("OnMouseWheel", nil)
  self.Button.selectedHighlight:Hide()
end

function AuctionatorKeyBindingConfigMixin:OnClick(button)
  if button == "LeftButton" or button == "RightButton" then
    if self.isListening then
      self:StopListening()
    else
      self:StartListening()
    end
  else
    self:OnKeyDown(button)
  end
end

function AuctionatorKeyBindingConfigMixin:OnEnter()
  AuctionatorConfigTooltipMixin.OnEnter(self)
  self.Button:LockHighlight()
end
function AuctionatorKeyBindingConfigMixin:OnLeave()
  AuctionatorConfigTooltipMixin.OnLeave(self)
  self.Button:UnlockHighlight()
end

function AuctionatorKeyBindingConfigMixin:OnMouseWheel(delta)
  if delta > 0 then
    self:OnKeyDown("MOUSEWHEELUP")
  else
    self:OnKeyDown("MOUSEWHEELDOWN")
  end
end

local metaKeys = {
  LALT = 1,
  RALT = 2,
  LCTRL = 3,
  RCTRL = 4,
  LSHIFT = 5,
  RSHIFT = 6,
  ALT = 7,
  CTRL = 8,
  SHIFT = 9,
}

local ignoredKeys = {
  UNKNOWN = true,
  BUTTON1 = true,
  BUTTON2 = true,
}

local mouseButtonNameConversion = {
  LeftButton = "BUTTON1",
  RightButton = "BUTTON2",
  MiddleButton = "BUTTON3",
  Button1 = "BUTTON1",
  Button2 = "BUTTON2",
  Button3 = "BUTTON3",
  Button4 = "BUTTON4",
  Button5 = "BUTTON5",
  Button6 = "BUTTON6",
  Button7 = "BUTTON7",
  Button8 = "BUTTON8",
  Button9 = "BUTTON9",
  Button10 = "BUTTON10",
  Button11 = "BUTTON11",
  Button12 = "BUTTON12",
  Button13 = "BUTTON13",
  Button14 = "BUTTON14",
  Button15 = "BUTTON15",
  Button16 = "BUTTON16",
  Button17 = "BUTTON17",
  Button18 = "BUTTON18",
  Button19 = "BUTTON19",
  Button20 = "BUTTON20",
  Button21 = "BUTTON21",
  Button22 = "BUTTON22",
  Button23 = "BUTTON23",
  Button24 = "BUTTON24",
  Button25 = "BUTTON25",
  Button26 = "BUTTON26",
  Button27 = "BUTTON27",
  Button28 = "BUTTON28",
  Button29 = "BUTTON29",
  Button30 = "BUTTON30",
  Button31 = "BUTTON31",
}

function AuctionatorKeyBindingConfigMixin:OnKeyDown(keyOrButton)
  if GetBindingFromClick(keyOrButton) == "SCREENSHOT" then
    TakeScreenshot()
    return
  elseif keyOrButton == "ESCAPE" then
    self:SetShortcut("")
    self:StopListening()
    return
  end

  local keyPressed = mouseButtonNameConversion[keyOrButton] or keyOrButton
  if not (metaKeys[keyPressed] ~= nil or ignoredKeys[keyPressed] == true) then
    local chord = {}

    if IsAltKeyDown() then table.insert(chord, "ALT") end
    if IsControlKeyDown() then table.insert(chord, "CTRL") end
    if IsShiftKeyDown() then table.insert(chord, "SHIFT") end
    if not metaKeys[keyPressed] ~= nil then table.insert(chord, keyPressed) end

    keyPressed = table.concat(chord, "-")
    self:SetShortcut(keyPressed)
  end
  self:StopListening()
end
