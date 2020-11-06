local SongDatabase = require(game.ReplicatedStorage.RobeatsGameCore.SongDatabase)
local SPUtil = require(game.ReplicatedStorage.Shared.SPUtil)
local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local RoactAnimate = require(game.ReplicatedStorage.Libraries.RoactAnimate)

local SongInfoDisplay = Roact.Component:extend("SongInfoDisplay")

function SongInfoDisplay:didMount()
end

function SongInfoDisplay:init()
end

function SongInfoDisplay:render()
    return Roact.createElement("Frame", {
        Name = "SongInfoSection",
        AnchorPoint = Vector2.new(1, 0),
        BackgroundColor3 = Color3.fromRGB(25, 25, 25),
        BorderSizePixel = 0,
        Position = UDim2.new(1, 0, 0, 0),
        Size = UDim2.new(0.340000004, 0, 0.875, 0),
    }, {
        Roact.createElement("TextLabel", {
            Name = "NoSongSelectedDisplay",
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Position = UDim2.new(-0.00191900111, 0, 0, 0),
            Size = UDim2.new(1, 0, 1, 0),
            Visible = false,
            ZIndex = 2,
            Font = Enum.Font.GothamSemibold,
            Text = "Click on a song to play.",
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextSize = 20,
            TextWrapped = true,
        }),
        Roact.createElement("Frame", {
            Name = "SongInfoDisplay",
            BackgroundColor3 = Color3.fromRGB(25, 25, 25),
            Size = UDim2.new(1, 0, 1, 0),
        }, {
            Roact.createElement("ImageLabel", {
                Name = "SongCover",
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BorderSizePixel = 0,
                Size = UDim2.new(1, 0, 0.25, 0),
                ScaleType = Enum.ScaleType.Crop,
            }, {
                Roact.createElement("UICorner", {
                    CornerRadius = UDim.new(0, 4),
                }),
            }),
            Roact.createElement("UICorner", {
                CornerRadius = UDim.new(0, 4),
            }),
            Roact.createElement("TextLabel", {
                Name = "DescriptionDisplay",
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Position = UDim2.new(0.0499999113, 0, 0.611425757, 0),
                Size = UDim2.new(0.899999976, 0, 0.12886931, 0),
                Font = Enum.Font.Gotham,
                Text = "The main theme to MONDAY NIGHT MONSTERS, a 2016 game by spotco. FinnMK is also the main composer for Robeats!",
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextScaled = true,
                TextSize = 26,
                TextWrapped = true,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Top,
            }, {
                Roact.createElement("UITextSizeConstraint", {
                    MaxTextSize = 22,
                })
            }),
            Roact.createElement("Frame", {
                Name = "NpsGraph",
                BackgroundColor3 = Color3.fromRGB(16, 16, 16),
                BorderSizePixel = 0,
                Position = UDim2.new(0.0134330085, 0, 0.796225548, 0),
                Size = UDim2.new(0.971014559, 0, 0.185931787, 0),
            }, {
                Roact.createElement("UICorner", {
                    CornerRadius = UDim.new(0, 4),
                }),
                Roact.createElement("TextLabel", {
                    Name = "MaxNps",
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0.0138339922, 0, 0, 0),
                    Size = UDim2.new(0.249011859, 0, 0.235294119, 0),
                    ZIndex = 3,
                    Font = Enum.Font.GothamBlack,
                    Text = "MAX NPS: 0",
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    TextSize = 14,
                    TextXAlignment = Enum.TextXAlignment.Left,
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
                }),
                Roact.createElement("Frame", {
                    Name = "SongPosition",
                    BackgroundColor3 = Color3.fromRGB(93, 93, 93),
                    BorderSizePixel = 0,
                    Size = UDim2.new(0.00499999989, 0, 1, 0),
                })
            }),
            Roact.createElement("Frame", {
                Name = "Metadata",
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 11,
                Position = UDim2.new(0.0499999113, 0, 0.314990371, 0),
                Size = UDim2.new(0, 349, 0, 129),
            }, {
                Roact.createElement("UIListLayout", {
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Padding = UDim.new(0.0109999999, 0),
                }),
                Roact.createElement("TextLabel", {
                    Name = "ArtistDisplay",
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    LayoutOrder = 1,
                    Size = UDim2.new(0.957943857, 0, 0.268147349, 0),
                    Font = Enum.Font.Gotham,
                    Text = "FinnMK",
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
                Roact.createElement("TextLabel", {
                    Name = "NameDisplay",
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    LayoutOrder = 2,
                    Position = UDim2.new(0, 0, 0.26814732, 0),
                    Size = UDim2.new(0.957943916, 0, 0.164641663, 0),
                    Font = Enum.Font.GothamBold,
                    Text = "Monday Night Monsters",
                    TextColor3 = Color3.fromRGB(255, 208, 87),
                    TextScaled = true,
                    TextSize = 26,
                    TextWrapped = true,
                    TextXAlignment = Enum.TextXAlignment.Left,
                }, {
                    Roact.createElement("UITextSizeConstraint", {
                        MaxTextSize = 28,
                    })
                }),
                Roact.createElement("TextLabel", {
                    Name = "DifficultyDisplay",
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    LayoutOrder = 3,
                    Position = UDim2.new(0, 0, 0.432788938, 0),
                    Size = UDim2.new(0.957943916, 0, 0.122751191, 0),
                    Font = Enum.Font.GothamSemibold,
                    Text = "Difficulty: 1",
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    TextScaled = true,
                    TextSize = 26,
                    TextWrapped = true,
                    TextXAlignment = Enum.TextXAlignment.Left,
                }, {
                    Roact.createElement("UITextSizeConstraint", {
                        MaxTextSize = 20,
                    })
                }),
                Roact.createElement("TextLabel", {
                    Name = "TotalNotesDisplay",
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    LayoutOrder = 3,
                    Position = UDim2.new(0, 0, 0.432788938, 0),
                    Size = UDim2.new(0.957943916, 0, 0.122751191, 0),
                    Font = Enum.Font.GothamSemibold,
                    Text = "Total Notes: 0",
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    TextScaled = true,
                    TextSize = 26,
                    TextWrapped = true,
                    TextXAlignment = Enum.TextXAlignment.Left,
                }, {
                    Roact.createElement("UITextSizeConstraint", {
                        MaxTextSize = 20,
                    })
                }),
                Roact.createElement("TextLabel", {
                    Name = "TotalHoldsDisplay",
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    LayoutOrder = 4,
                    Position = UDim2.new(0, 0, 0.432788938, 0),
                    Size = UDim2.new(0.957943916, 0, 0.122751191, 0),
                    Font = Enum.Font.GothamSemibold,
                    Text = "Total Holds: 0",
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    TextScaled = true,
                    TextSize = 26,
                    TextWrapped = true,
                    TextXAlignment = Enum.TextXAlignment.Left,
                }, {
                    Roact.createElement("UITextSizeConstraint", {
                        MaxTextSize = 20,
                    })
                }),
                Roact.createElement("TextLabel", {
                    Name = "TotalLengthDisplay",
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    LayoutOrder = 4,
                    Position = UDim2.new(0, 0, 0.432788938, 0),
                    Size = UDim2.new(0.957943916, 0, 0.122751191, 0),
                    Font = Enum.Font.GothamSemibold,
                    Text = "Total Length: 0:00",
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    TextScaled = true,
                    TextSize = 26,
                    TextWrapped = true,
                    TextXAlignment = Enum.TextXAlignment.Left,
                }, {
                    Roact.createElement("UITextSizeConstraint", {
                        MaxTextSize = 20,
                    })
                })
            }),
            Roact.createElement("TextLabel", {
                Name = "Rate",
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                Position = UDim2.new(0.0253480561, 0, 0.740295172, 0),
                Size = UDim2.new(0.289368182, 0, 0.0559303947, 0),
                ZIndex = 3,
                Font = Enum.Font.GothamBold,
                Text = "RATE: 1x",
                TextColor3 = Color3.fromRGB(193, 193, 193),
                TextScaled = true,
                TextSize = 14,
                TextWrapped = true,
                TextXAlignment = Enum.TextXAlignment.Left,
            }, {
                Roact.createElement("UITextSizeConstraint", {
                    MaxTextSize = 18,
                    MinTextSize = 10,
                })
            })
        }),
        Roact.createElement("UICorner", {
            CornerRadius = UDim.new(0, 4),
        })
    })
end

return function(target)
    local testApp = Roact.createElement(SongInfoDisplay, {
        song_key = 1,
        Position = UDim2.new(0,0,0,0);
        Size = UDim2.new(1,0,1,0);
    })

    local fr = Roact.mount(testApp, target)

    return function()
        Roact.unmount(fr)
    end 
end