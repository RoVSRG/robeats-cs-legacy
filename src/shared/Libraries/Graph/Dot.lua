local GraphBase = require(script.Parent.GraphBase)
local NumberUtil = require(game.ReplicatedStorage.Libraries.NumberUtil)

local Dot = {}

function Dot:new()
    local self = GraphBase:new()

    --[[Override--]] function self:add_data_point(params)
        assert(params.x ~= nil, "X must not be nil")
        assert(params.y ~= nil, "Y must not be nil")
        assert(self.attached_instance ~= nil, "You must attach an Instance first!")

        local dot_instance = Instance.new("Frame")
        dot_instance.BorderSizePixel = 0
        dot_instance.Size = UDim2.new(0,3,0,3)
        dot_instance.Position = UDim2.new(NumberUtil.InverseLerp(self.x_lower_bound, self.x_upper_bound, params.x), 0, NumberUtil.InverseLerp(self.y_lower_bound, self.y_upper_bound, params.y), 0)
        dot_instance.BackgroundColor3 = params.color or Color3.new(0.9,0.9,0.9)
        dot_instance.Parent = self.attached_instance

        return dot_instance
    end

    function self:add_markers(x_int, y_int, div_x, div_y)
        assert(self.attached_instance ~= nil, "You must attach an Instance first!")
        assert(x_int ~= nil, "You must pass in an x-interval!")
        assert(y_int ~= nil, "You must pass in an y-interval!")
        
        local x_magnitude = math.abs(self.x_lower_bound)+math.abs(self.x_upper_bound)
        local y_magnitude = math.abs(self.y_lower_bound)+math.abs(self.y_upper_bound)

        local num_x_markers = x_magnitude/x_int
        local num_y_markers = y_magnitude/y_int

        for curx = self.x_lower_bound, self.x_upper_bound, x_int do
            local text_marker = Instance.new("TextLabel")
            text_marker.Size = UDim2.new(1/num_x_markers,0,0.2,0)
            text_marker.Position = UDim2.new(curx/x_magnitude,0,0,0)
            text_marker.BorderSizePixel = 0
            text_marker.BackgroundTransparency = 1
            text_marker.TextColor3 = Color3.fromRGB(255,255,255)
            text_marker.TextStrokeTransparency = 0
            text_marker.TextStrokeColor3 = Color3.fromRGB(0,0,0)
            text_marker.TextXAlignment = Enum.TextXAlignment.Center
            text_marker.Text = curx
            text_marker.Parent = self.attached_instance
            text_marker.Name = "X-Axis Marker"
        end

        for cury = self.y_lower_bound, self.y_upper_bound, y_int do
            local text_marker = Instance.new("TextLabel")
            
            text_marker.Size = UDim2.new(0.2,0,1/num_y_markers,0)
            text_marker.Position = UDim2.new(0,0,cury/y_magnitude,0)
            text_marker.BorderSizePixel = 0
            text_marker.BackgroundTransparency = 1
            text_marker.TextColor3 = Color3.fromRGB(255,255,255)
            text_marker.TextStrokeTransparency = 0
            text_marker.TextStrokeColor3 = Color3.fromRGB(0,0,0)
            text_marker.TextXAlignment = Enum.TextXAlignment.Left
            text_marker.Text = cury.." -"
            text_marker.Parent = self.attached_instance
            text_marker.Name = "Y-Axis Marker"
        end
    end

    return self
end

return Dot