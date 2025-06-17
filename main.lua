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

    


end

function love.draw()

    love.graphics.draw(sprite.background, 0 ,0)

    --player
    love.graphics.draw(sprite.player, player.x, player.y, mouseToPlayer(), nill, nill, sprite.player:getWidth()/ 2, sprite.player:getHeight() / 2)
    
    for i,z in ipairs(zombies) do
        love.graphics.draw(sprite.zombie, z.x, z.y)
    end
end

function love.keypressed( key  )
    if key == "space" then
        spawnZombie()
    end
end

function mouseToPlayer()
    return math.atan2(player.y - love.mouse.getY(), player.x - love.mouse.getX()) + math.pi



end

function spawnZombie()
    local zombie = {}
    zombie.x = math.random(0, love.graphics.getWidth())
    zombie.y = math.random(0, love.graphics.getPixelHeight())
    zombie.speed = 3
    table.insert(zombies, zombie)
end
