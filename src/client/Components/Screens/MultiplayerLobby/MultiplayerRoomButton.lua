local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local Gradient = require(game.ReplicatedStorage.Shared.Utils.Gradient)

local MultiplayerRoomButton = Roact.Component:extend("MultiplayerRoomButton")

local Button = require(game.ReplicatedStorage.Client.Components.Primitive.Button)

function MultiplayerRoomButton:getGradient()
    local gradient = Gradient:new()

    for i = 0, 1, 0.1 do
        gradient:add_number_keypoint(i, i)
    end

    return gradient:number_sequence()
end

function MultiplayerRoomButton:render()
    return Roact.createElement("Frame", {
        BackgroundColor3 = Color3.fromRGB(15, 15, 15),
        BorderMode = Enum.BorderMode.Inset,
        BorderSizePixel = 0,
        Selectable = true,
        Size = UDim2.new(0.975000024, 0, 0, 25),
    }, {
        JoinButton = Roact.createElement(Button, {
            AnchorPoint = Vector2.new(1,0.5);
            Position = UDim2.new(0.95, 0, 0.5, 0);
            Size = UDim2.new(0.1, 0, 0.2, 0);
            BackgroundColor3 = Color3.fromRGB(30, 30, 30);
            TextColor3  = Color3.fromRGB(255, 255, 255);
            TextScaled = true;
            Text = "Join Room >";
            shrinkBy = 0.007;
            darkenBy = 8;
        }, {
            UITextSizeConstraint = Roact.createElement("UITextSizeConstraint", {
                MaxTextSize = 15,
            }),
        });
        C = Roact.createElement("UICorner", {
            CornerRadius = UDim.new(0, 4),
        }),
        UIAspectRatioConstraint = Roact.createElement("UIAspectRatioConstraint", {
            AspectRatio = 7,
            AspectType = Enum.AspectType.ScaleWithParentSize,
        }),
        UITextSizeConstraint = Roact.createElement("UITextSizeConstraint", {
            MaxTextSize = 29,
        }),
        MultiInfoDisplay = Roact.createElement("TextLabel", {
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Position = UDim2.new(0.53, 0, 0.425, 0),
            Size = UDim2.new(5, 0, 0.200000003, 0),
            Font = Enum.Font.GothamBold,
            Text = string.format("%d players, %s, %s", self.props.players, self.props.locked and "Locked" or "Unlocked", self.props.inGame and "In-Game" or "In-Lobby"),
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextScaled = true,
            TextSize = 16,
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
        }, {
            TSC = Roact.createElement("UITextSizeConstraint", {
                MaxTextSize = 18,
                MinTextSize = 10,
            })
        }),

        
        MultiNameDisplay = Roact.createElement("TextLabel", {
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Position = UDim2.new(0.53, 0, 0.055, 0),
            Size = UDim2.new(0.5, 0, 0.25, 0),
            Font = Enum.Font.SourceSansBold,
            Text = self.props.name,
            TextColor3 = Color3.fromRGB(255, 208, 87),
            TextScaled = true,
            TextSize = 26,
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
        }),
        MultiPlayerImages = Roact.createElement("Frame", {
            Name = "PlayerHeadShots";
            BackgroundColor3 = Color3.fromRGB(255,255,255);
            BackgroundTransparency = 0;
            Position = UDim2.new(.515,0,.595,0);
            Size = UDim2.new(.305, 0, .355 ,0);
        }, {
            Roact.createElement("UIListLayout", {
                Padding = UDim.new(0.015,0);
                SortOrder = Enum.SortOrder.LayoutOrder;
                FillDirection = Enum.FillDirection.Horizontal;
            });
        });
        SongDisplay = Roact.createElement("TextLabel", {
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Position = UDim2.new(0.53, 0, 0.29, 0),
            Selectable = true,
            Size = UDim2.new(5, 0, 0.150000006, 0),
            Font = Enum.Font.SourceSansBold,
            Text = "Monday Night Monsters [1]",
            TextColor3 = Color3.fromRGB(255, 208, 87),
            TextScaled = true,
            TextSize = 26,
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
        }, {
            UITextSizeConstraint = Roact.createElement("UITextSizeConstraint", {
                MaxTextSize = 26,
            })
        }),
        SongCover = Roact.createElement("ImageLabel", {
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundColor3 = Color3.fromRGB(15, 15, 15),
            BorderSizePixel = 0,
            Position = UDim2.new(0, 0, 0.5, 0),
            Size = UDim2.new(0.5, 0, 1, 0),
            Image = "rbxassetid://698514070",
            ScaleType = Enum.ScaleType.Crop,
        }, {
            UICorner = Roact.createElement("UICorner", {
                CornerRadius = UDim.new(0, 4),
            }),
            UIGradient = Roact.createElement("UIGradient", {
                Transparency = self:getGradient()
            })
        }),
    })
end

return MultiplayerRoomButton
