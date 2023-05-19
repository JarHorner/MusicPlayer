
SLASH_CHECKLOOT1 = "/lt"
SLASH_TEST1 = "/test"

local function checkLootHandler()
    ToggleLootTable()
end

local function testing()
    local isMythicPlusActive = C_MythicPlus.IsMythicPlusActive()
    if (isMythicPlusActive) then
        print("In M+")
    else
        print("Not M+")
    end
    local challengeModeActive = C_ChallengeMode.IsChallengeModeActive()
    if (challengeModeActive) then
        print("In challenge")
    else
        print("Not challenge")
    end
end

SlashCmdList["CHECKLOOT"] = checkLootHandler
SlashCmdList["TEST"] = testing
