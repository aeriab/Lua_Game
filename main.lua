function love.load()
    player = {}
    player.x = 400
    player.y = 200

    player.speed = 300
end

function love.update(dt)
    player.x = player.x + player.speed * dt * (int(love.keyboard.isDown("right")) - int(love.keyboard.isDown("left")))
    player.y = player.y + player.speed * dt * (int(love.keyboard.isDown("down")) - int(love.keyboard.isDown("up")))
end

function love.draw()
    love.graphics.circle("fill", player.x, player.y, 50)
end


function int(value)
    return value and 1 or 0
end

-- function love.keypressed(key, unicode)
-- 	if key == "f8" then
-- 		love.event.quit()
-- 	end
-- end