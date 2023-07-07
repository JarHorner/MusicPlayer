
myTable = CreateFrame("Frame", "MyTable", UIParent, "BackdropTemplate")

-- a hard-coded loot table data because the API call to get these values does not when loading addon
local lootTableData = {
    {0, 0},
    {402, 415},
    {405, 418},
    {405, 421},
    {408, 421},
    {408, 424},
    {411, 424},
    {411, 428},
    {415, 428},
    {415, 431},
    {418, 431},
    {418, 434},
    {421, 434},
    {421, 437},
    {424, 437},
    {424, 441},
    {428, 441},
    {428, 444},
    {431, 444},
    {431, 447}
}

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
    myTable:SetSize(420, 520)
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

    local exitButton = CreateFrame("Button", "MyButton", myTable, "BigRedExitButtonTemplate")
    exitButton:SetSize(30, 30)
    exitButton:SetPoint("TOPRIGHT")
    exitButton:SetScript("OnClick", function()
        ToggleLootTable()
    end)

    -- creates and fills the information of the table
    local padding = -32
    for i = 2, 20, 1 do

        local cell = CreateFrame("Frame", "MyAddonTableCell", myTable, "BackdropTemplate")
        cell:SetSize(350, 25)
        cell:SetBackdrop(BACKDROP_TUTORIAL_16_16)
        cell:SetPoint("TOP", myTable, "TOP", 0, padding)

        local keyLevel = cell:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        keyLevel:SetPoint("LEFT", cell, "LEFT", 15, 0)
        keyLevel:SetText("Level: " .. i)
        keyLevel:SetTextColor(1, 1, 1)

        local completion = cell:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        completion:SetPoint("CENTER", cell, "CENTER")
        completion:SetText("Completion: " .. lootTableData[i][1])

        local weekly = cell:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        weekly:SetPoint("RIGHT", cell, "RIGHT", -15, 0)
        weekly:SetText("Weekly: " .. lootTableData[i][2])

        padding = padding + -25
    end

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