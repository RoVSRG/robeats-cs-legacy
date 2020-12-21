local SFXManager = require(script.Parent.SFXManager)

local Hitsound = {}

function Hitsound:new()
	local self = {}
	
	function self:cons()
		self.sfxManager = SFXManager:new()

		self.sfxManager:preload(SFXManager.SFX_HITFXHIT, 10, 0.5)
	end

	function self:update()
		self.sfxManager:update()
	end

	function self:playHitsound(volume)
		self.sfxManager:playSfx(SFXManager.SFX_HITFXHIT, volume/2)
	end

	function self:teardown()
		self.sfxManager:teardown()
	end

	self:cons()
	
	return self
end

return Hitsound
