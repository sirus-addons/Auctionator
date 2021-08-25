AuctionatorTabMixin = {}

function AuctionatorTabMixin:Initialize(name, tabTemplate, tabHeader, displayMode)
  Auctionator.Debug.Message("AuctionatorTabMixin:Initialize()")

  AuctionHouseFrameDisplayMode[name] = displayMode

  self.ahTitle = tabHeader
  self.displayMode = displayMode
  self:SetAttribute("displayMode", name)

  PanelTemplates_DeselectTab(self)

  -- Create this tab's frame
  self.frameRef = CreateFrame(
    "FRAME",
    displayMode[1],
    AuctionHouseFrame,
    tabTemplate
  )
  self.frameRef:Hide()
  AuctionHouseFrame.tabsForDisplayMode[name] = #AuctionHouseFrame.Tabs

  self:SetPoint("LEFT", AuctionHouseFrame.Tabs[#AuctionHouseFrame.Tabs - 1], "RIGHT", -15, 0)
end

function AuctionatorTabMixin:Selected()
  PanelTemplates_SetTab(AuctionHouseFrame, self)
  PanelTemplates_SelectTab(self)

  PortraitFrameTemplate_SetTitle(AuctionHouseFrame, self.ahTitle)
end

function AuctionatorTabMixin:DeselectTab()
  PanelTemplates_DeselectTab(self)
  self.frameRef:Hide()
end

function AuctionatorTabMixin:OnShow()
  if not Auctionator.Config.Get(Auctionator.Config.Options.SMALL_TABS) then
    PanelTemplates_TabResize(self, 20)
  end
end
