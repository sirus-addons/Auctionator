local UNCOMMON	= 2;
local RARE		= 3;
local EPIC		= 4;

local WEAPON = 2;
local ARMOR  = 4;

local LESSER_MAGIC		= 10938;
local GREATER_MAGIC		= 10939;
local STRANGE_DUST		= 10940;

local SMALL_GLIMMERING	= 10978;
local LESSER_ASTRAL		= 10998;

local GREATER_ASTRAL	= 11082;
local SOUL_DUST			= 11083;
local LARGE_GLIMMERING	= 11084;

local LESSER_MYSTIC		= 11134;
local GREATER_MYSTIC	= 11135;
local VISION_DUST		= 11137;
local SMALL_GLOWING		= 11138;
local LARGE_GLOWING		= 11139;

local LESSER_NETHER		= 11174;
local GREATER_NETHER	= 11175;
local DREAM_DUST		= 11176;
local SMALL_RADIANT		= 11177;
local LARGE_RADIANT		= 11178;

local SMALL_BRILLIANT	= 14343;
local LARGE_BRILLIANT	= 14344;

local LESSER_ETERNAL	= 16202;
local GREATER_ETERNAL	= 16203;
local ILLUSION_DUST		= 16204;

local NEXUS_CRYSTAL		= 20725;

local ARCANE_DUST		= 22445;
local GREATER_PLANAR	= 22446;
local LESSER_PLANAR		= 22447;
local SMALL_PRISMATIC	= 22448;
local LARGE_PRISMATIC	= 22449;
local VOID_CRYSTAL		= 22450;

local DREAM_SHARD		= 34052;
local SMALL_DREAM		= 34053;

local INFINITE_DUST		= 34054;
local GREATER_COSMIC	= 34055;
local LESSER_COSMIC		= 34056;
local ABYSS_CRYSTAL		= 34057;

local function CopyDeep(src)
  local result = {};
  for n, v in pairs (src) do
    if (type(v) == "table") then
      result[n] = CopyDeep(v);
    else
      result[n] = v;
    end
  end
  return result;
end

Auctionator.Enchant.DE_KEY = function(itemType, itemRarity)
  local key = tostring(itemType).."_"..itemRarity
  return key;
end

Auctionator.Enchant.DE_INSERT = function(t, info)
  local entry = {};
  entry[1] = info[1];
  entry[2] = info[2];

  local n = 3;

  for x = 3, #info, 3 do
    local nums = info[x+1];
    if (type(nums) == "number") then
      entry[n] = info[x];
      entry[n + 1] = info[x + 1];
      entry[n + 2] = info[x + 2];
      n = n + 3;
    else
      for i = nums[1], nums[2] do
        entry[n] = info[x] / (nums[2] - nums[1] + 1);
        entry[n + 1] = i;
        entry[n + 2] = info[x + 2];
        n = n + 3;				
      end
    end
  end

  table.insert(t, entry);
end

-- TODO: Enchant
Auctionator.Enchant.DE_TABLE = {}

local deInsert = Auctionator.Enchant.DE_INSERT

Auctionator.Enchant.DE_TABLE[Auctionator.Enchant.DE_KEY(ARMOR, UNCOMMON)] = {};

local deTable = Auctionator.Enchant.DE_TABLE[Auctionator.Enchant.DE_KEY(ARMOR, UNCOMMON)];
deInsert(deTable, {5, 15, 80, {1,2}, STRANGE_DUST, 20, {1,2}, LESSER_MAGIC});
deInsert(deTable, {16, 20, 75, {2,3}, STRANGE_DUST, 20, {1,2}, GREATER_MAGIC, 5, 1, SMALL_GLIMMERING});
deInsert(deTable, {21, 25, 75, {4,6}, STRANGE_DUST, 15, {1,2}, LESSER_ASTRAL, 10, 1, SMALL_GLIMMERING});
deInsert(deTable, {26, 30, 75, {1,2}, SOUL_DUST, 20, {1,2}, GREATER_ASTRAL, 5, 1, LARGE_GLIMMERING});
deInsert(deTable, {31, 35, 75, {2,5}, SOUL_DUST, 20, {1,2}, LESSER_MYSTIC, 5, 1, SMALL_GLOWING});
deInsert(deTable, {36, 40, 75, {1,2}, VISION_DUST, 20, {1,2}, GREATER_MYSTIC, 5, 1, LARGE_GLOWING});
deInsert(deTable, {41, 45, 75, {2,5}, VISION_DUST, 20, {1,2}, LESSER_NETHER, 5, 1, SMALL_RADIANT});
deInsert(deTable, {46, 50, 75, {1,2}, DREAM_DUST, 20, {1,2}, GREATER_NETHER, 5, 1, LARGE_RADIANT});
deInsert(deTable, {51, 55, 75, {2,5}, DREAM_DUST, 20, {1,2}, LESSER_ETERNAL, 5, 1, SMALL_BRILLIANT});
deInsert(deTable, {56, 60, 75, {1,2}, ILLUSION_DUST, 20, {1,2}, GREATER_ETERNAL, 5, 1, LARGE_BRILLIANT});
deInsert(deTable, {61, 65, 75, {2,5}, ILLUSION_DUST, 20, {2,3}, GREATER_ETERNAL, 5, 1, LARGE_BRILLIANT});
deInsert(deTable, {66, 80, 75, {1,3}, ARCANE_DUST, 22, {1,3}, LESSER_PLANAR, 3, 1, SMALL_PRISMATIC});
deInsert(deTable, {81, 99, 75, {2,3}, ARCANE_DUST, 22, {2,3}, LESSER_PLANAR, 3, 1, SMALL_PRISMATIC});
deInsert(deTable, {100, 120, 75, {2,5}, ARCANE_DUST, 22, {1,2}, GREATER_PLANAR, 3, 1, LARGE_PRISMATIC});
deInsert(deTable, {121, 151, 75, {1,3}, INFINITE_DUST, 22, {1,2}, LESSER_COSMIC, 3, 1, SMALL_DREAM});
deInsert(deTable, {152, 200, 75, {4,7}, INFINITE_DUST, 22, {1,2}, GREATER_COSMIC, 3, 1, DREAM_SHARD});

Auctionator.Enchant.DE_TABLE[Auctionator.Enchant.DE_KEY(WEAPON, UNCOMMON)] = {};

deTable = Auctionator.Enchant.DE_TABLE[Auctionator.Enchant.DE_KEY(WEAPON, UNCOMMON)];
deInsert(deTable, {6, 15, 20, {1,2}, STRANGE_DUST, 80, {1,2}, LESSER_MAGIC});
deInsert(deTable, {16, 20, 20, {2,3}, STRANGE_DUST, 75, {1,2}, GREATER_MAGIC, 5, 1, SMALL_GLIMMERING});
deInsert(deTable, {21, 25, 15, {4,6}, STRANGE_DUST, 75, {1,2}, LESSER_ASTRAL, 10, 1, SMALL_GLIMMERING});
deInsert(deTable, {26, 30, 20, {1,2}, SOUL_DUST, 75, {1,2}, GREATER_ASTRAL, 5, 1, LARGE_GLIMMERING});
deInsert(deTable, {31, 35, 20, {2,5}, SOUL_DUST, 75, {1,2}, LESSER_MYSTIC, 5, 1, SMALL_GLOWING});
deInsert(deTable, {36, 40, 20, {1,2}, VISION_DUST, 75, {1,2}, GREATER_MYSTIC, 5, 1, LARGE_GLOWING});
deInsert(deTable, {41, 45, 20, {2,5}, VISION_DUST, 75, {1,2}, LESSER_NETHER, 5, 1, SMALL_RADIANT});
deInsert(deTable, {46, 50, 20, {1,2}, DREAM_DUST, 75, {1,2}, GREATER_NETHER, 5, 1, LARGE_RADIANT});
deInsert(deTable, {51, 55, 22, {2,5}, DREAM_DUST, 75, {1,2}, LESSER_ETERNAL, 5, 1, SMALL_BRILLIANT});
deInsert(deTable, {56, 60, 22, {1,2}, ILLUSION_DUST, 75, {1,2}, GREATER_ETERNAL, 5, 1, LARGE_BRILLIANT});
deInsert(deTable, {61, 65, 22, {2,5}, ILLUSION_DUST, 75, {2,3}, GREATER_ETERNAL, 5, 1, LARGE_BRILLIANT});
deInsert(deTable, {66, 99, 22, {2,3}, ARCANE_DUST, 75, {2,3}, LESSER_PLANAR, 3, 1, SMALL_PRISMATIC});
deInsert(deTable, {100, 120, 22, {2,5}, ARCANE_DUST, 75, {1,2}, GREATER_PLANAR, 3, 1, LARGE_PRISMATIC});
deInsert(deTable, {121, 151, 22, {1,3}, INFINITE_DUST, 75, {1,2}, LESSER_COSMIC, 3, 1, SMALL_DREAM});
deInsert(deTable, {152, 200, 22, {4,7}, INFINITE_DUST, 75, {1,2}, GREATER_COSMIC, 3, 1, DREAM_SHARD});

Auctionator.Enchant.DE_TABLE[Auctionator.Enchant.DE_KEY(ARMOR, RARE)] = {};

deTable = Auctionator.Enchant.DE_TABLE[Auctionator.Enchant.DE_KEY(ARMOR, RARE)];
deInsert(deTable, {11, 25, 100, 1, SMALL_GLIMMERING});
deInsert(deTable, {26, 30, 100, 1, LARGE_GLIMMERING});
deInsert(deTable, {31, 35, 100, 1, SMALL_GLOWING});
deInsert(deTable, {36, 40, 100, 1, LARGE_GLOWING});
deInsert(deTable, {41, 45, 100, 1, SMALL_RADIANT});
deInsert(deTable, {46, 50, 100, 1, LARGE_RADIANT});
deInsert(deTable, {51, 55, 100, 1, SMALL_BRILLIANT});
deInsert(deTable, {56, 65, 99.5, 1, LARGE_BRILLIANT, 0.5, 1, NEXUS_CRYSTAL});
deInsert(deTable, {66, 99, 99.5, 1, SMALL_PRISMATIC, 0.5, 1, NEXUS_CRYSTAL});
deInsert(deTable, {100, 120, 99.5, 1, LARGE_PRISMATIC, 0.5, 1, VOID_CRYSTAL});
deInsert(deTable, {121, 164, 99.5, 1, SMALL_DREAM, 0.5, 1, ABYSS_CRYSTAL});
deInsert(deTable, {165, 999, 99.5, 1, DREAM_SHARD, 0.5, 1, ABYSS_CRYSTAL});

Auctionator.Enchant.DE_TABLE[Auctionator.Enchant.DE_KEY(WEAPON, RARE)] = Auctionator.Enchant.DE_TABLE[Auctionator.Enchant.DE_KEY(ARMOR, RARE)];

Auctionator.Enchant.DE_TABLE[Auctionator.Enchant.DE_KEY(ARMOR, EPIC)] = {};

deTable = Auctionator.Enchant.DE_TABLE[Auctionator.Enchant.DE_KEY(ARMOR, EPIC)];
deInsert(deTable, {40, 45, 100, {2,4}, SMALL_RADIANT});
deInsert(deTable, {46, 50, 100, {2,4}, LARGE_RADIANT});
deInsert(deTable, {51, 55, 100, {2,4}, SMALL_BRILLIANT});
deInsert(deTable, {56, 60, 100, 1, NEXUS_CRYSTAL});
--deInsert(deTable, {61, 80, FILLED IN BELOW
deInsert(deTable, {95, 100, 100, {1,2}, VOID_CRYSTAL});
deInsert(deTable, {105, 164, 33.3, 1, VOID_CRYSTAL, 66.6, 2, VOID_CRYSTAL});
deInsert(deTable, {165, 200, 100, 1, ABYSS_CRYSTAL});
deInsert(deTable, {200, 999, 100, 1, ABYSS_CRYSTAL});

Auctionator.Enchant.DE_TABLE[Auctionator.Enchant.DE_KEY(WEAPON, EPIC)] = CopyDeep(Auctionator.Enchant.DE_TABLE[Auctionator.Enchant.DE_KEY(ARMOR, EPIC)]); -- copy it this time because of differences

deInsert(Auctionator.Enchant.DE_TABLE[Auctionator.Enchant.DE_KEY(ARMOR, EPIC)], {61, 80, 50, 1, NEXUS_CRYSTAL, 50, 2, NEXUS_CRYSTAL});
deInsert(Auctionator.Enchant.DE_TABLE[Auctionator.Enchant.DE_KEY(WEAPON, EPIC)], {61, 80, 33.3, 1, NEXUS_CRYSTAL, 66.6, 2, NEXUS_CRYSTAL});
