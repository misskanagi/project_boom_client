local DrawableImage = Component.create("DrawableImage")

function DrawableImage:initialize(image, x, y, r, sx, sy, ox, oy)
    self.image = image
    self.x = x
    self.y = y
    self.r = r
    self.sx = sx or 1
    self.sy = sy or 1
    self.ox = ox or 0
    self.oy = oy or 0
end

return DrawableImage
