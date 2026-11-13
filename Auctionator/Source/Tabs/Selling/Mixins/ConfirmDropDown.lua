AuctionatorConfirmDropDownMixin = {}

local QUOTE_EVENTS = {
  "COMMODITY_PRICE_UPDATED",
  "COMMODITY_PRICE_UNAVAILABLE",
}

StaticPopupDialogs[Auctionator.Constants.DialogNames.BuyAuction] = {
  text = "%s\n" .. BUYOUT_AUCTION_CONFIRMATION .. " %s",
  button1 = ACCEPT,
  button2 = CANCEL,
  OnAccept = function(self, frame)
    frame:Confirm()
  end,
  OnHide = function(self, frame)
    frame:CancelPurchase()
  end,
  timeout = 0,
  exclusive = 1,
  whileDead = 1,
  hideOnEscape = 1
}

function AuctionatorConfirmDropDownMixin:OnLoad()
  Auctionator.EventBus:Register(self, {
    Auctionator.Selling.Events.ConfirmCallback,
    Auctionator.AH.Events.Ready,
  })
end

function AuctionatorConfirmDropDownMixin:OnHide()
  self.waitingForThrottle = false
  StaticPopup_Hide(Auctionator.Constants.DialogNames.BuyAuction)
  self:CancelPurchase()
end

function AuctionatorConfirmDropDownMixin:OnEvent(event, unitPrice, totalPrice)
  FrameUtil.UnregisterFrameForCustomEvents(self, QUOTE_EVENTS)

  if event == "COMMODITY_PRICE_UPDATED" then
    self:ShowDialog(select(2, GetItemInfo(self.data.itemID)) or "", self.data.quantity, totalPrice)
  else
    self.commoditiesPurchaseOngoing = false
    UIErrorsFrame:AddMessage(AUCTION_HOUSE_DIALOG_PRICE_UNAVAILABLE, 1.0, 0.1, 0.1, 1.0)
  end
end

function AuctionatorConfirmDropDownMixin:ReceiveEvent(event, ...)
  if event == Auctionator.Selling.Events.ConfirmCallback then
    self:Callback(...)
  elseif event == Auctionator.AH.Events.Ready and self.waitingForThrottle then
    self:StartPurchase()
  end
end

function AuctionatorConfirmDropDownMixin:Callback(itemInfo)
  StaticPopup_Hide(Auctionator.Constants.DialogNames.BuyAuction)
  self:CancelPurchase()

  self.data = itemInfo
  self:StartPurchase()
end

function AuctionatorConfirmDropDownMixin:StartPurchase()
  self.waitingForThrottle = not Auctionator.AH.IsNotThrottled()
  if self.waitingForThrottle then
    return
  end

  if self.data.itemType == Auctionator.Constants.ITEM_TYPES.COMMODITY then
    self.commoditiesPurchaseOngoing = true
    FrameUtil.RegisterFrameForCustomEvents(self, QUOTE_EVENTS)
    C_AuctionHouse.StartCommoditiesPurchase(self.data.itemID, self.data.quantity)
  else
    self:ShowDialog(self.data.itemLink, 1, self.data.price)
  end
end

function AuctionatorConfirmDropDownMixin:ShowDialog(itemLink, quantity, price)
  local priceText = Auctionator.Utilities.CreateMoneyString(price)
  if price > self.data.price * quantity then
    priceText = priceText .. "\n" .. RED_FONT_COLOR:WrapTextInColorCode(AUCTION_HOUSE_DIALOG_PRICE_UPDATED)
  end

  StaticPopup_Show(
    Auctionator.Constants.DialogNames.BuyAuction,
    AUCTION_HOUSE_DIALOG_ITEM_FORMAT:format(itemLink, quantity),
    priceText,
    self
  )
end

function AuctionatorConfirmDropDownMixin:Confirm()
  if self.data.itemType == Auctionator.Constants.ITEM_TYPES.ITEM then
    C_AuctionHouse.PlaceBid(self.data.auctionID, self.data.price)
  else
    self.commoditiesPurchaseOngoing = false
    C_AuctionHouse.ConfirmCommoditiesPurchase(self.data.itemID, self.data.quantity)
  end
  PlaySound(SOUNDKIT.IG_MAINMENU_OPEN)
end

function AuctionatorConfirmDropDownMixin:CancelPurchase()
  if self.commoditiesPurchaseOngoing then
    self.commoditiesPurchaseOngoing = false
    FrameUtil.UnregisterFrameForCustomEvents(self, QUOTE_EVENTS)
    C_AuctionHouse.CancelCommoditiesPurchase()
  end
end
