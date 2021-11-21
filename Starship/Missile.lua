Missile = Class {}

function Missile:init(x, y, width, height)

    
    self.x = x
    self.y = y

    self.width = width
    self.height = height

    
    self.dx = 0
    self.dy = 0

end

function Missile:collides(box)
    
     if self.x > box.x + box.width or self.x + self.width < box.x then

        return false
     end

     if self.y > box.y + box.height or self.y + self.height < box.y then
        
        return false
     end

     return true
end

function Missile:reset()
    
    -- Missile position
    self.x = self.x + 2
    self.y = self.y + 2
    
    
end

function Missile:update(dt)
    
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Missile:render()
    
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.circle('fill', self.x , self.y, self.width, self.height)

end
