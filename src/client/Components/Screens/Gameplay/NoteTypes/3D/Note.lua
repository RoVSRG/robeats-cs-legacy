local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local EnvironmentSetup = require(game.ReplicatedStorage.Shared.Core.Engine.EnvironmentSetup)
local ThreeDimensionalDefaults = require(game.ReplicatedStorage.Shared.Core.Data.ThreeDimensionalDefaults)

local SPUtil = require(game.ReplicatedStorage.Shared.Utils.SPUtil)
local CurveUtil = require(game.ReplicatedStorage.Shared.Utils.CurveUtil)

local Note = Roact.Component:extend("Note")

function Note:init()
    self._position = Vector3.new()

    self.threeDimensionalPlayfield = self.props.threeDimensionalPlayfield

    self.noteInstance = EnvironmentSetup:get_element_protos_folder().SingleNoteAdornProto:Clone()

    self.noteInstance.Body.CFrame = (CFrame.new(Vector3.new()) * SPUtil:part_cframe_rotation(self.noteInstance.Body))
    self.noteInstance.OutlineTop.CFrame = (CFrame.new(Vector3.new()) * SPUtil:part_cframe_rotation(self.noteInstance.OutlineTop))
    self.noteInstance.OutlineBottom.CFrame = (CFrame.new(Vector3.new()) * SPUtil:part_cframe_rotation(self.noteInstance.OutlineBottom))

    self.defaults = ThreeDimensionalDefaults:getDefaults()

    self.noteInstance.Parent = nil
end

function Note:didUpdate()
    self._position = SPUtil:vec3_lerp(
        self.props.playfield["Track"..self.props.lane].StartPosition.Position,
        self.props.playfield["Track"..self.props.lane].EndPosition.Position,
        self.props.alpha
    )
    --Magic number! Set Y position of single note to look good lined up against held note beginning/ends
    self._position = Vector3.new(
        self._position.X,
        0.25 + EnvironmentSetup:get_game_environment_center_position().Y,
        self._position.Z
    )
    
    --Note scales in size from spawn (t=0, scale is 0.25) to deletion (t=1, scale is 0.925)
    local size = CurveUtil:YForPointOf2PtLine(
        Vector2.new(0,0.25),
        Vector2.new(1,0.925),
        SPUtil:clamp(self.props.alpha,0,1)
    )
    
    -- Body is not a valid member of Model "SingleNoteAdornProto" ???????????? what

    local _body = self.noteInstance.Body
    local _outline_top = self.noteInstance.OutlineTop
    local _outline_bottom = self.noteInstance.OutlineBottom
    local _body_adorn = _body.Adorn
    local _outline_top_adorn = _outline_top.Adorn
    local _outline_bottom_adorn = _outline_bottom.Adorn
    
    --Animate Body.Adorn, OutlineBottom.Adorn and OutlineTop.Adorn
    _body_adorn.CFrame = CFrame.new(_body.CFrame:vectorToObjectSpace(self._position))
    _body_adorn.Height = size * self.defaults.note._body_adorn_default.Height
    _body_adorn.Radius = size * self.defaults.note._body_adorn_default.Radius
    _outline_bottom_adorn.CFrame = CFrame.new(_body.CFrame:vectorToObjectSpace(
        self._position + (self.defaults.note._outline_bottom_position_offset_default * size)
    ))
    _outline_bottom_adorn.Height = size * self.defaults.note._outline_bottom_adorn_default.Height
    _outline_bottom_adorn.Radius = size * self.defaults.note._outline_bottom_adorn_default.Radius

    _outline_top_adorn.CFrame = CFrame.new(_body.CFrame:vectorToObjectSpace(
        self._position + (self.defaults.note._outline_top_position_offset_default * size)
    ))
    _outline_top_adorn.Height = size * self.defaults.note._outline_top_adorn_default.Height
    _outline_top_adorn.Radius = size * self.defaults.note._outline_top_adorn_default.Radius

    if self.noteInstance.Parent == nil then self.noteInstance.Parent = workspace.LocalElements end
end

function Note:render() return end

function Note:willUnmount()
    self.noteInstance:Destroy()
end

return Note
