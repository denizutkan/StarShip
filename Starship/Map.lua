Map = Class {}

require 'util'

SAND_TILE = 1



function Map:init ()

    self.spritesheet = love.graphics.newImage('space.png')
    self.tileWidth = 640
    self.tileHeight = 640

    self.mapWidth = 20
    self.mapHeight = 20

    

    self.mapWidthPixels = self.mapWidth * self.tileWidth
    self.mapHeightPixels = self.mapHeight * self.tileHeight

    self.tiles = {}
 

    self.tileSprites = generateQuads(self.spritesheet, self.tileWidth, self.tileHeight)

    -- to fill the map with empty tile
    for i = 1, self.mapHeight do
        for j = 1, self.mapWidth do
            
            self:setTile(j, i, SAND_TILE)

        end
    end


end

function Map:getTile(x, y)

    return self.tiles[(y - 1) * self.mapWidth + x]

end 

function Map:setTile(x, y, id)

    self.tiles[(y - 1) * self.mapWidth + x] = id

end

function Map:update(dt)

    
    

    


end



function Map:render()

    
    local counter = 0
    for i = 1, self.mapHeight do
        for j = 1, self.mapWidth do
            
            love.graphics.draw(
                
            self.spritesheet,
             self.tileSprites[self:getTile(j, i)],
              (j - 1) * self.tileWidth,
               (i - 1) * self.tileHeight
            
            )

            counter = counter + 1

        end
    end
     
    
end

