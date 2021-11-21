function generateQuads(atlas, tileWidth, tileHeight)

    local sheetWidth = atlas:getWidth() / tileWidth
    local sheetHeight = atlas:getHeight() / tileHeight
    
    local sheetCounter = 1

    local quads = {}

    -- ??
    for i = 0 , sheetHeight - 1 do 
        for j = 0, sheetWidth -1 do
            quads[sheetCounter] = love.graphics.newQuad(j * tileWidth, i * tileHeight, tileWidth, tileHeight, atlas:getDimensions())
            sheetCounter = sheetCounter + 1
        end
    end

    return quads
end