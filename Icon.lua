local MPLT = MPLT

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
			-- This affects where along the minimap the icon is placed
			x, y = x*105, y*105
		else
			local diagRadius = 103.13708498985 --math.sqrt(2*(80)^2)-10
			x = math.max(-80, math.min(x*diagRadius, 80))
			y = math.max(-80, math.min(y*diagRadius, 80))
		end
		SavedVariables.xPos = x
		SavedVariables.yPos = y
		button:SetPoint("CENTER", Minimap, "CENTER", x, y)
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
	local deltaX, deltaY = 0, 0
	if not self:GetParent().isMouseDown then
		deltaX = (coords[2] - coords[1]) * 0.05
		deltaY = (coords[4] - coords[3]) * 0.05
	end
	self:SetTexCoord(coords[1] + deltaX, coords[2] - deltaX, coords[3] + deltaY, coords[4] - deltaY)
end

lootTableIcon = CreateFrame("Button", "MythicPlusLootTableIcon", Minimap)
lootTableIcon:SetFrameStrata("MEDIUM")
lootTableIcon:SetSize(31, 31)
lootTableIcon:SetFrameLevel(8)
lootTableIcon:RegisterForClicks("anyUp")
lootTableIcon:RegisterForDrag("LeftButton")
lootTableIcon:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")
local overlay = lootTableIcon:CreateTexture(nil, "OVERLAY")
overlay:SetSize(53, 53)
overlay:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
overlay:SetPoint("TOPLEFT")
local background = lootTableIcon:CreateTexture(nil, "BACKGROUND")
background:SetSize(20, 20)
background:SetTexture("Interface\\Minimap\\UI-Minimap-Background")
background:SetPoint("TOPLEFT", 7, -5)
local icon = lootTableIcon:CreateTexture(nil, "ARTWORK")
icon:SetSize(20, 20)
icon:SetTexture("Interface\\AddOns\\MythicPlusLootTable\\Circle_Icon_Hourglass.tga")
icon:SetPoint("TOPLEFT", 7, -6)
lootTableIcon.icon = icon
lootTableIcon.isMouseDown = false

updatePosition(lootTableIcon)

icon.UpdateCoord = updateCoord
icon:UpdateCoord()

lootTableIcon:SetScript("OnDragStart", onDragStart)
lootTableIcon:SetScript("OnDragStop", onDragStop)

lootTableIcon:SetScript("OnMouseDown", onMouseDown)
lootTableIcon:SetScript("OnMouseUp", onMouseUp)


-- Sets up the OnClick script handler that ether toggles table or hides icon
lootTableIcon:SetScript("OnClick", function(self, button, down)
    if button == "LeftButton" then
        -- Do something when the left mouse button is clicked
        ToggleLootTable()
    elseif button == "RightButton" then
        -- Do something when the right mouse button is clicked
		ToggleLootTableMenu()
    end
end)

-- Set up the tooltip text
lootTableIcon.tooltipTitle = MPLT["Addon Name"]
lootTableIcon.tooltipText1 = MPLT["Tooltip Text 1"]
lootTableIcon.tooltipText2 = MPLT["Tooltip Text 2"]

-- Sets up the OnEnter and OnLeave script handlers that shows the tooltip
lootTableIcon:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
    GameTooltip:AddLine(self.tooltipTitle, 1, 1, 1)
    GameTooltip:AddLine(self.tooltipText1)
    GameTooltip:AddLine(self.tooltipText2)
    GameTooltip:Show()
end)

lootTableIcon:SetScript("OnLeave", function(self)
    GameTooltip:Hide()
end)