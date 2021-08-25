local TAB_PADDING = 20;

AuctionatorSellingMiniTabButtonMixin = {}

function AuctionatorSellingMiniTabButtonMixin:OnLoad()
  self.LeftDisabled:SetPoint("TOPLEFT")
  self.deselectedTextY = 6
  self.selectedTextY = 2
end

function AuctionatorSellingMiniTabButtonMixin:OnShow()
  PanelTemplates_TabResize(self, TAB_PADDING)
end

function AuctionatorSellingMiniTabButtonMixin:OnClick()
  PanelTemplates_Tab_OnClick(self, self:GetParent())
  self:GetParent():SetView(self:GetID())

  PlaySound(SOUNDKIT.IG_CHARACTER_INFO_TAB)
end
