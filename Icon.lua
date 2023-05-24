
local iconVisible = true

local function getAnchors(frame)
	local x, y = frame:GetCenter()
	if not x or not y then return "CENTER" end
	local hhalf = (x > UIParent:GetWidth()*2/3) and "RIGHT" or (x < UIParent:GetWidth()/3) and "LEFT" or ""
	local vhalf = (y > UIParent:GetHeight()/2) and "TOP" or "BOTTOM"
	return vhalf..hhalf, frame, (vhalf == "TOP" and "BOTTOM" or "TOP")..hhalf
end

local onClick, onMouseUp, onMouseDown, onDragStart, onDragStop, updatePosition

do
	local minimapShapes = {
		["ROUND"] = {true, true, true, true},
		["SQUARE"] = {false, false, false, false},
		["CORNER-TOPLEFT"] = {false, false, false, true},
		["CORNER-TOPRIGHT"] = {false, false, true, false},
		["CORNER-BOTTOMLEFT"] = {false, true, false, false},
		["CORNER-BOTTOMRIGHT"] = {true, false, false, false},
		["SIDE-LEFT"] = {false, true, false, true},
		["SIDE-RIGHT"] = {true, false, true, false},
		["SIDE-TOP"] = {false, false, true, true},
		["SIDE-BOTTOM"] = {true, true, false, false},
		["TRICORNER-TOPLEFT"] = {false, true, true, true},
		["TRICORNER-TOPRIGHT"] = {true, false, true, true},
		["TRICORNER-BOTTOMLEFT"] = {true, true, false, true},
		["TRICORNER-BOTTOMRIGHT"] = {true, true, true, false},
	}

	function updatePosition(button)
		local angle = math.rad(button.db and button.db.minimapPos or button.minimapPos or 225)
		local x, y, q = math.cos(angle), math.sin(angle), 1
		if x < 0 then q = q + 1 end
		if y > 0 then q = q + 2 end
		local minimapShape = GetMinimapShape and GetMinimapShape() or "ROUND"
		local quadTable = minimapShapes[minimapShape]
		if quadTable[q] then
			x, y = x*80, y*80
		else
			local diagRadius = 103.13708498985 --math.sqrt(2*(80)^2)-10
			x = math.max(-80, math.min(x*diagRadius, 80))
			y = math.max(-80, math.min(y*diagRadius, 80))
		end
		button:SetPoint("CENTER", Minimap, "CENTER", x, y)
        print("I am in updatePosition")
	end
end

function onMouseDown(self) self.isMouseDown = true; self.icon:UpdateCoord() end
function onMouseUp(self) self.isMouseDown = false; self.icon:UpdateCoord() end

do
	local function onUpdate(self)
		local mx, my = Minimap:GetCenter()
		local px, py = GetCursorPosition()
		local scale = Minimap:GetEffectiveScale()
		px, py = px / scale, py / scale
		self.minimapPos = math.deg(math.atan2(py - my, px - mx)) % 360
		updatePosition(self)
	end

	function onDragStart(self)
		self:LockHighlight()
		self.isMouseDown = true
		self.icon:UpdateCoord()
		self:SetScript("OnUpdate", onUpdate)
		self.isMoving = true
		GameTooltip:Hide()
	end
end

function onDragStop(self)
	self:SetScript("OnUpdate", nil)
	self.isMouseDown = false
	self.icon:UpdateCoord()
	self:UnlockHighlight()
	self.isMoving = nil
end

local defaultCoords = {0, 1, 0, 1}
local function updateCoord(self)
	local coords = defaultCoords
    print(coords)
	local deltaX, deltaY = 0, 0
	if not self:GetParent().isMouseDown then
		deltaX = (coords[2] - coords[1]) * 0.05
		deltaY = (coords[4] - coords[3]) * 0.05
	end
	self:SetTexCoord(coords[1] + deltaX, coords[2] - deltaX, coords[3] + deltaY, coords[4] - deltaY)
end

local button = CreateFrame("Button", "MythicPlusLootTableIcon", Minimap)
button:SetFrameStrata("MEDIUM")
button:SetSize(31, 31)
button:SetFrameLevel(8)
button:RegisterForClicks("anyUp")
button:RegisterForDrag("LeftButton")
button:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")
button:SetPoint("BOTTOMRIGHT", Minimap, "BOTTOMRIGHT", 0, 0)
local overlay = button:CreateTexture(nil, "OVERLAY")
overlay:SetSize(53, 53)
overlay:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
overlay:SetPoint("TOPLEFT")
local background = button:CreateTexture(nil, "BACKGROUND")
background:SetSize(20, 20)
background:SetTexture("Interface\\Minimap\\UI-Minimap-Background")
background:SetPoint("CENTER", 0, 0)
local icon = button:CreateTexture(nil, "ARTWORK")
icon:SetSize(20, 20)
icon:SetTexture("Interface\\AddOns\\MythicPlusLootTable\\Circle_Icon_Hourglass.tga")
icon:SetPoint("CENTER", button, "CENTER", 1, -1)
button.icon = icon
button.isMouseDown = false

print("Should get here")

icon.UpdateCoord = updateCoord
icon:UpdateCoord()

button:SetScript("OnDragStart", onDragStart)
button:SetScript("OnDragStop", onDragStop)

button:SetScript("OnMouseDown", onMouseDown)
button:SetScript("OnMouseUp", onMouseUp)

local function ToggleIcon()
    print("Toggling")
    if iconVisible then
        button:Hide()
        iconVisible = false
    else
        button:Show()
        iconVisible = true
    end
end

-- Sets up the OnClick script handler that ether toggles table or hides icon
button:SetScript("OnClick", function(self, button, down)
    if button == "LeftButton" then
        -- Do something when the left mouse button is clicked
        ToggleLootTable()
    elseif button == "RightButton" then
        -- Do something when the right mouse button is clicked
        -- ToggleIcon()
        print("right click")
    end
end)

-- -- Allows the icon to be dragged along the minimap
-- button:SetScript("OnDragStart", function(self, button)
--     self:StartMoving()

-- end)
-- button:SetScript("OnDragStop", function(self)
--     self:StopMovingOrSizing()

--     local posX, posY = self:GetCenter()
--     local mapPosX, mapPosY = Minimap:GetCenter()
--     local scale = Minimap:GetEffectiveScale()
--     local radius = (Minimap:GetWidth()/2) + 6
--     local deltaX, deltaY = posX - mapPosX, posY - mapPosY
--     local distance = math.sqrt(deltaX^2 + deltaY^2)
--     if distance < radius then -- only reposition the button if it's within the minimap circle
--         local angle = math.atan2(deltaY, deltaX)
--         self:ClearAllPoints()
--         self:SetPoint("CENTER", Minimap, "CENTER", math.cos(angle)*radius, math.sin(angle)*radius)
--     end
-- end)

-- Set up the tooltip text
button.tooltipTitle = "Mythic Plus Loot Table"
button.tooltipText1 = "Left Click: Toggle Table Window"
button.tooltipText2 = "Right Click: Hide Minimap Icon"

-- Sets up the OnEnter and OnLeave script handlers that shows the tooltip
button:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
    GameTooltip:AddLine(self.tooltipTitle, 1, 1, 1)
    GameTooltip:AddLine(self.tooltipText1)
    GameTooltip:AddLine(self.tooltipText2)
    GameTooltip:Show()
end)

button:SetScript("OnLeave", function(self)
    GameTooltip:Hide()
end)
