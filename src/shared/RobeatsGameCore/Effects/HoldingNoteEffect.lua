local EffectSystem = require(game.ReplicatedStorage.RobeatsGameCore.Effects.EffectSystem)
local SPUtil = require(game.ReplicatedStorage.Shared.SPUtil)
local CurveUtil = require(game.ReplicatedStorage.Shared.CurveUtil)
local NoteResult = require(game.ReplicatedStorage.RobeatsGameCore.Enums.NoteResult)
local EnvironmentSetup = require(game.ReplicatedStorage.RobeatsGameCore.EnvironmentSetup)

local HoldingNoteEffect = {}
HoldingNoteEffect.Type = "HoldingNoteEffect"

local STARTING_ALPHA = 1
local ENDING_ALPHA = 1

function HoldingNoteEffect:new(
	_game,
	_position,
	_note_result
)
	local self = EffectSystem:EffectBase()
	self.ClassName = HoldingNoteEffect.Type
	
	self._effect_obj = nil;
	self._anim_t = 0
	
	local function update_visual()
		self._effect_obj.Body.Transparency = 1
		
		self._effect_obj.Body.Size = Vector3.new(0,0,0)
	end	
	
	function self:cons()
		self._effect_obj = _game._object_pool:depool(self.ClassName)
		if self._effect_obj == nil then
			self._effect_obj = EnvironmentSetup:get_element_protos_folder().HoldingNoteEffectProto:Clone()
		end
		
		self._effect_obj.PrimaryPart.Position = _position
		
		if _note_result == NoteResult.Okay then
			self._effect_obj.PrimaryPart.BrickColor = BrickColor.new(243,237,0)
		elseif _note_result == NoteResult.Great then
			self._effect_obj.PrimaryPart.BrickColor = BrickColor.new(0,255,0)
		else
			self._effect_obj.PrimaryPart.BrickColor = BrickColor.new(0,207,256)
		end	
		
		self._effect_obj.PrimaryPart.Transparency = 1
		
		self._anim_t = 0
		update_visual()
	end	
	
	--[[Override--]] function self:add_to_parent(parent)
		self._effect_obj.Parent = parent
	end
	
	--[[Override--]] function self:update(dt_scale)
		self._anim_t = self._anim_t + CurveUtil:SecondsToTick(0.35) * dt_scale
		update_visual()	
	end	
	--[[Override--]] function self:should_remove()
		return self._anim_t >= 1
	end	
	--[[Override--]] function self:do_remove()
		_game._object_pool:repool(self.ClassName,self._effect_obj)
	end		
	
	self:cons()
	return self
end

return HoldingNoteEffect
