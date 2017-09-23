local ImageDraw = class("ImageDraw", System)

function ImageDraw:draw()
    for index, entity in pairs(self.targets) do
        local DI = entity:get("DrawableImage")
        local image = DI.image
        local x, y, r, sx, sy, ox, oy = DI.x, DI.y, DI.r, DI.sx, DI.sy, DI.ox, DI.oy
        love.graphics.draw(image, x, y, r, sx, sy, ox, oy)
    end
end

function ImageDraw:requires()
    return {"DrawableImage"}
end

return ImageDraw
