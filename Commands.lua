local AddonName, MPLT = ...
local L = MPLT.L

SLASH_OPENTABLE1 = "/showlt"
SLASH_OPENSETTINGS1 = "/ltsettings"

-- the command function that toggles the loot table
local function OpenKeyLevelLoot()
    ToggleLootTable()
end

SlashCmdList["OPENTABLE"] = OpenKeyLevelLoot
SlashCmdList["OPENSETTINGS"] = ToggleLootTableMenu

local chatFrame = DEFAULT_CHAT_FRAME

-- Prints a messge on the command in the chat frame when the player logs in
local function CommandMessage()
    chatFrame:AddMessage(L["Startup Message"], 0.1, 0.9, 0.8)
end
CommandMessage()