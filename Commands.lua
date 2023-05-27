
local keyLevelLoot = {
    
}

local function getKeyLevelLoot()
    for i = 2, 20, 1 do
        keyLevelLoot[i] = {}
        local weeklyRewardLevel, endOfRunRewardLevel = C_MythicPlus.GetRewardLevelForDifficultyLevel(i)
        keyLevelLoot[i][1] = weeklyRewardLevel
        keyLevelLoot[i][2] = endOfRunRewardLevel
        print(keyLevelLoot[i][1] .. " " .. keyLevelLoot[i][2])
    end
end

SLASH_TEST1 = "/test"



local function testing()
    getKeyLevelLoot()
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
