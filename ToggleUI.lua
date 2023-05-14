local frameVisible = false
local lt = CreateLootTable()

function ToggleFrame()
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