-- Creation of options panel in Addons settings 
local optionsPanel = CreateFrame("Frame")
optionsPanel.name = "Mythic Plus Loot Table"
InterfaceOptions_AddCategory(optionsPanel)

-- creates title
local title = optionsPanel:CreateFontString("TITLE", nil, "GameFontNormalLarge")
title:SetPoint("TOPLEFT", optionsPanel, "TOPLEFT", 16, -16)
title:SetText("Mythic Plus Loot Table")

-- creates button to reset position of loot table
local resetButton = CreateFrame("Button", "resetTableButton", optionsPanel, "UIPanelButtonTemplate")
resetButton:SetText("Reset Loot Table")
resetButton:SetPoint("TOPLEFT", 14, -45) -- Button position
resetButton:SetWidth(120) -- Button width
resetButton:SetHeight(24) -- Button height

-- Checkbox to toggle icon around minimap
toggleCheckbox =
    CreateFrame("CheckButton", "MyAddonToggleCheckbox", optionsPanel, "InterfaceOptionsCheckButtonTemplate")
toggleCheckbox:SetPoint("TOPLEFT", 14, -75) -- Adjust the position as desired
toggleCheckbox.Text:SetText("Hide Minimap Icon") -- The label text displayed next to the checkbox

-- Create a frame to hold the slider
local popupTimer = CreateFrame("Slider", "MyAddonSliderFrame", optionsPanel, "UISliderTemplateWithLabels")
popupTimer:SetWidth(200)
popupTimer:SetHeight(20)
popupTimer:SetPoint("TOPLEFT", 14, -120)

-- Set the slider's parameters
popupTimer:SetMinMaxValues(2, 10)
popupTimer:SetValue(SavedVariables.popupTime)
popupTimer:SetValueStep(1)
popupTimer:SetObeyStepOnDrag(true)

local sliderText = _G[popupTimer:GetName() .. "Text"]
local sliderLow = _G[popupTimer:GetName() .. "Low"]
local sliderHigh = _G[popupTimer:GetName() .. "High"]

popupTimer.Text:SetText("M+ Loot Popup Time")
popupTimer.Low:SetText("0")
popupTimer.High:SetText("10")

resetButton:SetScript("OnClick", function(self, button, down)
    -- Code to be executed when the button is clicked
    print("Button clicked!")

    -- ResetTablePosition()

    -- local frame = GetFrameByName("LootTable")
    -- if frame then
    --     print("found")
    -- else
    --     print("not found")
    -- end

end)

-- creates popupTimer value
local popupTimerValue = optionsPanel:CreateFontString("popupValue", nil, "GameFontNormalLarge")
popupTimerValue:SetPoint("RIGHT", popupTimer, "RIGHT", 32, 0)
popupTimerValue:SetText(SavedVariables.popupTime)

-- Set up the slider's value change callback
popupTimer:SetScript("OnValueChanged", function(self, value)
    popupTimerValue:SetText(value)
    SavedVariables.popupTime = value
end)

-- toggles the minimap icon on/off
local function ToggleOption(checkbox)
    local isChecked = checkbox:GetChecked()

    if isChecked or not SavedVariables.iconHidden then
        -- Option is enabled
        lootTableIcon:Hide()
        SavedVariables.iconHidden = true
    else
        -- Option is disabled
        lootTableIcon:Show()
        SavedVariables.iconHidden = false
    end
end

-- sets up the script on the checkbox that shows/hides the icon
toggleCheckbox:SetScript("OnClick", function(self)
    ToggleOption(self)
end)
