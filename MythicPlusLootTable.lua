
SLASH_CHECKSCORE1 = "/cs"


local function checkScoreHandler()

    local weeklyRewardLevel, endOfRunRewardLevel = C_MythicPlus.GetRewardLevelForDifficultyLevel(20)
    print("weekly reward for a 20 key is " .. weeklyRewardLevel)
    print("End of run reward for a 20 key is " .. endOfRunRewardLevel)
end

SlashCmdList["SOUND"] = playSoundHandler
SlashCmdList["STOPSOUND"] = stopSoundHandler
SlashCmdList["CHECKSCORE"] = checkScoreHandler

