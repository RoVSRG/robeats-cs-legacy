local SFXManager = require(script.Parent.SFXManager)

local Hitsound = {}

function Hitsound:new()
	local self = {}
	
	function self:cons()
		do return end
		self.sfxManager = SFXManager.new()

		self.sfxManager:preload(SFXManager.SFX_HITFXHIT, 10, 0.5)
	end

	function self:update()
		do return end
		self.sfxManager:update()
	end

	function self:playHitsound(volume)
		do return end
		self.sfxManager:playSfx(SFXManager.SFX_HITFXHIT, volume/2)
	end

	function self:teardown()
		do return end
		self.sfxManager:teardown()
	end

	self:cons()
	
	return self
end

return Hitsound
