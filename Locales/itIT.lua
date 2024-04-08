if not ((GAME_LOCALE or GetLocale()) == "itIT") then
    return
  end
local addonName, MDT = ...
local L = MDT.L
L = L or {}
L["Startup Message"] = "Per aprire il Mythic+ Loot Table, utilizzo /showlt. Per aprire le impostazioni, utilizzare /ltsettings"