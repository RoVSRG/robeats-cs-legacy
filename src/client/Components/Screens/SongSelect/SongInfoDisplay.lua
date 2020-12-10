local SongDatabase = require(game.ReplicatedStorage.Shared.Core.API.Map.SongDatabase)
local SPUtil = require(game.ReplicatedStorage.Shared.Utils.SPUtil)
local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local RoactAnimate = require(game.ReplicatedStorage.Libraries.RoactAnimate)

local NpsGraph = require(game.ReplicatedStorage.Client.Components.Graph.NpsGraph)

local SongInfoDisplay = Roact.Component:extend("SongInfoDisplay")

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
            Roact.createElement(NpsGraph, {
                Name = "Items",
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                ClipsDescendants = true,
                Position = UDim2.new(0.0134330085, 0, 0.796225548, 0),
                Size = UDim2.new(0.971014559, 0, 0.185931787, 0),
                song_key = _songkey,
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
                    Padding = UDim.new(0.01, 0),
                }),
                ArtistDisplay = Roact.createElement("TextLabel", {
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    LayoutOrder = 1,
                    --Size = UDim2.new(0.957943857, 0, 0.268147349, 0),
                    Size = UDim2.new(3, 0, 0.5, 0),
                    Font = Enum.Font.Gotham,
                    Text = SongDatabase:get_artist_for_key(_songkey),
                    TextColor3 = Color3.fromRGB(255, 208, 87),
                    TextScaled = true,
                    TextSize = 30,
                    TextWrapped = true,
                    TextXAlignment = Enum.TextXAlignment.Left,
                }, {
                    Roact.createElement("UITextSizeConstraint", {
                        MaxTextSize = 40,
                    })
                }),
                NameDisplay = Roact.createElement("TextLabel", {
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    LayoutOrder = 2,
                    -- Position = UDim2.new(0, 0, 0.26814732, 0),
                    Position = UDim2.new(0, 0, 0.525, 0),
                    --Size = UDim2.new(0.957943916, 0, 0.164641663, 0),
                    Size = UDim2.new(3, 0, 0.5, 0),
                    Font = Enum.Font.GothamBold,
                    Text = SongDatabase:get_title_for_key(_songkey),
                    TextColor3 = Color3.fromRGB(255, 208, 87),
                    TextScaled = true,
                    TextSize = 30,
                    TextWrapped = true,
                    TextXAlignment = Enum.TextXAlignment.Left,
                }, {
                    Roact.createElement("UITextSizeConstraint", {
                        MaxTextSize = 40,
                    })
                }),
                DifficultyDisplay = Roact.createElement("TextLabel", {
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    LayoutOrder = 3,
                    Position = UDim2.new(0, 0, 0.432788938, 0),
                    Size = UDim2.new(1, 0, 0.175, 0),
                    Font = Enum.Font.GothamSemibold,
                    Text = string.format("Difficulty: %d", SongDatabase:get_difficulty_for_key(_songkey)),
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    TextScaled = true,
                    TextSize = 30,
                    TextWrapped = true,
                    TextXAlignment = Enum.TextXAlignment.Left,
                }, {
                    Roact.createElement("UITextSizeConstraint", {
                        MaxTextSize = 35,
                    })
                }),
                TotalNotesDisplay = Roact.createElement("TextLabel", {
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    LayoutOrder = 3,
                    Position = UDim2.new(0, 0, 0.4, 0),
                    -- Size = UDim2.new(0.957943916, 0, 0.122751191, 0),
                    Size = UDim2.new(1, 0, 0.175, 0),
                    Font = Enum.Font.GothamSemibold,
                    Text = string.format("Total Notes: %d", total_notes),
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    TextScaled = true,
                    TextSize = 30,
                    TextWrapped = true,
                    TextXAlignment = Enum.TextXAlignment.Left,
                }, {
                    Roact.createElement("UITextSizeConstraint", {
                        MaxTextSize = 35,
                    })
                }),
                TotalHoldsDisplay = Roact.createElement("TextLabel", {
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    LayoutOrder = 4,
                    Position = UDim2.new(0, 0, 0.432788938, 0),
                    -- Size = UDim2.new(0.957943916, 0, 0.122751191, 0),
                    Size = UDim2.new(1, 0, 0.175, 0),
                    Font = Enum.Font.GothamSemibold,
                    Text = string.format("Total Holds: %d", total_holds),
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    TextScaled = true,
                    TextSize = 30,
                    TextWrapped = true,
                    TextXAlignment = Enum.TextXAlignment.Left,
                }, {
                    Roact.createElement("UITextSizeConstraint", {
                        MaxTextSize = 35,
                    })
                }),
                TotalLengthDisplay = Roact.createElement("TextLabel", {
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    LayoutOrder = 4,
                    Position = UDim2.new(0, 0, 0.432788938, 0),
                    -- Size = UDim2.new(0.957943916, 0, 0.122751191, 0),
                    Size = UDim2.new(1, 0, 0.175, 0),
                    Font = Enum.Font.GothamSemibold,
                    Text = string.format("Total Length: %s", SPUtil:format_ms_time(SongDatabase:get_song_length_for_key(_songkey))),
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    TextScaled = true,
                    TextSize = 30,
                    TextWrapped = true,
                    TextXAlignment = Enum.TextXAlignment.Left,
                }, {
                    Roact.createElement("UITextSizeConstraint", {
                        MaxTextSize = 35,
                    })
                })
            }),
            Rate = Roact.createElement("TextLabel", {
                Name = "",
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                Position = UDim2.new(0.0253480561, 0, 0.740295172, 0),
                --Size = UDim2.new(0.289368182, 0, 0.0559303947, 0),
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