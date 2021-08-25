AuctionatorTranslatorMixin = CreateFromMixins(AuctionatorConfigTooltipMixin)

function AuctionatorTranslatorMixin:OnLoad()
  self.FlagTexture:SetTexture(self:GetAttribute("textureLocation"))
  self.TranslatorsText:SetText(self:GetAttribute("translators"))
end
