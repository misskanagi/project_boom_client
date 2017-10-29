local PlayerDraw = class("PlayerDraw", System)

function PlayerDraw:draw()

    for index, entity in pairs(self.targets) do
        -- draw tire
        local tire = entity:get("Tire")
        love.graphics.setColor(tire.r, tire.g, tire.b, 255)
        love.graphics.polygon("fill", entity:get("Tire").body:getWorldPoints(
            entity:get("Tire").shape:getPoints()))
        -- draw cannon
        local turret = entity:get("Turret")
        love.graphics.setColor(turret.r, turret.g, turret.b, 255)
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

        --[[for _, child in pairs(entity.children) do
            local x, y = child:get("Physic").body:getWorldCenter()
            print(x, y)
        end]]
    end
end

function PlayerDraw:requires()
    return {"IsPlayer"}
end

return PlayerDraw
