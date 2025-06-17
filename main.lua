function love.load()

   sprite = {}
   sprite.background = love.graphics.newImage('sprites/background.png')
   sprite.bullet = love.graphics.newImage('sprites/bullet.png')
   sprite.player = love.graphics.newImage('sprites/player.png')
   sprite.zombie = love.graphics.newImage('sprites/zombie.png')


   player = {}
   player.x = love.graphics.getWidth() / 2
   player.y = love.graphics.getHeight() / 2
   player.speed = 180

   zombies = {}

   bullets = {}


   

end


function love.update(dt)

    if love.keyboard.isDown("w") then
        player.y = player.y - player.speed*dt
    end
    if love.keyboard.isDown("s") then
        player.y = player.y + player.speed*dt
    end
    if love.keyboard.isDown("a") then
        player.x = player.x - player.speed*dt
    end
    if love.keyboard.isDown("d") then
        player.x = player.x + player.speed*dt
    end

    for i,z in ipairs(zombies) do
        z.x = z.x + math.cos  ( zombiePlayerAngle(z)) * z.speed * dt
        z.y = z.y + math.sin ( zombiePlayerAngle(z))  * z.speed * dt

        if distanceBetween(z.x, z.y, player.x, player.y) < 30 then
            for i,z in ipairs(zombies) do
                zombies[i] = nill
            end
        end


        for i, b in ipairs(bullets) do
            b.x = b.x + (math.cos ( b.direction)  * b.speed * dt)
            b.y = b.y + (math.sin ( b.direction)  * b.speed * dt)
        end

    end

    for i=#bullets, 1, -1 do
        local b = bullets[i]
        if b.x < 0 or b.y < 0 or b.x > love.graphics.getWidth() or b.y > love.graphics.getHeight() then
            table.remove(bullets, i)
        end
    end

    


end

function love.draw()

    love.graphics.draw(sprite.background, 0 ,0)

    --player
    love.graphics.draw(sprite.player, player.x, player.y, mouseToPlayer(), nill, nill, sprite.player:getWidth()/ 2, sprite.player:getHeight() / 2)
    
    for i,z in ipairs(zombies) do
        love.graphics.draw(sprite.zombie, z.x, z.y, zombiePlayerAngle(z), nill, nill, sprite.zombie:getWidth() / 2, sprite.zombie:getHeight() / 2)
    end

    --bullets

    for i, b in ipairs(bullets) do
        love.graphics.draw(sprite.bullet, b.x, b.y, nill, 0.5, 0.5, sprite.bullet:getWidth()/2, sprite.bullet:getHeight()/2)
    end
end


function love.keypressed( key  )
    if key == "space" then
        spawnZombie()
    end
end

function love.mousepressed( x, y, button)
    if button == 1 then
        spawnBullet()
    end

end

function mouseToPlayer()
    return math.atan2(player.y - love.mouse.getY(), player.x - love.mouse.getX()) + math.pi
end

function zombiePlayerAngle(enemy)
    return math.atan2(player.y - enemy.y, player.x - enemy.x) 
end



function spawnZombie()
    local zombie = {}
    zombie.x = math.random(0, love.graphics.getWidth())
    zombie.y = math.random(0, love.graphics.getPixelHeight())
    zombie.speed = 140
    table.insert(zombies, zombie)
end

function spawnBullet()
    local bullet = {}
    bullet.x = player.x
    bullet.y = player.y
    bullet.speed = 500
    bullet.direction = mouseToPlayer()
    table.insert(bullets, bullet)
end


function distanceBetween(x1, y1, x2, y2)
    return math.sqrt((x2 - x1)^2 + (y2 - y1)^2) 
end
