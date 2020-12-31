local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local MultiplayerLobby = require(script.Parent.MultiplayerLobby)

local Story = require(game.ReplicatedStorage.Shared.Utils.Story)

local MultiplayerLobbyApp = Story:new()

function MultiplayerLobbyApp:newRoom(name, players, locked, inGame)
    return {name = name, players = players, locked = locked, inGame = inGame}
end

function MultiplayerLobbyApp:render()
    return Roact.createElement(MultiplayerLobby, {
        rooms = {
            self:newRoom("Test Room 1", 7, true, true);
            self:newRoom("Test Room 2", 6);
            self:newRoom("Test Room 3", 5);
            self:newRoom("Test Room 4", 4);
        }
    })
end

return MultiplayerLobbyApp
