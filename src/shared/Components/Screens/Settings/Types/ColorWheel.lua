local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local ColorWheelView = require(script.Parent.ColorWheelView)

local UserInputService = game:GetService("UserInputService")

local ColorWheel = Roact.Component:extend("ColorWheel")

local SPUtil = require(game.ReplicatedStorage.Shared.Utils.SPUtil)
local NumberUtil = require(game.ReplicatedStorage.Libraries.NumberUtil)

function ColorWheel:init()
    self:setState({
        currentColor = Color3.fromHSV(0,0,0);
    })

    self.onMouse = function(_, x, y)
        if self.isDown == false then return end
        self.updateColor(x, y)
    end

    self.onMouseClick = function(_)
        self.isDown = true
        
        local mousePosition = UserInputService:GetMouseLocation() -- works in game but not with Hoarcekat

        self.updateColor(mousePosition.X, mousePosition.Y)
    end

    self.onMouseRelease = function()
        self.isDown = false
    end

    self.isDown = false

    self.updateColor = function(x, y)
        local wheel = self.wheelRef:getValue()
        local wheelPos = wheel.AbsolutePosition
        local wheelSize = wheel.AbsoluteSize
        local centerPoint = Vector2.new((wheelPos.x + (wheelPos.x + wheelSize.x))/2, (wheelPos.y + (wheelPos.y + wheelSize.y))/2)

        local angle = SPUtil:find_angle(Vector2.new(x, y), centerPoint)

        angle = 360 - ((angle + 180) % 360);

        local distanceFromCenter = SPUtil:find_distance(centerPoint.X, centerPoint.Y, x, y)

        local h = angle/360
        local s = distanceFromCenter/(wheelSize.X/2)
        local v = 1

        if h > 1 or s > 1 or v > 1 then return end

        local cur_color = Color3.fromHSV(h, s, v)

        self:setState({
            currentColor = cur_color;
        })

        self.calculatePosition(cur_color)
    end

    self.calculatePosition = function(cur_color)
        local h, s, v = cur_color:ToHSV()
        local xs = math.cos(math.rad(h*360))*s
        local ys = math.sin(math.rad(h*360))*s

        xs = NumberUtil.InverseLerp(1, -1, xs)
        ys = NumberUtil.InverseLerp(-1, 1, ys)

        self.position = UDim2.new(xs, 0, ys, 0)
    end

    self.wheelRef = Roact.createRef()
end

function ColorWheel:render()
    return Roact.createElement(ColorWheelView, {
        pointerPosition = self.position;
        onMouse = self.onMouse;
        onMouseClick = self.onMouseClick;
        onMouseRelease = self.onMouseRelease;
        currentColor = self.state.currentColor;
        [Roact.Ref] = self.wheelRef;
    })
end

return ColorWheel
