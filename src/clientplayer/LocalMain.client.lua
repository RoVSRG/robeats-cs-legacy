local Knit = require(game:GetService("ReplicatedStorage").Knit)
Knit.Start():Catch(warn):Await()

local EnvironmentSetup = require(game.ReplicatedStorage.Client.Components.Screens.Gameplay.Engine.EnvironmentSetup)

local function game_init()
	EnvironmentSetup:initial_setup()
	-- local local_services = {
		
	-- 	_menus = MenuSystem:new();
	-- 	_state = StateUtil:new(State)
	-- }

	-- local_services._menus:push_menu(SongSelectMenu:new(local_services))

	-- local update_connection
	-- update_connection = game:GetService("RunService").Heartbeat:Connect(function(tick_delta)
	-- 	local success, err = SPUtil:try(function()
	-- 		local dt_scale = CurveUtil:DeltaTimeToTimescale(tick_delta)
	-- 		local_services._menus:update(dt_scale)
	-- 		local_services._sfx_manager:update(dt_scale)
	-- 		local_services._input:post_update()
	-- 	end)
		
	-- 	if success ~= true then
	-- 		update_connection:Disconnect()
	-- 		error(string.format("Error (Stopping Game):%s\n%s", err.Error, err.StackTrace))
	-- 	end
	-- end)
end

game_init()
