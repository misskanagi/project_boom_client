local Class = require "libs.hump.class"

-- command base class
local Command = Class{}

function Command:init()
end

function Command:execute(actor)
end

-- jump command class

local JumpCommand = Class{__includes = Command}

function JumpCommand:init()
end

function JumpCommand:execute(actor)
end

-- fire command class

local FireCommand = Class{__includes = Command}

function FireCommand:init()
end

function FireCommand:execute(actor)
end

-- up command class

local UpCommand = Class{__includes = Command}

function UpCommand:init()
end

function UpCommand:execute(actor)
end

-- down command class

local DownCommand = Class{__includes = Command}

function DownCommand:init()
end

function DownCommand:execute(actor)
end

-- left command class

local LeftCommand = Class{__includes = Command}

function LeftCommand:init()
end

function LeftCommand:execute(actor)
end

-- right command class

local RightCommand = Class{__includes = Command}

function RightCommand:init()
end

function RightCommand:execute(actor)
end

-- use command class

local UseCommand = Class{__includes = Command}

function UseCommand:init()
end

function UseCommand:execute(actor)
end

return {fire=FireCommand, up=UpCommand, down=DownCommand, left=LeftCommand,
right=RightCommand, use=UseCommand}
