AuctionatorConfigQuantitiesFrameMixin = CreateFromMixins(AuctionatorPanelConfigMixin)

function AuctionatorConfigQuantitiesFrameMixin:OnLoad()
  Auctionator.Debug.Message("AuctionatorConfigQuantitiesFrameMixin:OnLoad()")

  self.name = AUCTIONATOR_L_CONFIG_QUANTITIES_CATEGORY
  self.parent = "Auctionator"

  self:SetupPanel()

  self.Quantities = {
	"WeaponQuantity",
	"ArmorQuantity",
	"ContainerQuantity",
	"ConsumableQuantity",
	"GlyphQuantity",
	"TradeGoodsQuantity",
	"AmmoQuantity",
	"QuiverQuantity",
	"RecipesQuantity",
	"GemQuantity",
	"QuestQuantity",
	"MiscQuantity",
  }
end

function AuctionatorConfigQuantitiesFrameMixin:OnShow()
  Auctionator.Debug.Message("AuctionatorConfigQuantitiesFrameMixin:OnShow()")

  local settings = Auctionator.Config.Get(Auctionator.Config.Options.DEFAULT_QUANTITIES)
  for _, quantityName in ipairs(self.Quantities) do
    local quantityOption = self[quantityName]
    quantityOption:SetNumber(settings[_G[quantityOption:GetAttribute("classID")]])
  end
end

function AuctionatorConfigQuantitiesFrameMixin:Save()
  Auctionator.Debug.Message("AuctionatorConfigQuantitiesFrameMixin:Save()")

  local settings = Auctionator.Config.Get(Auctionator.Config.Options.DEFAULT_QUANTITIES)
  for _, quantityName in ipairs(self.Quantities) do
    local quantityOption = self[quantityName]
    settings[_G[quantityOption:GetAttribute("classID")]] = quantityOption:GetNumber()
  end
end

function AuctionatorConfigQuantitiesFrameMixin:Cancel()
  Auctionator.Debug.Message("AuctionatorConfigQuantitiesFrameMixin:Cancel()")
end
