

local function OnTooltipSetItem(tooltip, data)
    if string.match(data.lines[1].leftText, "Keystone") then
        if tooltip == GameTooltip then

            local keyLevel = string.sub(data.lines[2].leftText, 14, 16)
            local weeklyRewardLevel, endOfRunRewardLevel = C_MythicPlus.GetRewardLevelForDifficultyLevel(keyLevel)

            tooltip:AddLine(" ")
            tooltip:AddLine("Mythic Plus Loot Table", 1, 1, 1)
            tooltip:AddDoubleLine("Completion: ", endOfRunRewardLevel .. " ilvl", 1, 1, 1)
            tooltip:AddDoubleLine("Weekly: ", weeklyRewardLevel .. " ilvl", 1, 1, 1)

        end
    end
end

-- Replace 'Enum.TooltipDataType.Item' with an appropriate type for the tooltip
-- data you are wanting to process; eg. use 'Enum.TooltipDataType.Spell' for
-- replacing usage of OnTooltipSetSpell.
--
-- If you wish to respond to all tooltip data updates, you can instead replace
-- the enum with 'TooltipDataProcessor.AllTypes' (or the string "ALL").

TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, OnTooltipSetItem)