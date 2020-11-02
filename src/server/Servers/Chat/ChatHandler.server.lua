local MenuBase = require(game.ReplicatedStorage.Menus.System.MenuBase)
local EnvironmentSetup = require(game.ReplicatedStorage.RobeatsGameCore.EnvironmentSetup)

local Social = {}

function Social:new(_local_services)
	
	local self = MenuBase:new()

	local _chat_ui
	
	local _enabled = false
	local _debounce = false

	function self:cons()
		_chat_ui = EnvironmentSetup:get_menu_protos_folder().SocialUI:Clone()
		_chat_ui.Parent = EnvironmentSetup:get_player_gui_root()
		
		for i,v in pairs(game.Players:GetChildren()) do
			self:add_player(v)
		end
		
		game.Players.PlayerAdded:Connect(function(plr)
			self:add_player(plr)
		end)
		
		game.Players.PlayerRemoving:Connect(function(plr)
			script.Parent.UserList[plr.Name]:Destroy()
		end)
		
		game:GetService("UserInputService").InputEnded:Connect(function(input, gameProcessed)
			if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.F8 then
				self:handle_ui()
			end
		end)
	end
	
	function self:add_player(plr)
		local player = _chat_ui.UserFrame.UserFrame:Clone()
		player.Icon.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. plr.UserId .. "&width=420&height=420&format=png"
		player.Icon.Player.Text = plr.Name
		player.Name = plr.Name
		player.Parent = _chat_ui.UserFrame.UserList
	end
	
	function self:remote_player(plr)
		_chat_ui.UserFrame.UserList[plr.Name]:Destroy()
		
	end
	
	function self:handle_ui()
		if _enabled and _debounce then
			_debounce = not _debounce
			_enabled = not _enabled
			_chat_ui.ChatFrame:TweenPosition(UDim2.new(0,0,1,0),"Out","Quad",0.5)
			_chat_ui.UserFrame:TweenPosition(UDim2.new(0,0,-0.65,0),"Out","Quad",0.5)
			wait(1)
			_debounce = not _debounce
		else
			_debounce = not _debounce
			_enabled = not _enabled
			_chat_ui.ChatFrame:TweenPosition(UDim2.new(0,0,0.65,0),"Out","Quad",0.5)
			_chat_ui.UserFrame:TweenPosition(UDim2.new(0,0,0,0),"Out","Quad",0.5)
			wait(1)
			_debounce = not _debounce
		end
	end
	
	self:cons()
	return self
end

return Social
