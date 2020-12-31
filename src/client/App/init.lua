local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local RoactRodux = require(game.ReplicatedStorage.Libraries.RoactRodux)
local RoactRouter = require(game.ReplicatedStorage.Libraries.RoactRouter)

local Components = game.ReplicatedStorage.Client.Components
local Screens = Components.Screens
local SongSelectMain = require(Screens.SongSelect)
local GameplayMain = require(Screens.Gameplay)
local Loading = require(Screens.Loading)
local Results = require(Screens.Results)
local Settings = require(Screens.Settings)
--local Multiplayer = require(Screens.Multiplayer)

local State = game.ReplicatedStorage.Client.State
local with = require(State.with)

local RoactApp = {}

function RoactApp:cons()
    Roact.setGlobalConfig({
        elementTracing = true
    })
end

function RoactApp:mount(_player_gui)
    local app = Roact.createElement(RoactRodux.StoreProvider, {
		store = require(State)
	}, {
        Router = Roact.createElement(RoactRouter.Router, {
            initialEntries = {"/select"};
            initialIndex = 1;
        }, {
            SongSelectMain = Roact.createElement(RoactRouter.Route, {
                path = "/select";
                exact = true;
                component = SongSelectMain;
            });
            GameplayMain = Roact.createElement(RoactRouter.Route, {
                path = "/gameplay";
                exact = true;
                component = GameplayMain;
            });
            Loading = Roact.createElement(RoactRouter.Route, {
                path = "/loading";
                exact = true;
                component = Loading;
            });
            Results = Roact.createElement(RoactRouter.Route, {
                path = "/results";
                exact = true;
                component = Results;
            });
            Settings = Roact.createElement(RoactRouter.Route, {
                path = "/settings";
                exact = true;
                component = Settings;
            });
            -- Multiplayer = Roact.createElement(RoactRouter.Route, {
            --     path = "/multiplayer";
            --     exact = true;
            --     component = Multiplayer;
            -- });
            Topbar = Roact.createElement("Frame", {
                Size = UDim2.new(1,0,36,0);
                BackgroundColor3 = Color3.fromRGB(35, 35, 35);
                AnchorPoint = Vector2.new(0,1);
            })
        });
	})

	Roact.mount(app, _player_gui)
end

RoactApp:cons()

return RoactApp
