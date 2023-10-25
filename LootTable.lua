myTable = CreateFrame("Frame", "MyTable", UIParent, "BackdropTemplate")

-- a hard-coded loot table data because the API call to get these values does not when loading addon
local lootTableData = {{0, "", 0, ""}, {402, "Veteran 1/8", 415, "Champion 1/8"},
                       {405, "Veteran 2/8", 418, "Champion 1/8"}, {405, "Veteran 2/8", 421, "Champion 2/8"},
                       {408, "Veteran 3/8", 421, "Champion 2/8"}, {408, "Veteran 3/8", 424, "Champion 3/8"},
                       {411, "Veteran 4/8", 424, "Champion 3/8"}, {411, "Veteran 4/8", 428, "Hero 1/5"},
                       {415, "Champion 1/8", 428, "Hero 1/5"}, {415, "Champion 1/8", 431, "Hero 2/5"},
                       {418, "Champion 2/8", 431, "Hero 2/5"}, {418, "Champion 2/8", 434, "Hero 3/5"},
                       {421, "Champion 3/8", 434, "Hero 3/5"}, {421, "Champion 3/8", 437, "Hero 4/5"},
                       {424, "Champion 4/8", 437, "Hero 4/5"}, {424, "Champion 4/8", 441, "Myth 1/3"},
                       {428, "Hero 1/5", 441, "Myth 1/3"}, {428, "Hero 1/5", 444, "Myth 2/3"},
                       {431, "Hero 2/5", 444, "Myth 2/3"}, {431, "Hero 2/5", 447, "Myth 3/3"}}

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
    myTable:SetSize(450, 570)
    myTable:SetBackdrop(BACKDROP_TUTORIAL_16_16)
    myTable:SetMovable(true)
    myTable:EnableMouse(true)
    myTable:RegisterForDrag("LeftButton")
    myTable:Hide()
    -- myTable:SetScale(SavedVariables.tableScale)

    local label = myTable:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    label:SetPoint("TOP", myTable, "TOP", 0, -8)
    label:SetText("Mythic + Loot Table")
    label:SetFont("Fonts\\FRIZQT__.TTF", 18)
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
    headers:SetPoint("TOP", myTable, "TOP", 0, padding)

    local levelHeader = headers:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    levelHeader:SetPoint("CENTER", headers, "CENTER", -150, 0)
    levelHeader:SetText("Level")
    levelHeader:SetTextColor(1, 1, 1)
    levelHeader:SetScale(1.2)

    local completionHeader = headers:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    completionHeader:SetPoint("CENTER", headers, "CENTER", -30, 0)
    completionHeader:SetText("End of Dungeon")
    completionHeader:SetTextColor(1, 1, 1)
    completionHeader:SetScale(1.2)

    local weeklyHeader = headers:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    weeklyHeader:SetPoint("CENTER", headers, "CENTER", 110, 0)
    weeklyHeader:SetText("Vault")
    weeklyHeader:SetTextColor(1, 1, 1)
    weeklyHeader:SetScale(1.2)

    padding = padding + -25

    for i = 2, 20, 1 do

        local cell = CreateFrame("Frame", "MyAddonTableCell", myTable, "BackdropTemplate")
        cell:SetSize(420, 25)
        cell:SetBackdrop(BACKDROP_TUTORIAL_16_16)
        cell:SetPoint("TOP", myTable, "TOP", 0, padding)

        local keyLevel = cell:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        keyLevel:SetPoint("CENTER", cell, "CENTER", -180, 0)
        keyLevel:SetText(i)
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
    explanation:SetText("Upgrade Level of the gear is in the brackets")
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
