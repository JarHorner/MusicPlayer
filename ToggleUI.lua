local frameVisible = false

function ToggleLootTable()
    -- ensures if the frame was closed my esc, it will be opened properly when toggled
    if lootTable:IsShown() == false and frameVisible == true then
        frameVisible = false
    end

    if frameVisible then
        lootTable:Hide()
        frameVisible = false
    else
        lootTable:Show()
        frameVisible = true
    end
end