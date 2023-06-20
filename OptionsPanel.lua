-- Creation of options panel in Addons settings 
local optionsPanel = CreateFrame("Frame")
optionsPanel.name = "Mythic Plus Loot Table"
InterfaceOptions_AddCategory(optionsPanel)

-- creates title
local title = optionsPanel:CreateFontString("TITLE", nil, "GameFontNormalLarge")
title:SetPoint("TOPLEFT", optionsPanel, "TOPLEFT", 16, -16)
title:SetText("Mythic Plus Loot Table")

-- Function to show the popup
local function ShowPopup()
    StaticPopup_Show("RESET_POPUP_DIALOG")
end

-- Function to show the popup
local function HidePopup()
    StaticPopup_Hide("RESET_POPUP_DIALOG")
end
-- Define the popup dialog
local resetPopupDialog = {
    text = "Are you sure you want to reset the saved variables? Reload to ensure changes are made",
    button1 = "Yes",
    button2 = "No",
    OnAccept = function()
        ResetSavedVariables()
    end,
    OnCancel = function()
        HidePopup()
    end,
    timeout = 0, -- Set to 0 for no timeout
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = STATICPOPUP_NUMDIALOGS,
}

-- Register the popup dialog
StaticPopupDialogs["RESET_POPUP_DIALOG"] = resetPopupDialog

-- creates button to reset position of loot table
local resetButton = CreateFrame("Button", "resetTableButton", optionsPanel, "UIPanelButtonTemplate")
resetButton:SetText("Reset Addon Variables")
resetButton:SetPoint("TOPLEFT", 14, -45) -- Button position
resetButton:SetWidth(150) -- Button width
resetButton:SetHeight(24) -- Button height
resetButton:SetScript("OnClick", ShowPopup)


-- Checkbox to toggle icon around minimap
toggleCheckbox =
    CreateFrame("CheckButton", "MyAddonToggleCheckbox", optionsPanel, "InterfaceOptionsCheckButtonTemplate")
toggleCheckbox:SetPoint("TOPLEFT", 14, -75) -- Adjust the position as desired
toggleCheckbox.Text:SetText("Hide Minimap Icon") -- The label text displayed next to the checkbox

-- Create a frame to hold the slider
popupTimer = CreateFrame("Slider", "MyAddonSliderFrame", optionsPanel, "UISliderTemplateWithLabels")
popupTimer:SetWidth(200)
popupTimer:SetHeight(20)
popupTimer:SetPoint("TOPLEFT", 14, -120)

-- Set the slider's parameters
popupTimer:SetMinMaxValues(2, 10)
popupTimer:SetValueStep(1)
popupTimer:SetObeyStepOnDrag(true)

local sliderText = _G[popupTimer:GetName() .. "Text"]
local sliderLow = _G[popupTimer:GetName() .. "Low"]
local sliderHigh = _G[popupTimer:GetName() .. "High"]

popupTimer.Text:SetText("M+ Loot Popup Time")
popupTimer.Low:SetText("2")
popupTimer.High:SetText("10")

-- creates popupTimer value
local popupTimerValue = optionsPanel:CreateFontString("popupValue", nil, "GameFontNormalLarge")
popupTimerValue:SetPoint("RIGHT", popupTimer, "RIGHT", 32, 0)
popupTimerValue:SetText(SavedVariables.popupTime)

-- Set up the slider's value change callback
popupTimer:SetScript("OnValueChanged", function(self, value)
    popupTimerValue:SetText(value)

    SavedVariables.popupTime = value
    print(SavedVariables.popupTime)
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
