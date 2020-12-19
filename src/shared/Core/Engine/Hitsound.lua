local Hitsound = {}

function Hitsound:new(props)
	local self = {}
	self.audioId = "rbxassetid://4652790330"
	
	function self:PlayHitsound(volume)
		spawn(function()
			local hitsound = Instance.new("Sound")
			hitsound.SoundId = self.audioId
			hitsound.Volume = volume / 2
			hitsound.Parent = game.SoundService
			hitsound:Play()
		end)
	end
	
	return self
end

return Hitsound
