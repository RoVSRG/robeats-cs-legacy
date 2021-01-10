local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local Flipper = require(game.ReplicatedStorage.Libraries.Flipper)
local RoactFlipper = require(game.ReplicatedStorage.Libraries.RoactFlipper)

local USER_INPUT_SERVICE = game:GetService("UserInputService")

local Button = require(game.ReplicatedStorage.Client.Components.Primitive.Button)

local SPUtil = require(game.ReplicatedStorage.Shared.Utils.SPUtil)

local Bind = Roact.Component:extend("Bind")

local function noop() end

Bind.defaultProps = {
    value = Roact.None;
    name = "";
    title = "Bind"
}

Bind.stringToKey = {
	["Ctrl"] = {"LeftControl", "RightControl"};
	["Cmd"] = "LeftControl";
	["Command"] = {"LeftControl", "RightControl"};
	["WinKey"] = {"LeftSuper", "RightSuper"};
	["Windows"] = {"LeftSuper", "RightSuper"};
	["Shift"] = {"LeftShift", "RightShift"};
	["Alt"] = {"LeftAlt", "RightAlt"};
	["Dash"] = "Minus";
	["Hyphen"] = "Minus";
	["Stop"] = "Period";
    ["0"] = {"Zero", "KeypadZero"};
    ["1"] = {"One", "KeypadOne"};
    ["2"] = {"Two", "KeypadTwo"};
    ["3"] = {"Three", "KeypadThree"};
    ["4"] = {"Four", "KeypadFour"};
    ["5"] = {"Five", "KeypadFive"};
    ["6"] = {"Six", "KeypadSix"};
    ["7"] = {"Seven", "KeypadSeven"};
    ["8"] = {"Eight", "KeypadEight"};
    ["9"] = {"Nine", "KeypadNine"};
	["["] = "LeftBracket";
	["]"] = "RightBracket";
	["\\"] = "BackSlash";
	["'"] = "Quote";
	[";"] = "Semicolon";
	[","] = "Comma";
	["."] = {"KeypadPeriod", "Period"};
	["/"] = {"Slash", "KeypadDivide"};
	["-"] = "Minus";
	["="] = "Equals";
    ["`"] = "Backquote";
    ["*"] = "KeypadMultiply";
    ["Return"] = {"KeypadEnter", "Return", "Enter"};
}

function Bind:init()
    self.motor = Flipper.SingleMotor.new(0)

    self.motorBinding = RoactFlipper.getBinding(self.motor)

    self.timeSelected = 0

    self:setState({
        selecting = false;
    })

    self.changeValue = self.props.changeSetting or noop

    self.keypressBinding = SPUtil:bind_to_key(Enum.KeyCode, function(keyCode)
        if self.state.selecting then
            self:setState({
                selecting = false;
            })

            self.changeValue(self.props.name, keyCode)
        end
    end)

    self.getStringFromKeyCode = function(keyCode)
        if keyCode == Roact.None or keyCode == nil then return "Unknown" end

        for i, v in pairs(self.stringToKey) do
            if typeof(v) == "string" then
                if v == keyCode.Name then
                    return i
                end
            elseif typeof(v) == "table" then
                for _, k in pairs(v) do
                    if k == keyCode.Name then
                        return i
                    end
                end
            end 
        end
        return USER_INPUT_SERVICE:GetStringForKeyCode(keyCode)
    end

    self.toFrame = SPUtil:bind_to_frame(function()
        if self.state.selecting then
            if tick() - self.timeSelected >= 5 then
                self:setState({
                    selecting = false;
                })
            end
        end
    end)
end

function Bind:render()
    local keycode = self.getStringFromKeyCode(self.props.value)

    return Roact.createElement("Frame", {
        BackgroundTransparency = 1;
        Size = UDim2.fromScale(self.props.size, 1);
        Position = UDim2.fromScale(self.props.position, 0.1)
    }, {
        Text = Roact.createElement("TextLabel", {
            Font = Enum.Font.GothamBlack;
            Text = self.props.title;
            Size = UDim2.new(0.4, 0, 0.3, 0);
            Position = UDim2.new(0.5, 0, 0.1, 0);
            AnchorPoint = Vector2.new(0.5, 0);
            TextColor3 = Color3.fromRGB(255, 255, 255);
            BackgroundTransparency = 1;
            TextScaled = true;
        });
        Button = Roact.createElement(Button, {
            Position = UDim2.fromScale(0.5, 0.5);
            AnchorPoint = Vector2.new(0.5, 0);
            Size = UDim2.new(0.75, 0, 0.25, 0);
            shrinkBy = 0.01;
            darkenBy = 13;
            BackgroundColor3 = self.state.selecting and Color3.fromRGB(56, 211, 231) or Color3.fromRGB(30, 30, 30);
            TextColor3 = Color3.fromRGB(255, 255, 255);
            TextScaled = true;
            Text = keycode;
            onActivated = function()
                self:setState(function(state)
                    return {
                        selecting = not state.selecting
                    }
                end)

                self.timeSelected = tick()
            end;
        }, {
            TextConstraint = Roact.createElement("UITextSizeConstraint", {
                MinTextSize = 9;
                MaxTextSize = 40;
            })
        })
    })
end

function Bind:willUnmount()
    self.keypressBinding:Disconnect()
    self.toFrame:Disconnect()
end

return Bind
