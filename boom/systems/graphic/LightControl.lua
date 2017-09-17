local LightControl = class("LightControl", System)

function LightControl:update(dt)
    for k, entity in pairs(self.targets) do
        local light = entity:get("Light").light
        light:setVisible(entity:get("Drivable").cmd.toggle_light)
    end
end

function LightControl:requires()
    return {"Drivable", "Light"}
end

return LightControl
