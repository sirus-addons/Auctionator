AuctionatorEscapeToCloseMixin = {}

function AuctionatorEscapeToCloseMixin:OnShow()
  SetOverrideBinding(self, true, "ESCAPE", string.format("CLICK %s:RightButton", self:GetName()))
end

function AuctionatorEscapeToCloseMixin:OnHide()
  ClearOverrideBindings(self)
end
