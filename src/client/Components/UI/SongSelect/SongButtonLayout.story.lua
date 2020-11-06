local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local SongButtonLayout = Roact.Component:extend("SongButtonLayout")

function SongButtonLayout:render()
    return Roact.createElement("Frame", {
        Name = "SongSection",
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = Color3.fromRGB(25, 25, 25),
        BorderSizePixel = 0,
        Position = UDim2.new(0.00611620815, 0, 0.5, 0),
        Size = UDim2.new(0.99286443, 0, 1, 0),
    }, {
        Roact.createElement("UICorner", {
            CornerRadius = UDim.new(0, 4),
        }),
        Roact.createElement("ScrollingFrame", {
            Name = "SongList",
            Active = true,
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundColor3 = Color3.fromRGB(25, 25, 25),
            BorderSizePixel = 0,
            Position = UDim2.new(0.499582142, 0, 0.468073398, 0),
            Size = UDim2.new(0.977529943, 0, 0.896146834, 0),
            BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
            ScrollBarThickness = 14,
            TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
            VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Left,
        }, {
            Roact.createElement("Frame", {
                Name = "SongListElementProto",
                BackgroundColor3 = Color3.fromRGB(15, 15, 15),
                BorderMode = Enum.BorderMode.Inset,
                BorderSizePixel = 0,
                Position = UDim2.new(0.0228759851, 0, -1.5662053e-08, 0),
                Size = UDim2.new(0.977124035, 0, 0.195140719, 0),
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
                    Text = "Difficulty: 1",
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
                    Size = UDim2.new(0.5, 0, 0.400000006, 0),
                    Font = Enum.Font.GothamBold,
                    Text = "Monday Night Monsters",
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
                Roact.createElement("Frame", {
                    Name = "NpsGraph",
                    BackgroundColor3 = Color3.fromRGB(16, 16, 16),
                    BorderSizePixel = 0,
                    Position = UDim2.new(0.835147917, 0, 0.379469723, 0),
                    Size = UDim2.new(0.15732792, 0, 0.545288444, 0),
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
            }),
            Roact.createElement("UIListLayout", {
                HorizontalAlignment = Enum.HorizontalAlignment.Right,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 5),
            })
        }),
        Roact.createElement("Frame", {
            Name = "SearchBar",
            BackgroundColor3 = Color3.fromRGB(31, 31, 31),
            Position = UDim2.new(0.0108171972, 0, 0.935650527, 0),
            Size = UDim2.new(0.977529943, 0, 0.0380137786, 0),
        }, {
            Roact.createElement("UICorner", {
                CornerRadius = UDim.new(0, 4),
            }),
            Roact.createElement("TextBox", {
                Name = "SearchBox",
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                Position = UDim2.new(0.0222672056, 0, 0, 0),
                Size = UDim2.new(0.977732778, 0, 1, 0),
                ClearTextOnFocus = false,
                Font = Enum.Font.GothamBold,
                PlaceholderColor3 = Color3.fromRGB(44, 44, 44),
                PlaceholderText = "Search here...",
                Text = "",
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextScaled = true,
                TextSize = 14,
                TextWrapped = true,
                TextXAlignment = Enum.TextXAlignment.Left,
            }, {
                Roact.createElement("UITextSizeConstraint", {
                    MaxTextSize = 17,
                    MinTextSize = 7,
                })
            })
        })
    })
end

return function(target)
    local testApp = Roact.createElement(SongButtonLayout)

    local fr = Roact.mount(testApp, target)

    return function()
        Roact.unmount(fr)
    end 
end