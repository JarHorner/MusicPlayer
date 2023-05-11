

local frameVisible = false
local lt = CreateLootTable()

local function ToggleFrame()
    if frameVisible then
        lt:Hide()
        frameVisible = false
    else
        lt:Show()
        frameVisible = true
    end
end


local myIcon = CreateFrame("Button", "MyAddonIcon", Minimap)

myIcon:SetPoint("BOTTOM", Minimap, "BOTTOM", 0, 0)
myIcon:SetSize(32, 32)

myIcon:SetNormalTexture("Interface\\Icons\\INV_Misc_QuestionMark")

myIcon:SetScript("OnClick", function(self, button, down)
    if button == "LeftButton" then
        -- Do something when the left mouse button is clicked
        ToggleFrame()
    elseif button == "RightButton" then
        -- Do something when the right mouse button is clicked
    end
end)