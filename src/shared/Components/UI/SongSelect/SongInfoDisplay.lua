local SongDatabase = require(game.ReplicatedStorage.RobeatsGameCore.SongDatabase)
local SPUtil = require(game.ReplicatedStorage.Shared.Utils.SPUtil)
local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local RoactAnimate = require(game.ReplicatedStorage.Libraries.RoactAnimate)

local NpsGraph = require(game.ReplicatedStorage.Shared.Components.UI.NpsGraph)

local SongInfoDisplay = Roact.Component:extend("SongInfoDisplay")

--[[
    Position = UDim2.new(1, 0, 0, 0),
    Size = UDim2.new(0.340000004, 0, 0.875, 0),
]]

function SongInfoDisplay:didMount()
end

function SongInfoDisplay:init()
end

function SongInfoDisplay:render()
    local _songkey = self.props.song_key

    local total_notes, total_holds = SongDatabase:get_note_metrics_for_key(_songkey)
    return Roact.createElement("Frame", {
        Name = "SongInfoSection",
        AnchorPoint = Vector2.new(1, 0),
        BackgroundColor3 = Color3.fromRGB(25, 25, 25),
        BorderSizePixel = 0,
        Position = self.props.Position or UDim2.new(1,0,0,0),
        Size = self.props.Size or UDim2.new(1,0,1,0),
    }, {
        Roact.createElement("TextLabel", {
            Name = "NoSongSelectedDisplay",
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 0, 0, 0),
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
                Image = SongDatabase:get_image_for_key(_songkey)
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
                Position = UDim2.new(0.05, 0, 0.68, 0),
                Size = UDim2.new(0.9, 0, 0.13, 0),
                Font = Enum.Font.Gotham,
                Text = "<placeholder>",
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
                Roact.createElement(NpsGraph, {
                    Name = "Items",
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BackgroundTransparency = 1,
                    ClipsDescendants = true,
                    Size = UDim2.new(1, 0, 1, 0),
                    song_key = _songkey,
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
                ArtistDisplay = Roact.createElement("TextLabel", {
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    LayoutOrder = 1,
                    Size = UDim2.new(0.957943857, 0, 0.268147349, 0),
                    Font = Enum.Font.Gotham,
                    Text = SongDatabase:get_artist_for_key(_songkey),
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
                NameDisplay = Roact.createElement("TextLabel", {
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    LayoutOrder = 2,
                    Position = UDim2.new(0, 0, 0.26814732, 0),
                    Size = UDim2.new(0.957943916, 0, 0.164641663, 0),
                    Font = Enum.Font.GothamBold,
                    Text = SongDatabase:get_title_for_key(_songkey),
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
                DifficultyDisplay = Roact.createElement("TextLabel", {
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    LayoutOrder = 3,
                    Position = UDim2.new(0, 0, 0.432788938, 0),
                    Size = UDim2.new(0.957943916, 0, 0.122751191, 0),
                    Font = Enum.Font.GothamSemibold,
                    Text = string.format("Difficulty: %d", SongDatabase:get_difficulty_for_key(_songkey)),
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
                TotalNotesDisplay = Roact.createElement("TextLabel", {
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    LayoutOrder = 3,
                    Position = UDim2.new(0, 0, 0.432788938, 0),
                    Size = UDim2.new(0.957943916, 0, 0.122751191, 0),
                    Font = Enum.Font.GothamSemibold,
                    Text = string.format("Total Notes: %d", total_notes),
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
                TotalHoldsDisplay = Roact.createElement("TextLabel", {
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    LayoutOrder = 4,
                    Position = UDim2.new(0, 0, 0.432788938, 0),
                    Size = UDim2.new(0.957943916, 0, 0.122751191, 0),
                    Font = Enum.Font.GothamSemibold,
                    Text = string.format("Total Holds: %d", total_holds),
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
                TotalLengthDisplay = Roact.createElement("TextLabel", {
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    LayoutOrder = 4,
                    Position = UDim2.new(0, 0, 0.432788938, 0),
                    Size = UDim2.new(0.957943916, 0, 0.122751191, 0),
                    Font = Enum.Font.GothamSemibold,
                    Text = string.format("Total Length: %s", SPUtil:format_ms_time(SongDatabase:get_song_length_for_key(_songkey))),
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
            Rate = Roact.createElement("TextLabel", {
                Name = "",
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                Position = UDim2.new(0.0253480561, 0, 0.740295172, 0),
                Size = UDim2.new(0.289368182, 0, 0.0559303947, 0),
                ZIndex = 3,
                Font = Enum.Font.GothamBold,
                Text = string.format("Rate: %0.02fx", (self.props.rate and self.props.rate or 100)/100),
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

return SongInfoDisplay