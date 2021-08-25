local ICON_COPPER = "|TInterface\\MoneyFrame\\UI-CopperIcon:12:12|t"
local ICON_SILVER = "|TInterface\\MoneyFrame\\UI-SilverIcon:12:12|t"
local ICON_GOLD = "|TInterface\\MoneyFrame\\UI-GoldIcon:12:12|t"

function Auctionator.Utilities.CreateMoneyString(count)
  local value = math.abs(count)
  local gold = math.floor(value / 10000)
  local silver = math.floor(math.fmod(value / 100, 100))
  local copper = math.floor(math.fmod(value, 100))
  local str = ""

  if gold > 0 then
    str = string.format("%s%s%s", gold, ICON_GOLD, (silver > 0 or copper > 0) and " " or "")
  end

  if silver > 0 then
    str = string.format("%s%s%s%s", str, silver, ICON_SILVER, copper > 0 and " " or "")
  end

  if copper > 0 or value == 0 then
    str = string.format("%s%s%s", str, copper, ICON_COPPER)
  end

  return Auctionator.Utilities.DelimitThousands(str)
end
