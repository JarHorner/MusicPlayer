
SLASH_OPENTABLE1 = "/showlt"

-- the command function that toggles the loot table
local function OpenKeyLevelLoot()
    ToggleLootTable()
end

SlashCmdList["OPENTABLE"] = OpenKeyLevelLoot

local chatFrame = DEFAULT_CHAT_FRAME

-- Prints a messge on the command in the chat frame when the player logs in
local function CommandMessage()
    chatFrame:AddMessage("To open the Mythic+ Loot Table without the icon, use the command /showlt", 0.1, 0.9, 0.8)
end
CommandMessage()