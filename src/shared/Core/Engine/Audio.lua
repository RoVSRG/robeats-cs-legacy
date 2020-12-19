local Audio = {}

local function noop() end

function Audio:new(_callback)
	local self = {}
	self.sound = Instance.new("Sound")
	self.sound.Loaded:Connect(_callback or noop)
	
	function self:load(id)
		id = typeof(id) == "string" and id or "rbxassetid://"..tostring(id)
		self.sound.SoundId = id
		return function()
			self:play()
		end
	end
	
	function self:play()
		wait(1)
		self.sound:Play()
	end
	
	function self:pause()
		self.sound:Pause()
	end

	function self:stop(doDestroy)
		self.sound:Stop()
		if doDestroy then
			self:destroy()
		end
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
