
SLASH_TEST1 = "/test"


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

SlashCmdList["TEST"] = testing
