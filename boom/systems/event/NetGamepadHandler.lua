local NetGamepadHandler = class("NetGamepadHandler", System)

function NetGamepadHandler:fireNetPressedEvent(event)
    for index, entity in pairs(engine:getEntitiesWithComponent("PlayerName")) do
        if entity:get("PlayerName").name == event.name then
            local dcmd = entity:get("Drivable") and entity:get("Drivable").cmd or nil
            local fcmd = entity:get("Firable") and entity:get("Firable").cmd or nil
            if event.button == "moveforward" and dcmd then
                dcmd.forward=true
            elseif event.button == "movebackward" and dcmd then
                dcmd.backward=true
            elseif event.button == "turnleft" and dcmd then
                dcmd.turn_left=true
            elseif event.button == "turnright" and dcmd then
                dcmd.turn_right=true
            elseif event.button == "x" and dcmd then
                dcmd.toggle_light = not dcmd.toggle_light
            --elseif event.button == "left" and dcmd then
                --dcmd.turret_spin_neg = true
            --elseif event.button == "right" and dcmd then
                --dcmd.turret_spin_pos = true
            elseif event.button == "rightshoulder" and fcmd then
                fcmd.fire = true
            elseif event.button == "leftshoulder" and lcmd then
                lcmd.launch = true
            end
        end
    end
end

function NetGamepadHandler:fireNetReleasedEvent(event)
  for index, entity in pairs(engine:getEntitiesWithComponent("PlayerName")) do
      if entity:get("PlayerName").name == event.name then
          local dcmd = entity:get("Drivable") and entity:get("Drivable").cmd or nil
          local fcmd = entity:get("Firable") and entity:get("Firable").cmd or nil
          if event.button == "moveforward" and dcmd then
              dcmd.forward=false
          elseif event.button == "movebackward" and dcmd then
              dcmd.backward=false
          elseif event.button == "turn" and dcmd then
              dcmd.turn_left=false
              dcmd.turn_right=false
          --elseif event.button == "left" and dcmd then
              --dcmd.turret_spin_neg = false
          --elseif event.button == "right" and dcmd then
              --dcmd.turret_spin_pos = false
          elseif event.button == "rightshoulder" and fcmd then
              fcmd.fire = false
          end
      end
  end
end

return NetGamepadHandler
