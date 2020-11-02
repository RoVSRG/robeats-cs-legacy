local MessagingService = game:GetService("MessagingService")

local Social = {}

function Social:new()
	
	local self = {}
	
	self.channels = {
		"Global",
	}

	function self:filter_text(data)
		local newdata = {
			message = data.message:GetChatForUserAsync(data.player.id),
			player = data.player
		}
		return newdata
	end
	
	function self:send_message(data)
		MessagingService:PublishAsync("chatservice", self:filter_text(data))
		return true
	end
	
	function self:create_channel(data)
		table.insert(self.channels,data.channel)
	end
	
	function self:change_channel(data)
		
	end

end

return Social