local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local Button = require(game.ReplicatedStorage.Client.Components.Primitive.Button)
local Slider = require(game.ReplicatedStorage.Client.Components.Primitive.Slider)

local ColorSetting = Roact.Component:extend("ColorSetting")

function ColorSetting:init()
    self:setState({
        R = self.props.R;
        G = self.props.G;
        B = self.props.B;
    })
end

function ColorSetting:render()
    return Roact.createElement("Frame", {
        BackgroundColor3 = Color3.fromRGB(25, 25, 25),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 1, 0),
    }, {
        Label = Roact.createElement("TextLabel", {
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1,
            Position = UDim2.new(0.0149999997, 0, 0.0500000007, 0),
            Size = UDim2.new(0.25, 0, 0.150000006, 0),
            Font = Enum.Font.GothamSemibold,
            Text = self.props.title,
            TextColor3 = Color3.new(self.state.R, self.state.G, self.state.B),
            TextScaled = true,
            TextSize = 20,
            TextStrokeTransparency = 0,
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
        }),
        Corner = Roact.createElement("UICorner", {
            CornerRadius = UDim.new(0, 4),
        });
        CurColoRLabel = Roact.createElement("TextLabel", {
            Position = UDim2.new(0.02, 0, 0.25, 0);
            Size = UDim2.new(0.88, 0, 0.2, 0);
            BackgroundTransparency = 1;
            Text = string.format("[%d, %d, %d]", self.state.R*255, self.state.G*255, self.state.B*255);
            TextXAlignment = Enum.TextXAlignment.Left;
            AnchorPoint = Vector2.new(0, 0.5);
            TextStrokeTransparency = 0;
            TextScaled = true;
            Font = Enum.Font.Gotham;
            TextColor3 = Color3.new(1, 1, 1);
        }, {
            UITextSizeConstraint = Roact.createElement("UITextSizeConstraint", {
                MaxTextSize = 40;
                MinTextSize = 12;
            })
        });
        R = Roact.createElement(Slider, {
            BackgroundColor3 = Color3.fromRGB(40, 40, 40);
            sliderColor3 = Color3.new(0.4, 0.4, 0.4);
            Position = UDim2.new(0.1, 0, 0.4, 0);
            Size = UDim2.new(0.88, 0, 0.3, 0);
            initialPercent = self.state.R*100;
            AnchorPoint = Vector2.new(0, 0.5);
            onDrag = function(a)
                self:setState(function(state)
                    return {
                        R = a;
                        G = state.G;
                        B = state.B;
                    }
                end)
            end;
        });
        G = Roact.createElement(Slider, {
            BackgroundColor3 = Color3.fromRGB(40, 40, 40);
            sliderColor3 = Color3.new(0.4, 0.4, 0.4);
            Position = UDim2.new(0.1, 0, 0.6, 0);
            Size = UDim2.new(0.88, 0, 0.3, 0);
            initialPercent = self.state.G*100;
            AnchorPoint = Vector2.new(0, 0.5);
            onDrag = function(a)
                self:setState(function(state)
                    return {
                        R = state.R;
                        G = a;
                        B = state.B;
                    }
                end)
            end;
        });
        B = Roact.createElement(Slider, {
            BackgroundColor3 = Color3.fromRGB(40, 40, 40);
            sliderColor3 = Color3.new(0.4, 0.4, 0.4);
            Position = UDim2.new(0.1, 0, 0.8, 0);
            Size = UDim2.new(0.88, 0, 0.3, 0);
            initialPercent = self.state.B*100;
            AnchorPoint = Vector2.new(0, 0.5);
            onDrag = function(a)
                self:setState(function(state)
                    return {
                        R = state.R;
                        G = state.G;
                        B = a;
                    }
                end)
            end;
        });
        RLabel = Roact.createElement("TextLabel", {
            Position = UDim2.new(0.02, 0, 0.4, 0);
            Size = UDim2.new(0.88, 0, 0.2, 0);
            BackgroundTransparency = 1;
            Text = "R";
            TextXAlignment = Enum.TextXAlignment.Left;
            AnchorPoint = Vector2.new(0, 0.5);
            TextStrokeTransparency = 0;
            TextScaled = true;
            Font = Enum.Font.Gotham;
            TextColor3 = Color3.new(1, 1, 1);
        }, {
            UITextSizeConstraint = Roact.createElement("UITextSizeConstraint", {
                MaxTextSize = 80;
                MinTextSize = 12;
            })
        });
        GLabel = Roact.createElement("TextLabel", {
            Position = UDim2.new(0.02, 0, 0.6, 0);
            Size = UDim2.new(0.88, 0, 0.2, 0);
            BackgroundTransparency = 1;
            Text = "G";
            TextXAlignment = Enum.TextXAlignment.Left;
            AnchorPoint = Vector2.new(0, 0.5);
            TextStrokeTransparency = 0;
            TextScaled = true;
            Font = Enum.Font.Gotham;
            TextColor3 = Color3.new(1, 1, 1);
        }, {
            UITextSizeConstraint = Roact.createElement("UITextSizeConstraint", {
                MaxTextSize = 80;
                MinTextSize = 12;
            })
        });
        BLabel = Roact.createElement("TextLabel", {
            Position = UDim2.new(0.02, 0, 0.8, 0);
            Size = UDim2.new(0.88, 0, 0.2, 0);
            BackgroundTransparency = 1;
            Text = "B";
            TextXAlignment = Enum.TextXAlignment.Left;
            AnchorPoint = Vector2.new(0, 0.5);
            TextStrokeTransparency = 0;
            TextScaled = true;
            Font = Enum.Font.Gotham;
            TextColor3 = Color3.new(1, 1, 1);
        }, {
            UITextSizeConstraint = Roact.createElement("UITextSizeConstraint", {
                MaxTextSize = 80;
                MinTextSize = 12;
            })
        });
    })
end

return ColorSetting
