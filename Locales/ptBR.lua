if not ((GAME_LOCALE or GetLocale()) == "ptBR") then
    return
  end
local addonName, MDT = ...
local L = MDT.L
L = L or {}
L["Startup Message"] = "Para abrir o Mythic+ Loot Table, usar /showlt. Para abrir as configurações, use /ltsettings"
