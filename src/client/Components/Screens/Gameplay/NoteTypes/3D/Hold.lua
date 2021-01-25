local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local EnvironmentSetup = require(game.ReplicatedStorage.Shared.Core.Engine.EnvironmentSetup)
local ThreeDimensionalDefaults = require(game.ReplicatedStorage.Shared.Core.Data.ThreeDimensionalDefaults)

local SPUtil = require(game.ReplicatedStorage.Shared.Utils.SPUtil)
local CurveUtil = require(game.ReplicatedStorage.Shared.Utils.CurveUtil)

local Note = Roact.Component:extend("Note")

function Note:init()
    self._position = Vector3.new()

    self.threeDimensionalPlayfield = self.props.threeDimensionalPlayfield

    self.noteInstance = EnvironmentSetup:get_element_protos_folder().HeldNoteAdornProto:Clone()

    self.noteInstance.Body:SetPrimaryPartCFrame(CFrame.new(Vector3.new()) * SPUtil:part_cframe_rotation(self.noteInstance.Body.PrimaryPart))
    self.noteInstance.Body.BodyOutlineLeft.CFrame = (CFrame.new(Vector3.new()) * SPUtil:part_cframe_rotation(self.noteInstance.Body.BodyOutlineLeft))
    self.noteInstance.Body.BodyOutlineRight.CFrame = (CFrame.new(Vector3.new()) * SPUtil:part_cframe_rotation(self.noteInstance.Body.BodyOutlineRight))
    self.noteInstance.Head:SetPrimaryPartCFrame(CFrame.new(Vector3.new()) * SPUtil:part_cframe_rotation(self.noteInstance.Head.PrimaryPart))
    self.noteInstance.Head.HeadOutline.CFrame = (CFrame.new(Vector3.new()) * SPUtil:part_cframe_rotation(self.noteInstance.Head.HeadOutline))
    self.noteInstance.Tail:SetPrimaryPartCFrame(CFrame.new(Vector3.new()) * SPUtil:part_cframe_rotation(self.noteInstance.Tail.PrimaryPart))
    self.noteInstance.Tail.TailOutline.CFrame = (CFrame.new(Vector3.new()) * SPUtil:part_cframe_rotation(self.noteInstance.Tail.TailOutline))

    self.defaults = ThreeDimensionalDefaults:getDefaults()

    self.noteInstance.Parent = nil
end

function Note:didUpdate()    
    local _body
	local _head
	local _tail
	local _head_outline
	local _tail_outline
	local _body_outline_left
	local _body_outline_right
    local _body_adorn, _head_adorn, _tail_adorn, _head_outline_adorn, _tail_outline_adorn, _body_outline_left_adorn, _body_outline_right_adorn
    
    _body = self.noteInstance.Body.Body
    _body_adorn = _body.Adorn
    _head = self.noteInstance.Head.Head
    _head_adorn = _head.Adorn
    _tail = self.noteInstance.Tail.Tail
    _tail_adorn = _tail.Adorn
    _head_outline = self.noteInstance.Head.HeadOutline
    _head_outline_adorn = _head_outline.Adorn
    _tail_outline = self.noteInstance.Tail.TailOutline
    _tail_outline_adorn = _tail_outline.Adorn
    _body_outline_left = self.noteInstance.Body.BodyOutlineLeft
    _body_outline_left_adorn = _body_outline_left.Adorn
    _body_outline_right = self.noteInstance.Body.BodyOutlineRight
    _body_outline_right_adorn = _body_outline_right.Adorn

    local OVERALL_OFFSET = Vector3.new(0,-0.35,0)

    local alpha = self.props.alpha
    local holdAlpha = 0

    if self.props.releaseAlpha < 0 then
        holdAlpha = 0
    else
        holdAlpha = self.props.releaseAlpha
    end

    local head_pos = SPUtil:vec3_lerp(
        self.props.playfield["Track"..self.props.lane].StartPosition.Position,
        self.props.playfield["Track"..self.props.lane].EndPosition.Position,
        alpha
    )

    local tail_pos = SPUtil:vec3_lerp(
        self.props.playfield["Track"..self.props.lane].StartPosition.Position,
        self.props.playfield["Track"..self.props.lane].EndPosition.Position,
        holdAlpha
    )


    local tail_to_head = head_pos - tail_pos

    _head_adorn.CFrame = CFrame.new(_head.CFrame:vectorToObjectSpace(head_pos)) + OVERALL_OFFSET
    _tail_adorn.CFrame = CFrame.new(_tail.CFrame:vectorToObjectSpace(tail_pos)) + OVERALL_OFFSET
    
    _head_outline_adorn.CFrame = CFrame.new(_head_outline.CFrame:vectorToObjectSpace(head_pos + OVERALL_OFFSET + self.defaults.hold._hold_head_outline_position_offset_default))
    _tail_outline_adorn.CFrame = CFrame.new(_tail_outline.CFrame:vectorToObjectSpace(tail_pos + OVERALL_OFFSET + self.defaults.hold._hold_tail_outline_position_offset_default))

    if not self.props.headPressed then
        _head_adorn.Transparency = 0
        _head_outline_adorn.Transparency = 0
    else
        _head_adorn.Transparency = 1
        _head_outline_adorn.Transparency = 1
    end

    if self.props.releaseAlpha >= 0 then
        _tail_adorn.Transparency = 0
        _tail_outline_adorn.Transparency = 0
    else
        _tail_adorn.Transparency = 1
        _tail_outline_adorn.Transparency = 1
    end

    do
        --Set body rotation by setting the rotation of the adorn's parent part
        self.noteInstance.Body:SetPrimaryPartCFrame(
            CFrame.Angles(0, SPUtil:deg_to_rad(SPUtil:dir_ang_deg(tail_to_head.x,-tail_to_head.z) + 90), 0)
        )
        
        --Set Adorn position to halfway between head and tail position
        local body_pos = (tail_to_head * 0.5) + tail_pos
        _body_adorn.CFrame = CFrame.new(_body.CFrame:vectorToObjectSpace(body_pos) + OVERALL_OFFSET)
        
        --Calculate scaling factor magic number (to look good)
        local body_scale_factor = CurveUtil:YForPointOf2PtLine(
            Vector2.new(0,0.25),
            Vector2.new(1,0.65),
            SPUtil:clamp(self.props.alpha,0,1)
        )
        local body_radius = self.defaults.hold._hold_body_adorn_default.Radius * body_scale_factor

        _body_adorn.Height = tail_to_head.magnitude
        _body_adorn.Radius = body_radius
        
        --Set body outline positions to slightly wider than body radius (and then lower a bit)
        _body_outline_left_adorn.CFrame = CFrame.new(_body_outline_left.CFrame:vectorToObjectSpace(
            body_pos
        ) + Vector3.new(-body_radius * 1.15,-0.5,0))
        _body_outline_right_adorn.CFrame = CFrame.new(_body_outline_right.CFrame:vectorToObjectSpace(
            body_pos
        ) + Vector3.new(body_radius * 1.15,-0.5,0))
        
        _body_outline_left_adorn.Height = _body_adorn.Height
        _body_outline_right_adorn.Height = _body_adorn.Height
        _body_outline_left_adorn.Radius = self.defaults.hold._hold_body_outline_left_adorn_default.Radius * body_scale_factor
        _body_outline_right_adorn.Radius = self.defaults.hold._hold_body_outline_right_adorn_default.Radius * body_scale_factor
    end

    do
        --Scale head and tail scaling factor magic number (to look good)
        local head_scale_factor = CurveUtil:YForPointOf2PtLine(
            Vector2.new(0,0.383),
            Vector2.new(1,0.85),
            SPUtil:clamp(self.props.alpha,0,1)
        )
        local tail_scale_factor = CurveUtil:YForPointOf2PtLine(
            Vector2.new(0,0.383),
            Vector2.new(1,0.85),
            SPUtil:clamp(self.props.releaseAlpha,0,1)
        )

        _head_adorn.Radius = self.defaults.hold._hold_head_adorn_default.Radius * head_scale_factor
        _tail_adorn.Radius = self.defaults.hold._hold_tail_adorn_default.Radius * tail_scale_factor

        _head_outline_adorn.Radius = self.defaults.hold._hold_head_outline_adorn_default.Radius * head_scale_factor
        _tail_outline_adorn.Radius = self.defaults.hold._hold_tail_outline_adorn_default.Radius * tail_scale_factor
    end

    if self.props.releasedEarly then
        _body_adorn.Transparency = 0.8
        _body_outline_left_adorn.Transparency = 1
        _body_outline_right_adorn.Transparency = 1
    else
        _body_adorn.Transparency = 0
        _body_outline_left_adorn.Transparency = 0
        _body_outline_right_adorn.Transparency = 0
    end

    if self.noteInstance.Parent == nil then self.noteInstance.Parent = workspace.LocalElements end
end

function Note:render() return end

function Note:willUnmount()
    self.noteInstance:Destroy()
end

return Note
