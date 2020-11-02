local SPList = require(game.ReplicatedStorage.Shared.SPList)
local NumberUtil = require(game.ReplicatedStorage.Libraries.NumberUtil)

local TweenService = game:GetService("TweenService")

local Number = {}

function Number:new(_time, _easing_style, _easing_direction)
    local self = {}
    local _bound = SPList:new()

    local _a = 0
    local _start_time = tick()
    local _end_time = _start_time + _time
    local _cur_time = _start_time

    function self:start()
        _start_time = tick()
        _end_time = _start_time + _time
        _cur_time = _start_time
    end

    function self:stop()
        _bound:clear()
    end

    function self:bind(_callback)
        _bound:push_back(_callback)
    end

    function self:update(timescale)
        _cur_time += timescale
        for i = 1, _bound:count() do
            _bound:get(i)(self:get_value())
        end
    end

    function self:get_value()
        return TweenService:GetValue(math.clamp(NumberUtil.InverseLerp(_start_time, _end_time, _cur_time), 0, 1), _easing_style or Enum.EasingStyle.Quad, _easing_direction or Enum.EasingDirection.InOut)
    end

    return self
end

return Number
