local DrawablePolygon = Component.create("DrawablePolygon")

function DrawablePolygon:initialize(world, x, y, l, h, type, entity, visible)
    self.body = love.physics.newBody(world, x, y, type)
    self.shape = love.physics.newRectangleShape(l, h)
    self.fixture = love.physics.newFixture(self.body, self.shape)
    --self.fixture:setUserData(entity)
    self.visible = visible
end

return DrawablePolygon
