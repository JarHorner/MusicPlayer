local MPLT = MPLT

myTable = CreateFrame("Frame", "MyTable", UIParent, "BackdropTemplate")

function ChangeTableScale(scale)
    if ElvUI then
        -- If ElvUI is present, use its scale system
        myTable:SetScale(UIParent:GetEffectiveScale() * scale)
    else
        -- If ElvUI is not present, use the default SetScale method
        myTable:SetScale(scale)
    end
end

-- Creation of loot table that displays all loot information
local function CreateLootTable()

    -- Uses saved variables to keep the position of the table stay the same from where you last left it
    
    myTable:SetSize(450, 400)

    myTable:SetBackdrop(BACKDROP_TUTORIAL_16_16)
    myTable:SetMovable(true)
    myTable:EnableMouse(true)
    myTable:RegisterForDrag("LeftButton")
    myTable:Hide()
    myTable:SetScale(SavedVariables.tableScale)

    local label = myTable:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    
    label:SetPoint("TOP", myTable, "TOP", 0, -10)

    label:SetText(MPLT["Addon Name"])

    label:SetFont("Fonts\\FRIZQT__.TTF", 20)


    label:SetTextColor(1, 1, 1)
    label:SetScale(1.2)

    local exitButton = CreateFrame("Button", "MyButton", myTable, "BigRedExitButtonTemplate")
    exitButton:SetSize(30, 30)
    exitButton:SetPoint("TOPRIGHT")
    exitButton:SetScript("OnClick", function()
        ToggleLootTable()
    end)

    -- creates and fills the information of the table
    local padding = -40

    local headers = CreateFrame("Frame", "MyAddonTableCell", myTable, "BackdropTemplate")
    headers:SetSize(420, 25)
    headers:SetBackdrop(nil)

    headers:SetPoint("TOP", myTable, "TOP", 0, padding + -20)

    local levelHeader = headers:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    levelHeader:SetPoint("CENTER", headers, "CENTER", -150, 0)
    levelHeader:SetText(MPLT["Level Header"])
    levelHeader:SetTextColor(1, 1, 1)
    levelHeader:SetScale(1.2)

    local completionHeader = headers:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    completionHeader:SetPoint("CENTER", headers, "CENTER", -30, 0)
    completionHeader:SetText(MPLT["End of Dungeon Header"])
    completionHeader:SetTextColor(1, 1, 1)
    completionHeader:SetScale(1.2)

    local weeklyHeader = headers:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    weeklyHeader:SetPoint("CENTER", headers, "CENTER", 110, 0)
    weeklyHeader:SetText(MPLT["Vault Header"])
    weeklyHeader:SetTextColor(1, 1, 1)
    weeklyHeader:SetScale(1.2)

    padding = padding + -45

    for i = 1, 11, 1 do
        local cell = CreateFrame("Frame", "MyAddonTableCell", myTable, "BackdropTemplate")
        cell:SetSize(420, 25)
        cell:SetBackdrop(BACKDROP_TUTORIAL_16_16)
        cell:SetPoint("TOP", myTable, "TOP", 0, padding)

        local keyLevel = cell:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        keyLevel:SetPoint("CENTER", cell, "CENTER", -180, 0)
        if (i == 1) then
            keyLevel:SetText("H")
        end
        if (i == 2) then
            keyLevel:SetText("0")
        end
        if (i > 2) then
            keyLevel:SetText(i - 1)
        end
        
        keyLevel:SetTextColor(1, 1, 1)

        local completion = cell:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        completion:SetPoint("CENTER", cell, "CENTER", -30, 0)
        completion:SetText(lootTableData[i][1] .. " (" .. lootTableData[i][2] .. ")")

        local weekly = cell:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        weekly:SetPoint("CENTER", cell, "CENTER", 130, 0)
        weekly:SetText(lootTableData[i][3] .. " (" .. lootTableData[i][4] .. ")")

        padding = padding + -25
    end

    local bracketsExplanation = CreateFrame("Frame", "MyAddonTableCell", myTable, "BackdropTemplate")
    bracketsExplanation:SetSize(350, 25)
    bracketsExplanation:SetBackdrop(nil)
    bracketsExplanation:SetPoint("TOP", myTable, "TOP", 0, padding)

    local explanation = bracketsExplanation:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    explanation:SetPoint("CENTER", bracketsExplanation, "CENTER", 0, 0)
    explanation:SetText(MPLT["Table Note"])
    explanation:SetTextColor(1, 1, 1)
    explanation:SetScale(1.1)

    -- setting scripts to the main frame
    myTable:SetScript("OnDragStart", function(self, button)
        self:StartMoving()
    end)
    myTable:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()

        local point, relativeTo, relativePoint, x, y = myTable:GetPoint()

        SavedVariables.tablePoint = point
        SavedVariables.tableRelativePoint = relativePoint
        SavedVariables.tableX = x
        SavedVariables.tableY = y
    end)
    tinsert(UISpecialFrames, "MyTable")

    return myTable
end

local f = CreateFrame("Frame", "LootTable")

-- event creates the loot table
local function OnEvent(self, event, ...)
    lootTable = CreateLootTable()

    f:UnregisterEvent("PLAYER_LOGIN")
end

-- Registering the PLAYER_LOGIN event
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", OnEvent)
