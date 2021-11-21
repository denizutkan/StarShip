SpaceShip = Class {}

function SpaceShip:init(x, y, direction)

    self.direction = direction

    self.x = x
    self.y = y
    self.width = 32
    self.height = 24

    self.dy = 0
    self.dx = 0

    self.texture = love.graphics.newImage('Ships/Ligher.png')
    self.frames = generateQuads(self.texture, 32, 32)
end

function SpaceShip:update(dt)
    
    if self.dy < 0 then
        self.y = math.max(0, self.y + self.dy * dt)
    elseif self.dy > 0 then
        self.y = math.min(VIRTUAL_HEIGHT - 20, self.y + self.dy * dt)
    end

    if self.dx < 0 then
        self.x = math.max(0, self.x + self.dx * dt)
    elseif self.dx > 0 then
        self.x = math.min(VIRTUAL_WIDTH - 20, self.x + self.dx * dt)
    end

    if self.x < VIRTUAL_WIDTH / 2 then
        self.x = math.min(180, self.x + self.dx * dt)
    elseif self.x > VIRTUAL_WIDTH / 2 then
        self.x = math.max(240, self.x + self.dx * dt)
    end
end

function SpaceShip:render()

    local scaleX

    if self.direction == 1 then
        scaleX = 1
    else
        scaleX = -1
    end

    love.graphics.draw(self.texture, self.frames[1],
     math.floor(self.x + self.width / 2),math.floor(self.y + self.height / 2),
     0, scaleX, 1,self.width / 2, self.height / 2)

end
