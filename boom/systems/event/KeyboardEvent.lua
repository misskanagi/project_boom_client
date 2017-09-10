local KeyboardEvent = class("KeyboardEvent", System)

function KeyboardEvent:firePressedEvent(event)
    for index, entity in pairs(engine:getEntitiesWithComponent("Controllable")) do
        local cmd = entity:get("Controllable").cmd
        if event.key == "w" then
            cmd.w=true
        elseif event.key == "s" then
            cmd.s=true
        elseif event.key == "a" then
            cmd.a=true
        elseif event.key == "d" then
            cmd.d=true
        elseif event.key == "left" then
            cmd.left = true
        elseif event.key == "right" then
            cmd.right = true
        end
    end
end

function KeyboardEvent:fireReleasedEvent(event)
  for index, entity in pairs(engine:getEntitiesWithComponent("Controllable")) do
      local cmd = entity:get("Controllable").cmd
      if event.key == "w" then
          cmd.w=false
      elseif event.key == "s" then
          cmd.s=false
      elseif event.key == "a" then
          cmd.a=false
      elseif event.key == "d" then
          cmd.d=false
      elseif event.key == "left" then
          cmd.left = false
      elseif event.key == "right" then
          cmd.right = false
      end
  end
end

function KeyboardEvent:update(dt)
  for index, entity in pairs(engine:getEntitiesWithComponent("Controllable")) do
      entity:get("Controllable"):execute(entity:get("Physic").body, entity)
  end
end

return KeyboardEvent
