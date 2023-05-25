
-- Creation of options panel in Addons settings 
local optionsPanel = CreateFrame("Frame")
optionsPanel.name = "Mythic Plus Loot Table"
InterfaceOptions_AddCategory(optionsPanel)

-- creates title
local title = optionsPanel:CreateFontString("TITLE", nil, "GameFontNormalLarge")
title:SetPoint("TOPLEFT", optionsPanel, "TOPLEFT", 16, -16)
title:SetText("Mythic Plus Loot Table")

-- Checkbox to toggle icon around minimap
local toggleCheckbox = CreateFrame("CheckButton", "MyAddonToggleCheckbox", optionsPanel, "InterfaceOptionsCheckButtonTemplate")
toggleCheckbox:SetPoint("TOPLEFT", 14, -40) -- Adjust the position as desired
toggleCheckbox.Text:SetText("Hide Minimap Icon") -- The label text displayed next to the checkbox

local function ToggleOption(checkbox)
    local isChecked = checkbox:GetChecked()

    if isChecked then
        -- Option is enabled
        lootTableIcon:Hide()
    else
        -- Option is disabled
        lootTableIcon:Show()
    end
end

toggleCheckbox:SetScript("OnClick", function(self)
    ToggleOption(self)
end)