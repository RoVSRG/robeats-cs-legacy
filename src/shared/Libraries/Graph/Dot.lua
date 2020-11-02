local GraphBase = require(script.Parent.GraphBase)
local NumberUtil = require(game.ReplicatedStorage.Libraries.NumberUtil)

local SPUtil = require(game.ReplicatedStorage.Shared.SPUtil)
local SPList = require(game.ReplicatedStorage.Shared.SPList)

local Dot = {}

function Dot:new()
    local self = GraphBase:new()
    self.tween_queue = SPList:new()

    --[[Override--]] function self:add_data_point(params)
        assert(params.x ~= nil, "X must not be nil")
        assert(params.y ~= nil, "Y must not be nil")
        assert(self.attached_instance ~= nil, "You must attach an Instance first!")

        local _position = UDim2.new(NumberUtil.InverseLerp(self.x_lower_bound, self.x_upper_bound, params.x), 0, NumberUtil.InverseLerp(self.y_lower_bound, self.y_upper_bound, params.y), 0)

        local dot_instance = Instance.new("Frame")
        dot_instance.BorderSizePixel = 0
        dot_instance.Size = UDim2.new(0,3,0,3)
        dot_instance.AnchorPoint = Vector2.new(0.5, 0.5)
        dot_instance.BackgroundColor3 = params.color or Color3.new(0.9,0.9,0.9)
        dot_instance.Position = UDim2.new(1,0,math.clamp(math.random(), 0.3, 0.7),0)
        dot_instance.Parent = self.attached_instance

        self.tween_queue:push_back({
            instance = dot_instance;
            position = _position;
        })

        return dot_instance
    end

    function self:add_line(params)
        assert(params.x ~= nil, "X must not be nil")
        assert(self.attached_instance ~= nil, "You must attach an Instance first!")

        local line_instance = Instance.new("Frame")
        line_instance.BorderSizePixel = 0
        line_instance.Size = UDim2.new(0,1,1,0)
        line_instance.Position = UDim2.new(NumberUtil.InverseLerp(self.x_lower_bound, self.x_upper_bound, params.x), 0, 0, 0)
        line_instance.AnchorPoint = Vector2.new(0.5, 0)
        line_instance.BackgroundColor3 = params.color or Color3.fromRGB(255, 21, 0)
        line_instance.BackgroundTransparency = 0.7
        line_instance.Parent = self.attached_instance

        return line_instance
    end

    function self:add_y_markers(y_int)
        assert(self.attached_instance ~= nil, "You must attach an Instance first!")
        assert(y_int ~= nil, "You must pass in an y-interval!")

        local y_magnitude = math.abs(self.y_lower_bound)+math.abs(self.y_upper_bound)
        local num_y_markers = y_magnitude/y_int

        for cury = self.y_lower_bound, self.y_upper_bound, y_int do
            local text_marker = Instance.new("TextLabel")

            text_marker.Size = UDim2.new(0.2,0,1/num_y_markers,0)
            text_marker.Position = UDim2.new(0.01,0,NumberUtil.InverseLerp(self.y_lower_bound, self.y_upper_bound, cury),0)
            text_marker.BorderSizePixel = 0
            text_marker.BackgroundTransparency = 1
            text_marker.TextColor3 = Color3.fromRGB(255,255,255)
            text_marker.TextXAlignment = Enum.TextXAlignment.Left
            text_marker.TextTransparency = 0.7
            text_marker.Text = cury.." -"
            text_marker.AnchorPoint = Vector2.new(0, 0.5)
            text_marker.Font = Enum.Font.GothamSemibold
            text_marker.Parent = self.attached_instance
            text_marker.Name = "Y-Axis Marker"

            local line_marker = Instance.new("Frame")
            line_marker.BorderSizePixel = 0
            line_marker.Size = UDim2.new(1, 0, 0, 1)
            line_marker.Position = UDim2.new(0,0,NumberUtil.InverseLerp(self.y_lower_bound, self.y_upper_bound, cury),0)
            line_marker.AnchorPoint = Vector2.new(0, 0.5)
            line_marker.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            line_marker.BackgroundTransparency = 0.55
            line_marker.Parent = self.attached_instance
        end
    end

    function self:animate_tweens()
        SPUtil:spawn(function()
            for i = 1, self.tween_queue:count() do
                local itr_instance = self.tween_queue:get(i)
                itr_instance.instance:TweenPosition(itr_instance.position, Enum.EasingDirection.In, Enum.EasingStyle.Quart, (i/self.tween_queue:count())*0.7)
            end
        end)
    end

    return self
end

return Dot