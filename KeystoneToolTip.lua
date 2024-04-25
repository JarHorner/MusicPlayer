local MPLT = MPLT

function OnTooltipSetItem(tooltip, data)
    if string.match(data.lines[1].leftText, "Keystone:") then
        if tooltip == GameTooltip then
            local keyLevel = tonumber(string.sub(data.lines[2].leftText, 14, 16))
            if keyLevel <= 10 then
                local endOfRunRewardLevel = lootTableData[keyLevel][1] .. " | " .. lootTableData[keyLevel][2]
                local weeklyRewardLevel = lootTableData[keyLevel][3] .. " | " .. lootTableData[keyLevel][4]

                tooltip:AddLine(" ")
                tooltip:AddLine(MPLT["Addon Name"], 1, 1, 1)
                tooltip:AddDoubleLine(MPLT["Keystone Hover Text 1"], endOfRunRewardLevel, 1, 1, 1)
                tooltip:AddDoubleLine(MPLT["Keystone Hover Text 2"], weeklyRewardLevel, 1, 1, 1)
            else
                local endOfRunRewardLevel = lootTableData[10][1] .. " | " .. lootTableData[10][2]
                local weeklyRewardLevel = lootTableData[10][3] .. " | " .. lootTableData[10][4]

                tooltip:AddLine(" ")
                tooltip:AddLine(MPLT["Addon Name"], 1, 1, 1)
                tooltip:AddDoubleLine(MPLT["Keystone Hover Text 1"], endOfRunRewardLevel, 1, 1, 1)
                tooltip:AddDoubleLine(MPLT["Keystone Hover Text 2"], weeklyRewardLevel, 1, 1, 1)
            end
        end
    end
end
