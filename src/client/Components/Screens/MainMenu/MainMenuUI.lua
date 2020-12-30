--//Libraries

local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local Flipper = require(game.ReplicatedStorage.Libraries.Flipper)
local RoactFlipper = require(game.ReplicatedStorage.Libraries.RoactFlipper)

--//Main

local MainMenuUI: RoactComponent = Roact.PureComponent:extend("MainMenuUI")
local Button = require(game:GetService("ReplicatedStorage"):WaitForChild("Client").Components.Primitive["Button"])

-- local noop = function() end


-- function MainMenuUI:init()
--     return noop
-- end

-- function MainMenuUI:render()
--     return Roact.createElement("Frame",{
--         AnchorPoint = Vector2.new(0.5, 0.5),
--         BackgroundColor3 = Color3.fromRGB(35, 35, 35),
--         BorderSizePixel = 0,
--         Position = UDim2.new(0.5, 0, 0.5, 0),
--         Size = UDim2.new(1, 0, 1, 0),
--     }, {
--         Roact.createElement("Frame",{
--             Name = "ButtonHolder";
--             Size = UDim2.new(.275,0,.575,0);
--             Position = UDim2.new(0.025,0,.4,0);
--             BackgroundTransparency = 1;
--         },{
--             Roact.createElement("UIListLayout", {
--                 Padding = UDim.new(0.015,0);
--                 SortOrder = Enum.SortOrder.LayoutOrder;
--             });

--             PlayButton = Roact.createElement(Button, {
--                 Visible = self.props.visible;
--                 BackgroundColor3 = Color3.fromRGB(80, 80, 80);
--                 BorderMode = Enum.BorderMode.Inset,
--                 BorderSizePixel = 0,
--                 Size = UDim2.new(1,0,0.125,0),
--                 Position = UDim2.new(.25,0,.75,0);
--                 Text = "Play";
--                 TextScaled = true;
--                 TextColor3 = Color3.fromRGB(255, 255, 255);
--                 LayoutOrder = 0;
--                 Font = Enum.Font.SourceSansLight;
                
--                 [Roact.Event.OnActivated] = function()
--                     return noop
--                 end;
--                 shrinkBy = 0.015
--             }, {
--                 Roact.createElement("UICorner", {
--                     CornerRadius = UDim.new(0, 6.5)
--                 })
--             });

--             OptionsButton = Roact.createElement(Button, {
--                 Visible = self.props.visible;
--                 BackgroundColor3 = Color3.fromRGB(80, 80, 80);
--                 BorderMode = Enum.BorderMode.Inset,
--                 BorderSizePixel = 0,
--                 Size = UDim2.new(1,0,0.125,0),
--                 Position = UDim2.new(.25,0,.75,0);
--                 Text = "Settings";
--                 TextScaled = true;
--                 TextColor3 = Color3.fromRGB(255, 255, 255);
--                 LayoutOrder = 1;
--                 Font = Enum.Font.SourceSansLight;
                
--                 [Roact.Event.OnActivated] = function()
--                     return noop
--                 end;
--                 shrinkBy = 0.015
--             }, {
--                 Roact.createElement("UICorner", {
--                     CornerRadius = UDim.new(0, 6.5)
--                 })
--             });

--             GlobalLBButton = Roact.createElement(Button, {
--                 Visible = self.props.visible;
--                 BackgroundColor3 = Color3.fromRGB(80, 80, 80);
--                 BorderMode = Enum.BorderMode.Inset,
--                 BorderSizePixel = 0,
--                 Size = UDim2.new(1,0,0.125,0),
--                 Position = UDim2.new(.25,0,.75,0);
--                 Text = "Global Rankings";
--                 TextScaled = true;
--                 TextColor3 = Color3.fromRGB(255, 255, 255);
--                 LayoutOrder = 2;
--                 Font = Enum.Font.SourceSansLight;
                
--                 [Roact.Event.OnActivated] = function()
--                     return noop
--                 end;
--                 shrinkBy = 0.015
--             }, {
--                 Roact.createElement("UICorner", {
--                     CornerRadius = UDim.new(0, 6.5)
--                 })
--             });
--         });

--         Roact.createElement("TextLabel", {
--             Name = "Title";
--             BackgroundTransparency = 1;
--             BackgroundColor3 = Color3.fromRGB(255, 255, 255);
--             Text = "RoBeats: Community Server";
--             TextScaled = true;
--             TextColor3 = Color3.fromRGB(255, 255, 255);
--             Size = UDim2.new(.65,0,0.1,0);
--             Position = UDim2.new(.1525,0,.05,0);
--             Font = Enum.Font.Gotham;
--         })
--     });
    
-- end

return MainMenuUI