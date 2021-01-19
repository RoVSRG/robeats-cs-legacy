--//Libraries

local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local Flipper = require(game.ReplicatedStorage.Libraries.Flipper)
local RoactFlipper = require(game.ReplicatedStorage.Libraries.RoactFlipper)

--//VERSION

local version = game.ReplicatedStorage.Shared.Core.Data.version

--//Main

local MainMenuUI: RoactComponent = Roact.PureComponent:extend("MainMenuUI")
local Button = require(game:GetService("ReplicatedStorage"):WaitForChild("Client").Components.Primitive["Button"])

function MainMenuUI:init()
    self.goToScreen = function(path)
        self.props.history:push(path)
    end
end

function MainMenuUI:render()
    return Roact.createElement("Frame",{
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(20, 20, 20),
        BorderSizePixel = 0,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(1, 0, 1, 0),
    }, {
        Logo = Roact.createElement("ImageLabel", {
            Image = "rbxassetid://6224561143";
            Size = UDim2.fromScale(0.4, 0.9);
            Position = UDim2.fromScale(0.02, 0.57);
            AnchorPoint = Vector2.new(0.05, 0.5);
            BackgroundTransparency = 1;
        }, {
            UIAspectRatioConstraint = Roact.createElement("UIAspectRatioConstraint", {
                AspectRatio = 1;
                AspectType = Enum.AspectType.ScaleWithParentSize
            })
        });
        ButtonHolder = Roact.createElement("Frame",{
            Size = UDim2.new(.275,0,.6,0);
            Position = UDim2.new(0.02,0,0.95,0);
            AnchorPoint = Vector2.new(0, 1);
            BackgroundTransparency = 1;
        },{
            Roact.createElement("UIListLayout", {
                Padding = UDim.new(0.015,0);
                SortOrder = Enum.SortOrder.LayoutOrder;
                VerticalAlignment = Enum.VerticalAlignment.Bottom;
            });

            PlayButton = Roact.createElement(Button, {
                Visible = self.props.visible;
                TextXAlignment = Enum.TextXAlignment.Left;
                BackgroundColor3 = Color3.fromRGB(32, 32, 32);
                BorderMode = Enum.BorderMode.Inset,
                BorderSizePixel = 0,
                Size = UDim2.new(1,0,0.125,0),
                Text = "  Play";
                TextScaled = true;
                TextColor3 = Color3.fromRGB(255, 255, 255);
                LayoutOrder = 0;
                Font = Enum.Font.SourceSansLight;
                shrinkBy = 0.01;
                darkenBy = 10;
                onActivated = function()
                    self.goToScreen("/select")
                end
            }, {
                Roact.createElement("UICorner", {
                    CornerRadius = UDim.new(0, 8)
                });
                Roact.createElement("UITextSizeConstraint", {
                    MinTextSize = 12;
                    MaxTextSize = 14;
                })
            });

            OptionsButton = Roact.createElement(Button, {
                Visible = self.props.visible;
                TextXAlignment = Enum.TextXAlignment.Left;
                BackgroundColor3 = Color3.fromRGB(32, 32, 32);
                BorderMode = Enum.BorderMode.Inset,
                BorderSizePixel = 0,
                Size = UDim2.new(1,0,0.125,0),
                Text = "  Settings";
                TextScaled = true;
                TextColor3 = Color3.fromRGB(255, 255, 255);
                LayoutOrder = 1;
                Font = Enum.Font.SourceSansLight;
                shrinkBy = 0.01;
                darkenBy = 10;
                onActivated = function()
                    self.goToScreen("/settings")
                end
            }, {
                Roact.createElement("UICorner", {
                    CornerRadius = UDim.new(0, 8)
                });
                Roact.createElement("UITextSizeConstraint", {
                    MinTextSize = 12;
                    MaxTextSize = 14;
                })
            });

            GlobalLBButton = Roact.createElement(Button, {
                Visible = self.props.visible;
                TextXAlignment = Enum.TextXAlignment.Left;
                BackgroundColor3 = Color3.fromRGB(32, 32, 32);
                BorderMode = Enum.BorderMode.Inset,
                BorderSizePixel = 0,
                Size = UDim2.new(1,0,0.125,0),
                Text = "  Global Rankings";
                TextScaled = true;
                TextColor3 = Color3.fromRGB(255, 255, 255);
                LayoutOrder = 2;
                Font = Enum.Font.SourceSansLight;
                shrinkBy = 0.01;
                darkenBy = 10;
            }, {
                Roact.createElement("UICorner", {
                    CornerRadius = UDim.new(0, 8)
                });
                Roact.createElement("UITextSizeConstraint", {
                    MinTextSize = 12;
                    MaxTextSize = 14;
                })
            });
        });

        Title = Roact.createElement("TextLabel", {
            BackgroundTransparency = 1;
            BackgroundColor3 = Color3.fromRGB(255, 255, 255);
            Text = "RoBeats: Community Server";
            TextSize = 10;
            TextXAlignment = Enum.TextXAlignment.Right;
            TextColor3 = Color3.fromRGB(255, 255, 255);
            Size = UDim2.new(0.01,0,0.01,0);
            Position = UDim2.new(0.99,0,.93,0);
            AnchorPoint = Vector2.new(1, 0);
            Font = Enum.Font.GothamBlack;
        });

        Version = Roact.createElement("TextLabel", {
            BackgroundTransparency = 1;
            BackgroundColor3 = Color3.fromRGB(255, 255, 255);
            Text = string.format("build v%s", version.Value);
            TextSize = 10;
            TextXAlignment = Enum.TextXAlignment.Right;
            TextColor3 = Color3.fromRGB(136, 136, 136);
            Size = UDim2.new(0.01,0,0.01,0);
            Position = UDim2.new(0.99,0,.96,0);
            AnchorPoint = Vector2.new(1, 0);
            Font = Enum.Font.GothamBlack;
        });

        MusicBox = Roact.createElement("Frame", {
            Name = "Profile";
            Size = UDim2.fromScale(0.35, 0.15);
            Position = UDim2.fromScale(0.99, 0.02);
            BackgroundColor3 = Color3.fromRGB(17,17,17);
            ZIndex = 1;
            AnchorPoint = Vector2.new(1,0);
            --since i dont know what the musicbox should look like, i'll just leave this preset frame for regen to get creative :picardia:
        }, {
            Roact.createElement("UICorner",{
                CornerRadius = UDim.new(0,4);
            })
        });

        PlayerProfile = Roact.createElement("Frame", {
            Name = "Profile";
            Size = UDim2.fromScale(0.3, 0.15);
            Position = UDim2.fromScale(0.315, 0.02);
            BackgroundColor3 = Color3.fromRGB(17,17,17);
            ZIndex = 1;
            AnchorPoint = Vector2.new(1,0);

        }, {
            Roact.createElement("TextLabel",{
                Name = "Username";
                Text = "OnlyTwentyCharacters";
                TextColor3 = Color3.fromRGB(255,255,255);
                TextScaled = true;
                Position = UDim2.fromScale(.31, .06);
                Size = UDim2.fromScale(.5,.25);
                AnchorPoint = Vector2.new(0,0);
                BackgroundTransparency = 1;
                Font = Enum.Font.GothamSemibold;
                LineHeight = 1;
                TextStrokeColor3 = Color3.fromRGB(0, 0, 0);
                TextStrokeTransparency = .5;
            });

            Roact.createElement("UICorner",{
                CornerRadius = UDim.new(0,4);
            });

            Roact.createElement("ImageLabel", {
                Name = "ProfileImage";
                AnchorPoint = Vector2.new(0, .5);
                AutomaticSize = Enum.AutomaticSize.None;
                BackgroundColor3 = Color3.fromRGB(11,11,11);
                BackgroundTransparency = 0;
                Position = UDim2.fromScale(.015, .5);
                Size = UDim2.fromScale(0.6, 0.9);
                Image = "rbxassetid://2944248331";
                ImageColor3 = Color3.fromRGB(255,255,255);
                ScaleType = Enum.ScaleType.Crop;
                SliceScale = 1;
            },{
                Roact.createElement("UIAspectRatioConstraint", {
                    AspectRatio = 1;
                    AspectType = Enum.AspectType.FitWithinMaxSize;
                    DominantAxis = Enum.DominantAxis.Width;
                });

                Roact.createElement("UICorner",{
                    CornerRadius = UDim.new(0,4);
                })
            });

            Roact.createElement("TextLabel",{
                Name = "Tier";
                AutomaticSize = Enum.AutomaticSize.None;
                BackgroundTransparency = 1;
                Position = UDim2.fromScale(0.24, 0.32);
                Size = UDim2.fromScale(0.5,0.15);
                Font = Enum.Font.GothamSemibold;
                LineHeight = 1;
                Text = "Tier 99 - Rofast";
                TextColor3 = Color3.fromRGB(255, 255, 255);
                TextScaled = true;
                TextStrokeColor3 = Color3.fromRGB(0,0,0);
                TextStrokeTransparency = 0.5;
            });

            Roact.createElement("TextLabel", {
                Name = "Rank";
                BackgroundTransparency = 1;
                Position = UDim2.fromScale(0.825,0.06);
                Size = UDim2.fromScale(0.15, 0.25);
                Font = Enum.Font.GothamBold;
                LineHeight = 1;
                TextColor3 = Color3.fromRGB(255, 255, 255);
                TextScaled = true;
                Text = "#1";
                TextStrokeColor3 = Color3.fromRGB(0, 0, 0);
                TextStrokeTransparency = 0.5;
            });
        });
    });
    
end

return MainMenuUI