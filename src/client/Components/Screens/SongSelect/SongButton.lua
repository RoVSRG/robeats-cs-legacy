local SongDatabase = require(game.ReplicatedStorage.Shared.Core.API.Map.SongDatabase)
local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local SPUtil = require(game.ReplicatedStorage.Shared.Utils.SPUtil)
local Gradient = require(game.ReplicatedStorage.Shared.Utils.Gradient)

local Button = require(game.ReplicatedStorage.Client.Components.Primitive.Button)

local NpsGraph = require(game.ReplicatedStorage.Client.Components.Graph.NpsGraph)

local SongButton = Roact.Component:extend("SongButton")

local function noop() end

function SongButton:init()
    self.on_click = self.props.on_click or noop
end

function SongButton:getGradient()
    local gradient = Gradient:new()

    for i = 0, 1, 0.1 do
        gradient:add_number_keypoint(i, 1-i)
    end

    return gradient:number_sequence()
end

function SongButton:render()
    return Roact.createElement(Button, {
        BackgroundColor3 = Color3.fromRGB(15, 15, 15),
        BorderMode = Enum.BorderMode.Inset,
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(0, (self.props.index-1)*125);
        Size = UDim2.new(1, 0, 0, 120),
        onActivated = function()
            self.on_click(self.props.song_key)
        end;
        Text = "";
        shrinkBy = 0.000001;
        LayoutOrder = self.props.LayoutOrder;
    }, {
        Roact.createElement("UICorner", {
            CornerRadius = UDim.new(0, 4),
        }),
        Roact.createElement("UIAspectRatioConstraint", {
            AspectRatio = 11,
            AspectType = Enum.AspectType.ScaleWithParentSize,
        }),
        Roact.createElement("ImageLabel", {
            Name = "SongCover",
            AnchorPoint = Vector2.new(1, 0.5),
            BackgroundTransparency = 1;
            BorderSizePixel = 0,
            Position = UDim2.new(1, 0, 0.5, 0),
            Size = UDim2.new(0.5, 0, 1, 0),
            ScaleType = Enum.ScaleType.Crop,
            Image = self.props.image
        }, {
            Roact.createElement("UIGradient", {
                Transparency = self:getGradient()
            }),
            Roact.createElement("UICorner", {
                CornerRadius = UDim.new(0, 4),
            }),
        }),
        Roact.createElement("TextLabel", {
            Name = "DifficultyDisplay",
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Position = UDim2.new(0.0199999847, 0, 0.5, 0),
            Size = UDim2.new(0.462034643, 0, 0.330079168, 0),
            Font = Enum.Font.GothamSemibold,
            Text = string.format("Difficulty: %d", self.props.difficulty),
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextScaled = true,
            TextSize = 16,
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
        }, {
            Roact.createElement("UITextSizeConstraint", {
                MaxTextSize = 18,
                MinTextSize = 10,
            });
        }),
        Roact.createElement("TextLabel", {
            Name = "NameDisplay",
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Position = UDim2.new(0.0199999996, 0, 0.100000001, 0),
            Selectable = true,
            Size = UDim2.new(0.45, 0, 0.400000006, 0),
            Font = Enum.Font.GothamBold,
            Text = string.format("%s - %s", self.props.title, self.props.artist),
            TextColor3 = Color3.fromRGB(255, 208, 87),
            TextScaled = true,
            TextSize = 26,
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
        }, {
            Roact.createElement("UITextSizeConstraint", {
                MaxTextSize = 26,
            })
        }),
        
    })
end

return SongButton
