local EnvironmentSetup = require(game.ReplicatedStorage.Shared.Core.Engine.EnvironmentSetup)
local SPUtil = require(game.ReplicatedStorage.Shared.Utils.SPUtil)

local ThreeDimensionalDefaults = {}

local _defaults

function ThreeDimensionalDefaults:getDefaults()
    if _defaults then return _defaults end
    local _note_obj = EnvironmentSetup:get_element_protos_folder().SingleNoteAdornProto

    local _outline_top_position_offset_default
    local _outline_bottom_position_offset_default
    local _body_adorn_default
    local _outline_bottom_adorn_default
    local _outline_top_adorn_default

    _outline_top_position_offset_default = _note_obj.OutlineTop.Position - _note_obj.PrimaryPart.Position
    _outline_bottom_position_offset_default = _note_obj.OutlineBottom.Position - _note_obj.PrimaryPart.Position
    _body_adorn_default = _note_obj.Body.Adorn:Clone()
    _outline_bottom_adorn_default = _note_obj.OutlineBottom.Adorn:Clone()
    _outline_top_adorn_default = _note_obj.OutlineTop.Adorn:Clone()

    _note_obj = EnvironmentSetup:get_element_protos_folder().HeldNoteAdornProto:Clone()

    local _hold_head_outline_position_offset_default
    local _hold_tail_outline_position_offset_default
    local _hold_head_adorn_default
    local _hold_head_outline_adorn_default
    local _hold_tail_adorn_default
    local _hold_tail_outline_adorn_default
    local _hold_body_adorn_default
    local _hold_body_outline_left_adorn_default
    local _hold_body_outline_right_adorn_default

    _hold_head_outline_position_offset_default = _note_obj.Head.HeadOutline.Position - _note_obj.Head.Head.Position
    _hold_tail_outline_position_offset_default = _note_obj.Tail.TailOutline.Position - _note_obj.Tail.Tail.Position
    _hold_head_adorn_default = _note_obj.Head.Head.Adorn:Clone()
    _hold_head_outline_adorn_default = _note_obj.Head.HeadOutline.Adorn:Clone()
    _hold_tail_adorn_default = _note_obj.Tail.Tail.Adorn:Clone()
    _hold_tail_outline_adorn_default = _note_obj.Tail.TailOutline.Adorn:Clone()
    _hold_body_adorn_default = _note_obj.Body.Body.Adorn:Clone()
    _hold_body_outline_left_adorn_default = _note_obj.Body.BodyOutlineLeft.Adorn:Clone()
    _hold_body_outline_right_adorn_default = _note_obj.Body.BodyOutlineRight.Adorn:Clone()
    
    --We are animating the Adorn CFrames, so set the parent parts to position (0,0,0) but keep the rotation
    _note_obj.Body:SetPrimaryPartCFrame(CFrame.new(Vector3.new()) * SPUtil:part_cframe_rotation(_note_obj.Body.PrimaryPart))
    _note_obj.Body.BodyOutlineLeft.CFrame = (CFrame.new(Vector3.new()) * SPUtil:part_cframe_rotation(_note_obj.Body.BodyOutlineLeft))
    _note_obj.Body.BodyOutlineRight.CFrame = (CFrame.new(Vector3.new()) * SPUtil:part_cframe_rotation(_note_obj.Body.BodyOutlineRight))
    _note_obj.Head:SetPrimaryPartCFrame(CFrame.new(Vector3.new()) * SPUtil:part_cframe_rotation(_note_obj.Head.PrimaryPart))
    _note_obj.Head.HeadOutline.CFrame = (CFrame.new(Vector3.new()) * SPUtil:part_cframe_rotation(_note_obj.Head.HeadOutline))
    _note_obj.Tail:SetPrimaryPartCFrame(CFrame.new(Vector3.new()) * SPUtil:part_cframe_rotation(_note_obj.Tail.PrimaryPart))
    _note_obj.Tail.TailOutline.CFrame = (CFrame.new(Vector3.new()) * SPUtil:part_cframe_rotation(_note_obj.Tail.TailOutline))

    _defaults = {
        note = {
            _outline_top_position_offset_default = _outline_top_position_offset_default;
            _outline_bottom_position_offset_default = _outline_bottom_position_offset_default;
            _body_adorn_default = _body_adorn_default;
            _outline_bottom_adorn_default = _outline_bottom_adorn_default;
            _outline_top_adorn_default = _outline_top_adorn_default;
        };
        hold = {
            _hold_head_outline_position_offset_default = _hold_head_outline_position_offset_default;
            _hold_tail_outline_position_offset_default = _hold_tail_outline_position_offset_default;
            _hold_head_adorn_default = _hold_head_adorn_default;
            _hold_head_outline_adorn_default = _hold_head_outline_adorn_default;
            _hold_tail_adorn_default = _hold_tail_adorn_default;
            _hold_tail_outline_adorn_default = _hold_tail_outline_adorn_default;
            _hold_body_adorn_default = _hold_body_adorn_default;
            _hold_body_outline_left_adorn_default = _hold_body_outline_left_adorn_default;
            _hold_body_outline_right_adorn_default = _hold_body_outline_right_adorn_default;
        }
    }

    return _defaults
end

return ThreeDimensionalDefaults
