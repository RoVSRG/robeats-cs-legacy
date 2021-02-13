local SPMultiDict = require(game.ReplicatedStorage.Shared.Utils.SPMultiDict)

local SFXManager = {}

SFXManager.SFX_HITFXHIT = "rbxassetid://4652790330"

SFXManager.SFX_DRUM_OKAY = "rbxassetid://574838536"
SFXManager.SFX_MISS = "rbxassetid://574838230"
SFXManager.SFX_TICK = "rbxassetid://574838785"

SFXManager.SFX_COUNTDOWN_READY = "rbxassetid://770375074"
SFXManager.SFX_COUNTDOWN_GO = "rbxassetid://770373595"

SFXManager.SFX_WOOSH = "rbxassetid://770375537"
SFXManager.SFX_ACQUIRE = "rbxassetid://770372288"
SFXManager.SFX_BUTTONPRESS = "rbxassetid://395321405"
SFXManager.SFX_COMBINE = "rbxassetid://770372702"
SFXManager.SFX_HOVER = "rbxassetid://4740147336"

SFXManager.SFX_FANFARE = "rbxassetid://770373343"
SFXManager.SFX_MENU_BUY = "rbxassetid://770373814"
SFXManager.SFX_MENU_CLOSE = "rbxassetid://3566589257"
SFXManager.SFX_MENU_OPEN = "rbxassetid://3566589257"
SFXManager.SFX_MENU_CLOSE_LONG = "rbxassetid://770374214"
SFXManager.SFX_MENU_OPEN_LONG = "rbxassetid://770374514"
SFXManager.SFX_USE = "rbxassetid://770375349"

SFXManager.SFX_CROWD_TEMP = "rbxassetid://770373135"

SFXManager.SFX_BOO_1 = "rbxassetid://786602539"
SFXManager.SFX_ENDCHEER_1 = "rbxassetid://786602445"
SFXManager.SFX_FEVERCHEER_1 = "rbxassetid://786602324"
SFXManager.SFX_STARTCHEER_1 = "rbxassetid://786602174"

function SFXManager.new()
	local self = {}

	local sfxPooledParent = Instance.new("Folder")
	sfxPooledParent.Name = "SFXPooledParent"
	sfxPooledParent.Parent = workspace

	local sfxActiveParent = Instance.new("Folder")
	sfxActiveParent.Parent = workspace
	sfxActiveParent.Name = "SFXActiveParent"

	self.keyToPooledSound = SPMultiDict:new()
	self.keyToActiveSound = SPMultiDict:new()

	local function createPooled(sfx_key, volume)
		if volume == nil then
			volume = 0.5
		end

		local rtv = Instance.new("Sound")
		rtv.Parent = sfxActiveParent
		rtv.SoundId = sfx_key
		rtv.Name = string.format("%s",sfx_key)
		rtv.Parent = sfxPooledParent
		rtv.Playing = false
		rtv.Volume = volume

		self.keyToPooledSound:push_back_to(sfx_key,rtv)
	end

	function self:cons()
		for i=0,3 do
			createPooled(SFXManager.SFX_DRUM_OKAY,0.25)
			createPooled(SFXManager.SFX_MISS)
		end
		for i=0,2 do
			createPooled(SFXManager.SFX_COUNTDOWN_READY)
		end
		for i=0,1 do
			createPooled(SFXManager.SFX_COUNTDOWN_GO)
		end

		createPooled(SFXManager.SFX_COUNTDOWN_READY)
		createPooled(SFXManager.SFX_COUNTDOWN_READY)
		createPooled(SFXManager.SFX_COUNTDOWN_GO)

		createPooled(SFXManager.SFX_WOOSH)
		for i=0,5 do
			createPooled(SFXManager.SFX_BUTTONPRESS, 1.5)
		end
		for i=0,10 do
			createPooled(SFXManager.SFX_HOVER, 0.2)
		end
	end

	function self:preload(sfx_key, count, volume)
		for i=1,count do
			createPooled(sfx_key,volume)
		end
	end

	function self:playSfx(sfx_key,volume)
		if self.keyToPooledSound:count_of(sfx_key) == 0 then
			createPooled(sfx_key)
		end

		local playSfx = self.keyToPooledSound:pop_back_from(sfx_key)
		playSfx.TimePosition = 0
		playSfx.Looped = false
		playSfx.Playing = true
		playSfx.Parent = sfxActiveParent
		if volume ~= nil then
			playSfx.Volume = volume
		end

		self.keyToActiveSound:push_back_to(sfx_key,playSfx)
		return playSfx
	end

	function self:update(dt_scale)
		for itrKey,_ in self.keyToActiveSound:key_itr() do
			local itrList = self.keyToActiveSound:list_of(itrKey)
			for i=itrList:count(),1,-1 do
				local itr_sound = itrList:get(i)
				if itr_sound.Looped == false and itr_sound.Playing == false then
					itr_sound.Parent = sfxPooledParent
					self.keyToPooledSound:push_back_to(itrKey,itr_sound)
					itrList:remove_at(i)
				end
			end
		end
	end

	function self:teardown()
		sfxPooledParent:Destroy()
		sfxActiveParent:Destroy()
	end

	self:cons()
	return self;
end

return SFXManager
