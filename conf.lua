-- conf.lua

local config = {}

config.initialWidth = 960
config.initialHeight = 540

function love.conf(t)
    t.window.title = "My Scalable LÖVE Game"
    t.window.width = config.initialWidth
    t.window.height = config.initialHeight
    t.window.fullscreen = false -- Start in windowed mode
    t.window.resizable = true   -- Allow the window to be resized by the user
    t.window.minwidth = 192     -- Optional: minimum resizable width
    t.window.minheight = 108    -- Optional: minimum resizable height
end



return config