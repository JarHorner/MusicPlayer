


-- Creation of loot table that displays all loot information
function CreateLootTable()
    local myFrame = CreateFrame("Frame", "MyFrame", UIParent, "BackdropTemplate")

    myFrame:SetPoint("LEFT", UIParent, "LEFT")
    myFrame:SetSize(420, 520)
    myFrame:SetBackdrop(BACKDROP_TUTORIAL_16_16)
    myFrame:SetMovable(true)
    myFrame:EnableMouse(true)
    myFrame:RegisterForDrag("LeftButton")

    local label = myFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    label:SetPoint("TOP", myFrame, "TOP", 0, -8)
    label:SetText("Mythic + Loot Table")
    label:SetFont("Fonts\\FRIZQT__.TTF", 18)
    label:SetTextColor(1, 1, 1)

    local exitButton = CreateFrame("Button", "MyButton", myFrame, "BigRedExitButtonTemplate")
    exitButton:SetSize(30, 30)
    exitButton:SetPoint("TOPRIGHT")
    exitButton:SetScript("OnClick", function()
        ToggleFrame()
    end)

    local padding = -32
    for i = 2, 20, 1 do

        local cell = CreateFrame("Frame", "MyAddonTableCell1", myFrame, "BackdropTemplate")
        cell:SetSize(350, 25)
        cell:SetBackdrop(BACKDROP_TUTORIAL_16_16)
        cell:SetPoint("TOP", myFrame, "TOP", 0, padding)

        local weeklyRewardLevel, endOfRunRewardLevel = C_MythicPlus.GetRewardLevelForDifficultyLevel(i)
        local keyLevel = cell:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        keyLevel:SetPoint("LEFT", cell, "LEFT", 15, 0)
        keyLevel:SetText("Level: " .. i)
        keyLevel:SetTextColor(1, 1, 1)

        local completion = cell:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        completion:SetPoint("CENTER", cell, "CENTER")
        completion:SetText("Completion: " .. endOfRunRewardLevel)

        local weekly = cell:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        weekly:SetPoint("RIGHT", cell, "RIGHT", -15, 0)
        weekly:SetText("Weekly: " .. weeklyRewardLevel)

        padding = padding + -25
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

