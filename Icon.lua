local frameVisible = false
local iconVisible = true
local lt = CreateLootTable()

local function ToggleFrame()
    -- ensures if the frame was closed my esc, it will be opened properly when toggled
    if lt:IsShown() == false and frameVisible == true then
        frameVisible = false
    end

    print("Toggling")
    if frameVisible then
        lt:Hide()
        frameVisible = false
    else
        lt:Show()
        frameVisible = true
    end
end

-- Creation of the minimap icon
local myButton = CreateFrame("Button", "MyAddonIcon", Minimap)
myButton:SetSize(32, 32)
myButton:SetPoint("TOPLEFT", Minimap, "TOPRIGHT", 0, 0)
-- myButton:SetNormalTexture("Interface\\Icons\\INV_Misc_QuestionMark")
myButton:SetMovable(true)
myButton:RegisterForDrag("LeftButton")

-- Create a circular texture
local myIcon = myButton:CreateTexture(nil, "BACKGROUND")
myIcon:SetTexture("Interface\\AddOns\\MythicPlusLootTable\\ring_20px.tga")
myIcon:SetPoint("CENTER", myButton, "CENTER")
myIcon:SetSize(24, 24)

-- Set the circular texture as the button's icon
myButton:SetNormalTexture(myIcon)


local function ToggleIcon()
    print("Toggling")
    if iconVisible then
        myButton:Hide()
        iconVisible = false
    else
        myButton:Show()
        iconVisible = true
    end
end

-- Sets up the OnClick script handler that ether toggles table or hides icon
myButton:SetScript("OnClick", function(self, button, down)
    if button == "LeftButton" then
        -- Do something when the left mouse button is clicked
        ToggleFrame()
    elseif button == "RightButton" then
        -- Do something when the right mouse button is clicked
        -- ToggleIcon()
        print("right click")
    end
end)

-- Allows the icon to be dragged along the minimap
myButton:SetScript("OnDragStart", function(self, button)
    self:StartMoving()

end)
myButton:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()

    -- -- Restrict the movement of the icon within the bounds of the minimap
    -- local x, y = self:GetParent():GetCenter()
    -- local cx, cy = Minimap:GetCenter()
    -- local scale = Minimap:GetEffectiveScale()
    -- local radius = (Minimap:GetWidth() / 2) * scale
    -- local dx, dy = x - cx, y - cy
    -- local distance = sqrt(dx ^ 2 + dy ^ 2)
    -- if distance > radius then
    --     local theta = atan2(dy, dx)
    --     x, y = cx + radius * cos(theta), cy + radius * sin(theta)
    --     self:GetParent():ClearAllPoints()
    --     self:GetParent():SetPoint("CENTER", UIParent, "BOTTOMLEFT", x / scale, y / scale)
    -- end
end)

-- Set up the tooltip text
myButton.tooltipTitle = "Mythic Plus Loot Table"
myButton.tooltipText1 = "Left Click: Toggle Table Window"
myButton.tooltipText2 = "Right Click: Hide Minimap Icon"

-- Sets up the OnEnter and OnLeave script handlers that shows the tooltip
myButton:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
    GameTooltip:AddLine(self.tooltipTitle)
    GameTooltip:AddLine(self.tooltipText1)
    GameTooltip:AddLine(self.tooltipText2)
    GameTooltip:Show()
end)
myButton:SetScript("OnLeave", function(self)
    GameTooltip:Hide()
end)
