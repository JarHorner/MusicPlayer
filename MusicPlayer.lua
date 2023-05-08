local soundType = {
    SOUND = 1,
    GAME_MUSIC = 2,
    CUSTOM = 3
}

local sounds = {
    ["murloc"] = {
        ["sound"] = 416,
        ["description"] = "Mglrlrlrlrlrl!",
        ["type"] = soundType.SOUND
    },
    ["boast"] = {
        ["sound"] = 16144,
        ["description"] = "YOU FACE JARAXXUS",
        ["type"] = soundType.SOUND
    },
    ["inn"] = {
        ["sound"] = 33789,
        ["description"] = "MoP Inn Music",
        ["type"] = soundType.SOUND
    },
    ["custom"] = {
        ["sound"] = "Interface\\AddOns\\MusicPlayer\\Sounds\\custom.mp3",
        ["description"] = "Custom Sound!",
        ["type"] = soundType.CUSTOM
    }
}

SLASH_SOUND1 = "/playsound"
SLASH_STOPSOUND1 = "/stopsound"

local customSoundId

local function displaySoundList()
    print("---------------------------------")
    -- prints out the different sounds the player is able to play
    for command in pairs(sounds) do
        local description = sounds[command].description
        print("Command: /playsound " .. command .. " - Description: " .. description)
    end

    print("---------------------------------")
end

local function playTrack(track)
    print(track.description)
    -- checks what type of sound the track is, and plays it accordingly
    if (track.type == soundType.GAME_MUSIC) then
        PlayMusic(track.sound)
    elseif (track.type == soundType.SOUND) then
        PlaySound(track.sound);
    elseif (track.type == soundType.CUSTOM) then
        customSoundId = select(2, PlaySoundFile(track.sound))
    end
end

local function playSoundHandler(trackId)
    local trackIdExists = string.len(trackId) > 0

    -- checks if track exists when user uses command
    if (trackIdExists) then
        local matchesKnownTrack = sounds[trackId] ~= nil

        if (matchesKnownTrack) then
            local track = sounds[trackId]
            playTrack(track)
        else
            displaySoundList()
            print(trackId .. " does not match a known track")
        end
    else
        displaySoundList()
    end
end

local function stopSoundHandler()

    if(customSoundId ~= nil) then
        StopSound(customSoundId)
        customSoundId = nil
    else
        StopMusic()
    end
end

SlashCmdList["SOUND"] = playSoundHandler
SlashCmdList["STOPSOUND"] = stopSoundHandler

