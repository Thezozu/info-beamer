gl.setup(1920, 1080)

local video = resource.load_video{
    file = "background.mp4",
    looped = true,
    audio = false
}

local overlay = resource.load_image("overlay.png")

-- This will store the time when the overlay was shown.
-- It's nil if the overlay is not currently shown.
local overlay_shown_at = nil

util.data_mapper{
    ["gpio/18"] = function(value)
        -- The value is "1" when the button is pressed.
        -- We only want to trigger this once when the button is pressed,
        -- so we also check if the overlay is not already being shown.
        if value == "1" and not overlay_shown_at then
            overlay_shown_at = util.time()
        end
    end
}

function node.render()
    -- Always draw the video in the background
    video:draw(0, 0, WIDTH, HEIGHT)

    -- Check if the overlay should be shown
    if overlay_shown_at then
        -- Check if 5 minutes (300 seconds) have passed
        if util.time() - overlay_shown_at > 300 then
            -- Time's up. Hide the overlay by resetting our variable
            overlay_shown_at = nil
        else
            -- 5 minutes have not passed yet. Keep showing the overlay.
            overlay:draw(0, 0, WIDTH, HEIGHT)
        end
    end
end