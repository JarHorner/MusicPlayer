
-- Creation of loot table that displays all loot information
function CreateLootTable()
    local myFrame = CreateFrame("Frame", "MyFrame", UIParent, "UIPanelDialogTemplate")

    myFrame:SetPoint("LEFT", UIParent, "LEFT")
    myFrame:SetSize(400, 450)
    myFrame:SetMovable(true)
    myFrame:EnableMouse(true)
    myFrame:RegisterForDrag("LeftButton")

    local label = myFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    label:SetPoint("TOP", myFrame, "TOP", 0, -7)
    label:SetText("Mythic + Loot Table")
    label:SetFont("Fonts\\FRIZQT__.TTF", 16)

    local padding = -32
    for i = 2, 20, 1 do
        local weeklyRewardLevel, endOfRunRewardLevel = C_MythicPlus.GetRewardLevelForDifficultyLevel(i)
        local keyLevel = myFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        keyLevel:SetPoint("TOPLEFT", myFrame, "TOPLEFT", 15, padding)
        keyLevel:SetText("Level: " .. i)

        local completion = myFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        completion:SetPoint("TOP", myFrame, "TOP", 0, padding)
        completion:SetText("Completion: " .. endOfRunRewardLevel)

        local weekly = myFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        weekly:SetPoint("TOPRIGHT", myFrame, "TOPRIGHT", -15, padding)
        weekly:SetText("Weekly: " .. weeklyRewardLevel)

        padding = padding + -22
    end

    myFrame:SetScript("OnDragStart", function(self, button)
        self:StartMoving()
    end)
    myFrame:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
    end)
    tinsert(UISpecialFrames, "MyFrame")
    return myFrame
end


