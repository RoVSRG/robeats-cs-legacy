local Network = require(game.ReplicatedStorage.Network)
local SPUtil = require(game.ReplicatedStorage.Shared.SPUtil)
local DebugOut = require(game.ReplicatedStorage.Shared.DebugOut)

local LeaderboardDisplay = {}

LeaderboardDisplay.PlaceColors = {
	[1] = Color3.fromRGB(204, 204, 8);
	[2] = Color3.fromRGB(237, 162, 12);
	[3] = Color3.fromRGB(237, 106, 12);
}

function LeaderboardDisplay:new(_local_services, _leaderboard_ui_root, _leaderboard_proto, _on_leaderboard_click)
	local self = {}
	_leaderboard_proto.Parent = nil
	local _leaderboard_list_root = _leaderboard_ui_root.LeaderboardList
	local _leaderboard_loading_display = _leaderboard_ui_root.LoadingDisplay
	_leaderboard_loading_display.Visible = false
	
	_leaderboard_list_root.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		_leaderboard_list_root.CanvasSize = UDim2.new(0, 0, 0, _leaderboard_list_root.UIListLayout.AbsoluteContentSize.Y)
	end)
	_leaderboard_list_root.CanvasSize = UDim2.new(0, 0, 0, 0)
	
	local function get_formatted_data(data)
		local str = "%.2f%% | %0d / %0d / %0d / %0d / %0d / %0d"
		return string.format(str, data.accuracy, data.marvelouses, data.perfects, data.greats, data.goods, data.bads, data.misses)
	end
	
	local _last_load_start_time
	function self:refresh_leaderboard(songkey)
		DebugOut:puts("loading leaderboard for songkey(%s)...",tostring(songkey))
		_last_load_start_time = tick()
		local load_start_time = _last_load_start_time
		_leaderboard_loading_display.Visible = true
		SPUtil:spawn(function()
			--// CLEAR LEADERBOARD LIST
			for i, v in pairs(_leaderboard_list_root:GetChildren()) do
				if v:IsA("Frame") then
					v:Destroy()
				end
			end

			--// GET NEW LEADERBOARD
			local leaderboardData = Network.GetLeaderboard:Invoke({
				mapid = songkey
			}) or {}
			if load_start_time ~= _last_load_start_time then
				return --loaded another leaderboard since when this load was begun, do not display info
			end
			DebugOut:puts("Showing leaderboard for songkey(%s)!",tostring(songkey))

			table.sort(leaderboardData, function(a, b)
				if a.rating == b.rating then
					return a.score > b.score
				end
				return a.rating > b.rating
			end)
			
			--// RENDER NEW LEADERBOARD
			for itr, itr_data in pairs(leaderboardData) do
				local itr_leaderboard_proto = _leaderboard_proto:Clone()

				itr_leaderboard_proto.UserThumbnail.Player.Text = string.format("%s at %s", itr_data.playername, SPUtil:time_to_str(itr_data.time))
				itr_leaderboard_proto.UserThumbnail.Data.Text = get_formatted_data(itr_data)
				itr_leaderboard_proto.UserThumbnail.Place.Text = string.format("#%d", itr)
				itr_leaderboard_proto.UserThumbnail.Image = string.format("https://www.roblox.com/headshot-thumbnail/image?userId=%d&width=420&height=420&format=png", itr_data.userid)
				itr_leaderboard_proto.UserThumbnail.Place.TextColor3 = LeaderboardDisplay.PlaceColors[itr] or Color3.fromRGB(200, 200, 200)

				SPUtil:button(itr_leaderboard_proto, UDim2.new(0,4,0,0), _local_services, function()
					itr_data.hitdeviance = Network.GetDeviance:Invoke({
						mapid = songkey;
						userid = itr_data.userid;
					})
					if _on_leaderboard_click then _on_leaderboard_click(itr_data) end
				end)

				itr_leaderboard_proto.Parent = _leaderboard_list_root
			end
			_leaderboard_loading_display.Visible = false
		end)
	end
	return self
end
return LeaderboardDisplay