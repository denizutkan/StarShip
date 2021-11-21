WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

SpaceShip_SPEED = 200
MISSILE_SPEED = 600



Class = require 'class'
push = require 'push'

require 'Missile'
require 'SpaceShip'
require 'Map'

function love.load()


    map = Map()

    love.graphics.setDefaultFilter('nearest', 'nearest')

    love.window.setTitle('STARSHIP')
    
   
    sounds = {
        ['laser'] = love.audio.newSource('Sounds/Laser_Shoot.wav', 'static'),
        ['ship_hit'] = love.audio.newSource('Sounds/Hit_Hurt.wav','static'),
        ['big_laser'] = love.audio.newSource('Sounds/Powerup.wav','static'),
        ['explosion'] = love.audio.newSource('Sounds/Explosion.wav','static')
    }

    -- fonts
    SmallFont = love.graphics.newFont('front.ttf', 8)
    ScoreFont = love.graphics.newFont('front.ttf', 32)
    VictoryFont = love.graphics.newFont('front.ttf', 24)

    -- Players Health
    player1Health = 100
    player2Health = 100

    winner = 0

    


    --SpaceShip's 
    SpaceShip1 = SpaceShip(5, 30, 1)
    SpaceShip2 = SpaceShip(VIRTUAL_WIDTH - 35, VIRTUAL_HEIGHT - 50, -1)
    --Missile
    Missile1 = Missile(VIRTUAL_WIDTH + 20, 10, 3, 3)
    Missile2 = Missile(-10, 10, 3, 3)
    Missile3 = Missile(VIRTUAL_WIDTH + 20, 10, 3, 3)
    Missile4 = Missile(-10, 10, 3, 3)

    BigMissile1 = Missile(VIRTUAL_WIDTH + 2001, 10, 6, 6)
    BigMissile2 = Missile(-2001, 10, 6, 6)

    gameState = 'pause'


    push:setupScreen(VIRTUAL_WIDTH,VIRTUAL_HEIGHT, WINDOW_WIDTH,WINDOW_HEIGHT,{
        fullscreen = false,
        vsync = true,
        resizable = true
    })
end

function love.resize(w, h)
    push:resize(w , h)
end


function love.update(dt)
    
    SpaceShip1:update(dt)
    SpaceShip2:update(dt)

    Missile1:update(dt)
    Missile2:update(dt)
    Missile3:update(dt)
    Missile4:update(dt)

    BigMissile1:update(dt)
    BigMissile2:update(dt)

    if Missile2:collides(SpaceShip1) or Missile4:collides(SpaceShip1) then
        -- decrase the health of player 2
        
        Missile2.x = -10
        Missile4.x = -10

        player1Health = player1Health -10
        if gameState == 'play' then
        sounds['ship_hit']:play()
        end
    end

    if BigMissile2:collides(SpaceShip1) then
        -- decrase the health of player 2

        BigMissile2.x = -2001
        player1Health = player1Health - 20
        if gameState == 'play' then
        sounds['ship_hit']:play()
        end
    end

    if Missile1:collides(SpaceShip2) or Missile3:collides(SpaceShip2) then
        -- decrase the health of player 2

        Missile1.x = VIRTUAL_WIDTH + 10
        Missile3.x = VIRTUAL_WIDTH + 10
        player2Health = player2Health -10

        if gameState == 'play' then
        sounds['ship_hit']:play()
        end
    end
    

    if BigMissile1:collides(SpaceShip2) then
        -- decrase the health of player 2

        BigMissile1.x = VIRTUAL_WIDTH + 2001
        player2Health = player2Health - 20

        if gameState == 'play' then
        sounds['ship_hit']:play()
        end
    end

    if player1Health <= 0 then

        if gameState == 'play' then
            sounds['explosion']:play()
        end
        
        gameState = 'victory'
        winner = 2

    elseif player2Health <= 0 then
        
        if gameState == 'play' then
            sounds['explosion']:play()
        end

        gameState = 'victory'
        winner = 1

    end
    

   

    

     
    -- to move SpaceShips

    if love.keyboard.isDown('w') then
        SpaceShip1.dx = 0
        SpaceShip1.dy = -SpaceShip_SPEED
    elseif love.keyboard.isDown('s') then
        SpaceShip1.dx = 0
        SpaceShip1.dy = SpaceShip_SPEED
    elseif love.keyboard.isDown('a') then
        SpaceShip1.dy = 0
        SpaceShip1.dx = -SpaceShip_SPEED
    elseif love.keyboard.isDown('d') then
        SpaceShip1.dy = 0
        SpaceShip1.dx = SpaceShip_SPEED
    elseif love.keyboard.isDown('space') then

        

        Missile1.dx = MISSILE_SPEED
        Missile3.dx = MISSILE_SPEED
    

        if Missile1.x > VIRTUAL_WIDTH or Missile3.x > VIRTUAL_WIDTH  then
            if gameState == 'play' then
            sounds['laser']:play()
            end
            Missile1.x = SpaceShip1.x + 12
            Missile1.y = SpaceShip1.y + 6

            Missile3.x = SpaceShip1.x + 12
            Missile3.y = SpaceShip1.y + 21

            Missile1:reset()
            Missile3:reset()

        elseif Missile1:collides(SpaceShip2) then

            Missile1.x = SpaceShip1.x + 3
            Missile1.y = SpaceShip1.y + 3
            Missile1:reset()


        end
        
    elseif love.keyboard.isDown('r') then
        
        

        if BigMissile1.x > VIRTUAL_WIDTH + 2000 then
            if gameState == 'play' then
            sounds['big_laser']:play()
            end
            BigMissile1.x = SpaceShip1.x + 32
            BigMissile1.y = SpaceShip1.y + 12
            BigMissile1:reset()

            BigMissile1.dx = MISSILE_SPEED / 4

        end

    else
        SpaceShip1.dx = 0
        SpaceShip1.dy = 0
    end

    if love.keyboard.isDown('up') then
        SpaceShip2.dx = 0
        SpaceShip2.dy = -SpaceShip_SPEED
    elseif love.keyboard.isDown('down') then
        SpaceShip2.dx = 0
        SpaceShip2.dy = SpaceShip_SPEED
    elseif love.keyboard.isDown('left') then
        SpaceShip2.dy = 0
        SpaceShip2.dx = -SpaceShip_SPEED
    elseif love.keyboard.isDown('right') then
        SpaceShip2.dy = 0
        SpaceShip2.dx = SpaceShip_SPEED

    elseif love.keyboard.isDown('o') then

        

        Missile4.dx = - MISSILE_SPEED
        Missile2.dx = - MISSILE_SPEED

        if Missile2.x < 0 or Missile4.x < 0 then
            if gameState == 'play' then
            sounds['laser']:play()
            end

            Missile2.x = SpaceShip2.x + 12
            Missile2.y = SpaceShip2.y + 6

            Missile4.x = SpaceShip2.x + 12
            Missile4.y = SpaceShip2.y + 21

            Missile2:reset()
            Missile4:reset()
        end
    
    elseif love.keyboard.isDown('p') then
        
               

        if BigMissile2.x < -2000 then
            if gameState == 'play' then
            sounds['big_laser']:play()
            end
            BigMissile2.x = SpaceShip2.x
            BigMissile2.y = SpaceShip2.y + 12
            BigMissile2:reset()

            BigMissile2.dx = -MISSILE_SPEED / 4

        end

    else
        SpaceShip2.dx = 0
        SpaceShip2.dy = 0
    end

    

    
    

        
        
    
end

function love.keypressed(key)

    -- to quit
    if key == 'escape' then
        love.event.quit()

    elseif key == 'enter' or key == 'return' then

        if gameState == 'victory' then

            gameState = 'play'

            player1Health = 100
            player2Health = 100

            SpaceShip1.x = 10
            SpaceShip1.y = 130

            SpaceShip2.x = VIRTUAL_WIDTH - 30
            SpaceShip2.y = 130
        
        elseif gameState == 'pause' then

            gameState ='play'
        
        end

    end
        
        


end


function love.draw()
    push:apply('start')

    love.graphics.clear(40 / 255,45 / 255,52 / 255, 255 /255)

    if gameState == 'pause' then
        
        love.graphics.setFont(ScoreFont)
        love.graphics.printf('Welcome to STARSHIP ', 10, 20,VIRTUAL_WIDTH,'center')

        love.graphics.setFont(SmallFont)
        love.graphics.printf('Press Enter to Start', 10, 200,VIRTUAL_WIDTH,'center')
    
    elseif gameState == 'victory' then

        

        love.graphics.setFont(VictoryFont)
        love.graphics.printf("Ship ".. tostring(winner) .. " wins", 0, 20, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(SmallFont)
        love.graphics.printf("Press Enter to restart", 0, 45, VIRTUAL_WIDTH, 'center')

    

    else

        map:render()
    
        -- SpaceShip position
        SpaceShip1:render()
        SpaceShip2:render()

        -- Missile position
        Missile1:render()
        Missile2:render()
        Missile3:render()
        Missile4:render()

        BigMissile1:render()
        BigMissile2:render()

        love.graphics.setFont(SmallFont)
        love.graphics.setColor(1, 0, 0, 1)
        love.graphics.print('Ship 1 Health: '.. tostring(player1Health), 10, 20)
        love.graphics.print('Ship 2 Health: '.. tostring(player2Health), VIRTUAL_WIDTH - 100, 20)
    
    love.graphics.setColor(1, 1, 1, 1)

    end
  


    
    
    
    push:apply('end')
end


