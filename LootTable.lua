function CreateLootTable()
    local myFrame = CreateFrame("Frame", "MyFrame", UIParent, "UIPanelDialogTemplate")

    myFrame:SetPoint("LEFT", UIParent, "LEFT")
    myFrame:SetSize(400, 400)
    myFrame:SetMovable(true)
    myFrame:EnableMouse(true)
    myFrame:RegisterForDrag("LeftButton")

    local label = myFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    label:SetPoint("TOP", myFrame, "TOP", 0, -9)
    label:SetText("Mythic + Loot Table")

    myFrame:SetScript("OnDragStart", function(self, button)
        self:StartMoving()
    end)
    myFrame:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
    end)
    myFrame:SetScript("OnShow", function(self)
        print("Frame is shown!")
    end)
    -- tinsert(UISpecialFrames, "MyFrame")
    return MyFrame
end
