local GameOverHandler = class("GameOverHandler", System)

function GameOverHandler:fireGameOver(event)
    print("Game Over!")
end

return GameOverHandler
