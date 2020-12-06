local SongDatabase = require(game.ReplicatedStorage.Shared.Core.API.Map.SongDatabase)
local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local SPUtil = require(game.ReplicatedStorage.Shared.Utils.SPUtil)

local NpsGraph = require(game.ReplicatedStorage.Client.Components.UI.NpsGraph)

local SongButton = Roact.Component:extend("SongButton")

local function noop() end

function SongButton:init()
    self.on_click = self.props.on_click and SPUtil:input_callback(function(...)
         self.props.on_click(self.props.song_key)
    end) or noop
end

function SongButton:shouldUpdate(nextProps, nextState)
    return self.props.visible ~= nextProps.visible
end

function SongButton:render()
    local _song_key = self.props.song_key
    return Roact.createElement("Frame", {
        Visible = self.props.visible;
        Name = "SongListElementProto",
        BackgroundColor3 = Color3.fromRGB(15, 15, 15),
        BorderMode = Enum.BorderMode.Inset,
        BorderSizePixel = 0,
        Size = UDim2.new(0.978, 0, 0.19, 0),
        [Roact.Event.InputBegan] = self.on_click
    }, {
        Roact.createElement("UICorner", {
            CornerRadius = UDim.new(0, 4),
        }),
        Roact.createElement("UIAspectRatioConstraint", {
            AspectRatio = 10,
            AspectType = Enum.AspectType.ScaleWithParentSize,
        }),
        Roact.createElement("ImageLabel", {
            Name = "SongCover",
            AnchorPoint = Vector2.new(1, 0.5),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BorderSizePixel = 0,
            Position = UDim2.new(1, 0, 0.5, 0),
            Size = UDim2.new(0.5, 0, 1, 0),
            ScaleType = Enum.ScaleType.Crop,
            Image = self.props.image
        }, {
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
            })
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
        Roact.createElement(NpsGraph, {
            BorderSizePixel = 0,
            Position = UDim2.new(0.835147917, 0, 0.379469723, 0),
            Size = UDim2.new(0.15732792, 0, 0.545288444, 0),
            song_key = _song_key;
            doNotAnimate = true;
        }, {
            Roact.createElement("UICorner", {
                CornerRadius = UDim.new(0, 4),
            }),
            Roact.createElement("Frame", {
                Name = "Items",
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                ClipsDescendants = true,
                Size = UDim2.new(1, 0, 1, 0),
                ZIndex = 2,
            }, {
                Roact.createElement("UICorner", {
                    CornerRadius = UDim.new(0, 4),
                }),
                Roact.createElement("UIListLayout", {
                    FillDirection = Enum.FillDirection.Horizontal,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    VerticalAlignment = Enum.VerticalAlignment.Bottom,
                })
            })
        })
    })
end

return SongButton
