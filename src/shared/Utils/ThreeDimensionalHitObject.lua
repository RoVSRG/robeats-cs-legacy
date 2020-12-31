local EnvironmentSetup = require(game.ReplicatedStorage.Shared.Core.Engine.EnvironmentSetup)
local SPUtil = require(game.ReplicatedStorage.Shared.Utils.SPUtil)
local CurveUtil = require(game.ReplicatedStorage.Shared.Utils.CurveUtil)

local _values_set = false

local _outline_top_position_offset_default
local _outline_bottom_position_offset_default
local _body_adorn_default
local _outline_bottom_adorn_default
local _outline_top_adorn_default

local ThreeDimensionalHitObject = {}

function ThreeDimensionalHitObject:new(props)
	local _note_obj = EnvironmentSetup:get_element_protos_folder().SingleNoteAdornProto

    local self = {}
	self.noteInstance = _note_obj
	self.parent = nil

	local _body, _outline_top, _outline_bottom
	local _position = Vector3.new()
	local _body_adorn, _outline_top_adorn, _outline_bottom_adorn

    if not _values_set then
        _outline_top_position_offset_default = _note_obj.OutlineTop.Position - _note_obj.PrimaryPart.Position
        _outline_bottom_position_offset_default = _note_obj.OutlineBottom.Position - _note_obj.PrimaryPart.Position
        _body_adorn_default = _note_obj.Body.Adorn:Clone()
        _outline_bottom_adorn_default = _note_obj.OutlineBottom.Adorn:Clone()
        _outline_top_adorn_default = _note_obj.OutlineTop.Adorn:Clone()

        _values_set = true
    end
    self.noteInstance.Body.CFrame = (CFrame.new(Vector3.new()) * SPUtil:part_cframe_rotation(self.noteInstance.Body))
    self.noteInstance.OutlineTop.CFrame = (CFrame.new(Vector3.new()) * SPUtil:part_cframe_rotation(self.noteInstance.OutlineTop))
    self.noteInstance.OutlineBottom.CFrame = (CFrame.new(Vector3.new()) * SPUtil:part_cframe_rotation(self.noteInstance.OutlineBottom))

    _body = _note_obj.Body
    _outline_top = _note_obj.OutlineTop
    _outline_bottom = _note_obj.OutlineBottom
    _body_adorn = _body.Adorn
    _outline_top_adorn = _outline_top.Adorn
    _outline_bottom_adorn = _outline_bottom.Adorn

	function self:setParent(parent)
		self.parent = parent
        self.noteInstance.Parent = self.parent
    end

	function self:setVisualForAlpha(alpha)
		-- if alpha >= 0 then
		-- 	self.noteInstance.Parent = self.parent
		-- else
		-- 	self.noteInstance.Parent = nil
		-- end

        _position = SPUtil:vec3_lerp(
			props.playfield["Track"..props.lane].StartPosition.Position,
			props.playfield["Track"..props.lane].EndPosition.Position,
			alpha
		)
		--Magic number! Set Y position of single note to look good lined up against held note beginning/ends
		_position = Vector3.new(
			_position.X,
			0.25 + EnvironmentSetup:get_game_environment_center_position().Y,
			_position.Z
		)
		
		--Note scales in size from spawn (t=0, scale is 0.25) to deletion (t=1, scale is 0.925)
		local size = CurveUtil:YForPointOf2PtLine(
			Vector2.new(0,0.25),
			Vector2.new(1,0.925),
			SPUtil:clamp(alpha,0,1)
		)
		
		--Animate Body.Adorn, OutlineBottom.Adorn and OutlineTop.Adorn
		_body_adorn.CFrame = CFrame.new(_body.CFrame:vectorToObjectSpace(_position))
		_body_adorn.Height = size * _body_adorn_default.Height
		_body_adorn.Radius = size * _body_adorn_default.Radius

		_outline_bottom_adorn.CFrame = CFrame.new(_body.CFrame:vectorToObjectSpace(
			_position + (_outline_bottom_position_offset_default * size)
		))
		_outline_bottom_adorn.Height = size * _outline_bottom_adorn_default.Height
		_outline_bottom_adorn.Radius = size * _outline_bottom_adorn_default.Radius

		_outline_top_adorn.CFrame = CFrame.new(_body.CFrame:vectorToObjectSpace(
			_position + (_outline_top_position_offset_default * size)
		))
		_outline_top_adorn.Height = size * _outline_top_adorn_default.Height
		_outline_top_adorn.Radius = size * _outline_top_adorn_default.Radius
    end

    function self:destroy()
        self.noteInstance:Destroy()
    end

    return self
end

function ThreeDimensionalHitObject:newHold(_note_obj, props)
    local self = {}
	self.noteInstance = _note_obj
	self.parent = nil

	local _body, _outline_top, _outline_bottom
	local _position = Vector3.new()
	local _body_adorn, _outline_top_adorn, _outline_bottom_adorn

    if not _values_set then
        _outline_top_position_offset_default = _note_obj.OutlineTop.Position - _note_obj.PrimaryPart.Position
        _outline_bottom_position_offset_default = _note_obj.OutlineBottom.Position - _note_obj.PrimaryPart.Position
        _body_adorn_default = _note_obj.Body.Adorn:Clone()
        _outline_bottom_adorn_default = _note_obj.OutlineBottom.Adorn:Clone()
        _outline_top_adorn_default = _note_obj.OutlineTop.Adorn:Clone()

        _values_set = true
    end
    self.noteInstance.Body.CFrame = (CFrame.new(Vector3.new()) * SPUtil:part_cframe_rotation(self.noteInstance.Body))
    self.noteInstance.OutlineTop.CFrame = (CFrame.new(Vector3.new()) * SPUtil:part_cframe_rotation(self.noteInstance.OutlineTop))
    self.noteInstance.OutlineBottom.CFrame = (CFrame.new(Vector3.new()) * SPUtil:part_cframe_rotation(self.noteInstance.OutlineBottom))

    _body = _note_obj.Body
    _outline_top = _note_obj.OutlineTop
    _outline_bottom = _note_obj.OutlineBottom
    _body_adorn = _body.Adorn
    _outline_top_adorn = _outline_top.Adorn
    _outline_bottom_adorn = _outline_bottom.Adorn

	function self:setParent(parent)
		self.parent = parent
        self.noteInstance.Parent = self.parent
    end

	function self:setVisualForAlpha(alpha)
		-- if alpha >= 0 then
		-- 	self.noteInstance.Parent = self.parent
		-- else
		-- 	self.noteInstance.Parent = nil
		-- end

        _position = SPUtil:vec3_lerp(
			props.playfield["Track"..props.lane].StartPosition.Position,
			props.playfield["Track"..props.lane].EndPosition.Position,
			alpha
		)
		--Magic number! Set Y position of single note to look good lined up against held note beginning/ends
		_position = Vector3.new(
			_position.X,
			0.25 + EnvironmentSetup:get_game_environment_center_position().Y,
			_position.Z
		)
		
		--Note scales in size from spawn (t=0, scale is 0.25) to deletion (t=1, scale is 0.925)
		local size = CurveUtil:YForPointOf2PtLine(
			Vector2.new(0,0.25),
			Vector2.new(1,0.925),
			SPUtil:clamp(alpha,0,1)
		)
		
		--Animate Body.Adorn, OutlineBottom.Adorn and OutlineTop.Adorn
		_body_adorn.CFrame = CFrame.new(_body.CFrame:vectorToObjectSpace(_position))
		_body_adorn.Height = size * _body_adorn_default.Height
		_body_adorn.Radius = size * _body_adorn_default.Radius

		_outline_bottom_adorn.CFrame = CFrame.new(_body.CFrame:vectorToObjectSpace(
			_position + (_outline_bottom_position_offset_default * size)
		))
		_outline_bottom_adorn.Height = size * _outline_bottom_adorn_default.Height
		_outline_bottom_adorn.Radius = size * _outline_bottom_adorn_default.Radius

		_outline_top_adorn.CFrame = CFrame.new(_body.CFrame:vectorToObjectSpace(
			_position + (_outline_top_position_offset_default * size)
		))
		_outline_top_adorn.Height = size * _outline_top_adorn_default.Height
		_outline_top_adorn.Radius = size * _outline_top_adorn_default.Radius
    end

    function self:destroy()
        self.noteInstance:Destroy()
    end

    return self
end

return ThreeDimensionalHitObject
