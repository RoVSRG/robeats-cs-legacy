local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local USER_INPUT_SERVICE = game:GetService("UserInputService")

local Button = require(game.ReplicatedStorage.Client.Components.Primitive.Button)

local SPUtil = require(game.ReplicatedStorage.Shared.Utils.SPUtil)

local Bind = Roact.Component:extend("Bind")

function Bind:init()
    self.doChange = false

    self:setState({
        currentKeyCode = Roact.None;
    })

    self.keypressBinding = SPUtil:bind_to_key(Enum.KeyCode, function(keyCode)
        if self.doChange then
            self.doChange = false
            self:setState({
                currentKeyCode = keyCode;
            })
        end
    end)
end

function Bind:willUnmount()
    self.keypressBinding:Disconnect()
end

function Bind:render()
    return Roact.createElement("Frame", {
        BackgroundTransparency = 1;
        Size = UDim2.new(self.props.size,0,1,0);
        Position = UDim2.new(self.props.position,0,0,0)
    }, {
        Text = Roact.createElement("TextLabel", {
            Font = Enum.Font.GothamBlack;
            Text = self.props.name or "Bind";
            Size = UDim2.new(0.4, 0, 0.3, 0);
            Position = UDim2.new(0.5, 0, 0.1, 0);
            AnchorPoint = Vector2.new(0.5, 0);
            TextColor3 = Color3.fromRGB(255, 255, 255);
            BackgroundTransparency = 1;
            TextScaled = true;
        });
        Button = Roact.createElement(Button, {
            Position = UDim2.new(0.5, 0, 0.5, 0);
            AnchorPoint = Vector2.new(0.5, 0);
            Size = UDim2.new(0.75, 0, 0.25, 0);
            shrinkBy = 0.01;
            darkenBy = 13;
            BackgroundColor3 = Color3.fromRGB(30, 30, 30);
            TextColor3 = Color3.fromRGB(255, 255, 255);
            TextScaled = true;
            Text = self.props.value or "BindButton";
            onActivated = function()
                self.doChange = true
            end;
        }, {
            TextConstraint = Roact.createElement("UITextSizeConstraint", {
                MinTextSize = 9;
                MaxTextSize = 40;
            })
        })
    })
end

return Bind
