local PlayerDraw = class("PlayerDraw", System)

function PlayerDraw:draw()

    for index, entity in pairs(self.targets) do
        love.graphics.setColor(67, 168, 45, 255)
        -- draw tire
        love.graphics.polygon("fill", entity:get("Tire").body:getWorldPoints(
            entity:get("Tire").shape:getPoints()))
        -- draw cannon
        love.graphics.setColor(105, 144, 30, 255)
        local turret = entity:get("Turret")
        for _, fix in pairs(turret.body:getFixtureList()) do
          local shape = fix:getShape()
          if shape:typeOf("PolygonShape") then
              love.graphics.polygon("fill", turret.body:getWorldPoints(shape:getPoints()))
          elseif shape:typeOf("CircleShape") then
              local x,y = turret.body:getWorldCenter()
              love.graphics.circle("fill", x, y, shape:getRadius())
          end
        end

        -- recover color mode
        love.graphics.setColor(255, 255, 255, 255)
    end

end

function PlayerDraw:requires()
    return {"IsPlayer"}
end

return PlayerDraw
