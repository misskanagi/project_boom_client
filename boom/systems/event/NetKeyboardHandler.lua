local NetKeyboardHandler = class("NetKeyboardHandler", System)

function NetKeyboardHandler:fireNetPressedEvent(event)
    for index, entity in pairs(engine:getEntitiesWithComponent("PlayerName")) do
        if entity:get("PlayerName").name == event.name then
            local dcmd = entity:get("Drivable") and entity:get("Drivable").cmd or nil
            local fcmd = entity:get("Firable") and entity:get("Firable").cmd or nil
            if event.key == "w" and dcmd then
                dcmd.forward=true
            elseif event.key == "s" and dcmd then
                dcmd.backward=true
            elseif event.key == "a" and dcmd then
                dcmd.turn_left=true
            elseif event.key == "d" and dcmd then
                dcmd.turn_right=true
            elseif event.key == "l" and dcmd then
                dcmd.toggle_light = not dcmd.toggle_light
            elseif event.key == "left" and dcmd then
                dcmd.turret_spin_neg = true
            elseif event.key == "right" and dcmd then
                dcmd.turret_spin_pos = true
            elseif event.key == "space" and fcmd then
                fcmd.fire = true
            elseif event.key == "q" and lcmd then
                lcmd.launch = true
            end
        end
    end
end

function NetKeyboardHandler:fireNetReleasedEvent(event)
  for index, entity in pairs(engine:getEntitiesWithComponent("PlayerName")) do
      if entity:get("PlayerName").name == event.name then
          local dcmd = entity:get("Drivable") and entity:get("Drivable").cmd or nil
          local fcmd = entity:get("Firable") and entity:get("Firable").cmd or nil
          if event.key == "w" and dcmd then
              dcmd.forward=false
          elseif event.key == "s" and dcmd then
              dcmd.backward=false
          elseif event.key == "a" and dcmd then
              dcmd.turn_left=false
          elseif event.key == "d" and dcmd then
              dcmd.turn_right=false
          elseif event.key == "left" and dcmd then
              dcmd.turret_spin_neg = false
          elseif event.key == "right" and dcmd then
              dcmd.turret_spin_pos = false
          elseif event.key == "space" and fcmd then
              fcmd.fire = false
          end
      end
  end
end

return NetKeyboardHandler
