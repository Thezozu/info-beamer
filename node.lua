gl.setup(1920, 1080)

local video = resource.load_video{
    file = "background.mp4",
    looped = true,
    audio = false
}

local overlay = resource.load_image("overlay.png")

local show_overlay = false

util.data_mapper{
    ["gpio/18"] = function(value)
        show_overlay = (value == "1")
    end
}

function node.render()
    video:draw(0, 0, WIDTH, HEIGHT)
    if show_overlay then
        overlay:draw(0, 0, WIDTH, HEIGHT)
    end
end