local Audio = {}

local function noop() end

function Audio:new(_callback)
	local self = {}
	self.sound = Instance.new("Sound")
	self.sound.Loaded:Connect(_callback or noop)
	
	function self:load(id)
		id = typeof(id) == "string" and id or "rbxassetid://"..tostring(id)
		self.sound.SoundId = id
		self.sound.Playing = true
		self.sound.PlaybackSpeed = 0
		return function()
			self:play()
		end
	end
	
	function self:play()
		self.sound.PlaybackSpeed = 1
	end
	
	function self:pause()
		self.sound.PlaybackSpeed = 0
	end

	function self:stop(doDestroy)
		self.sound:Stop()
		if doDestroy then
			self:destroy()
		end
	end

	function self:is_playing()
		return self.sound.PlaybackSpeed > 0
	end

	function self:destroy()
		self.sound:Destroy()
	end

	function self:loaded()
		return self.sound.IsLoaded
	end
	
	function self:parent(parent)
		self.sound.Parent = parent
	end
	
	return self
end

return Audio
