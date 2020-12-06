    
local Roact = require(game.ReplicatedStorage.Libraries.Roact)

-- TODO: spread out frame objects into their own components

local SpreadDisplay = Roact.Component:extend("SpreadDisplay")

function SpreadDisplay:render()
    local total_count = self.props.marvs + self.props.perfs + self.props.greats + self.props.goods + self.props.bads + self.props.misses
    return Roact.createElement("Frame", {
        Name = "SpreadDisplay",
        BackgroundColor3 = Color3.fromRGB(22, 22, 22),
        Position = self.props.Position,
        Size = self.props.Size or UDim2.new(1,0,1,0),
        AnchorPoint = self.props.AnchorPoint
    }, {
        Roact.createElement("UICorner", {
            CornerRadius = UDim.new(0, 4),
        }),
        Roact.createElement("Frame", {
            Name = "Marvs",
            BackgroundColor3 = Color3.fromRGB(77, 77, 77),
            Size = UDim2.new(1, 0, 0.165714279, 0),
        }, {
            Roact.createElement("UICorner", {
                CornerRadius = UDim.new(0, 4),
            }),
            Roact.createElement("Frame", {
                Name = "Total",
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BorderSizePixel = 0,
                Size = UDim2.new(self.props.marvs/total_count, 0, 1.00000024, 0),
                ZIndex = 2,
            }, {
                Roact.createElement("UICorner", {
                    CornerRadius = UDim.new(0, 4),
                })
            }),
            Roact.createElement("TextLabel", {
                Name = "Count",
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 11,
                Position = UDim2.new(0.114504747, 0, 0, 0),
                Size = UDim2.new(0.816793919, 0, 1.00000012, 0),
                ZIndex = 3,
                Font = Enum.Font.Gotham,
                Text = self.props.marvs,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextScaled = true,
                TextSize = 14,
                TextStrokeTransparency = 0,
                TextWrapped = true,
                TextXAlignment = Enum.TextXAlignment.Right,
            }, {
                Roact.createElement("UITextSizeConstraint", {
                    MaxTextSize = 17,
                    MinTextSize = 8,
                })
            })
        }),
        Roact.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
        }),
        Roact.createElement("Frame", {
            Name = "Perfs",
            BackgroundColor3 = Color3.fromRGB(77, 70, 0),
            Size = UDim2.new(1, 0, 0.165714279, 0),
        }, {
            Roact.createElement("UICorner", {
                CornerRadius = UDim.new(0, 4),
            }),
            Roact.createElement("Frame", {
                Name = "Total",
                BackgroundColor3 = Color3.fromRGB(255, 238, 0),
                BorderSizePixel = 0,
                Size = UDim2.new(self.props.perfs/total_count, 0, 1.00000024, 0),
                ZIndex = 2,
            }, {
                Roact.createElement("UICorner", {
                    CornerRadius = UDim.new(0, 4),
                })
            }),
            Roact.createElement("TextLabel", {
                Name = "Count",
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 11,
                Position = UDim2.new(0.114504747, 0, 0, 0),
                Size = UDim2.new(0.816793919, 0, 1.00000012, 0),
                ZIndex = 3,
                Font = Enum.Font.Gotham,
                Text = self.props.perfs,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextScaled = true,
                TextSize = 14,
                TextStrokeTransparency = 0,
                TextWrapped = true,
                TextXAlignment = Enum.TextXAlignment.Right,
            }, {
                Roact.createElement("UITextSizeConstraint", {
                    MaxTextSize = 17,
                    MinTextSize = 8,
                })
            })
        }),
        Roact.createElement("Frame", {
            Name = "Greats",
            BackgroundColor3 = Color3.fromRGB(0, 77, 2),
            Size = UDim2.new(1, 0, 0.165714279, 0),
        }, {
            Roact.createElement("UICorner", {
                CornerRadius = UDim.new(0, 4),
            }),
            Roact.createElement("Frame", {
                Name = "Total",
                BackgroundColor3 = Color3.fromRGB(35, 255, 1),
                BorderSizePixel = 0,
                Size = UDim2.new(self.props.greats/total_count, 0, 1.00000024, 0),
                ZIndex = 2,
            }, {
                Roact.createElement("UICorner", {
                    CornerRadius = UDim.new(0, 4),
                })
            }),
            Roact.createElement("TextLabel", {
                Name = "Count",
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 11,
                Position = UDim2.new(0.114504747, 0, 0, 0),
                Size = UDim2.new(0.816793919, 0, 1.00000012, 0),
                ZIndex = 3,
                Font = Enum.Font.Gotham,
                Text = self.props.greats,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextScaled = true,
                TextSize = 14,
                TextStrokeTransparency = 0,
                TextWrapped = true,
                TextXAlignment = Enum.TextXAlignment.Right,
            }, {
                Roact.createElement("UITextSizeConstraint", {
                    MaxTextSize = 17,
                    MinTextSize = 8,
                })
            })
        }),
        Roact.createElement("Frame", {
            Name = "Goods",
            BackgroundColor3 = Color3.fromRGB(2, 0, 74),
            Size = UDim2.new(1, 0, 0.165714279, 0),
        }, {
            Roact.createElement("UICorner", {
                CornerRadius = UDim.new(0, 4),
            }),
            Roact.createElement("Frame", {
                Name = "Total",
                BackgroundColor3 = Color3.fromRGB(0, 46, 255),
                BorderSizePixel = 0,
                Size = UDim2.new(self.props.goods/total_count, 0, 1.00000024, 0),
                ZIndex = 2,
            }, {
                Roact.createElement("UICorner", {
                    CornerRadius = UDim.new(0, 4),
                })
            }),
            Roact.createElement("TextLabel", {
                Name = "Count",
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 11,
                Position = UDim2.new(0.114504747, 0, 0, 0),
                Size = UDim2.new(0.816793919, 0, 1.00000012, 0),
                ZIndex = 3,
                Font = Enum.Font.Gotham,
                Text = self.props.goods,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextScaled = true,
                TextSize = 14,
                TextStrokeTransparency = 0,
                TextWrapped = true,
                TextXAlignment = Enum.TextXAlignment.Right,
            }, {
                Roact.createElement("UITextSizeConstraint", {
                    MaxTextSize = 17,
                    MinTextSize = 8,
                })
            })
        }),
        Roact.createElement("Frame", {
            Name = "Bads",
            BackgroundColor3 = Color3.fromRGB(59, 0, 74),
            Size = UDim2.new(1, 0, 0.165714279, 0),
        }, {
            Roact.createElement("UICorner", {
                CornerRadius = UDim.new(0, 4),
            }),
            Roact.createElement("Frame", {
                Name = "Total",
                BackgroundColor3 = Color3.fromRGB(200, 0, 255),
                BorderSizePixel = 0,
                Size = UDim2.new(self.props.bads/total_count, 0, 1.00000024, 0),
                ZIndex = 2,
            }, {
                Roact.createElement("UICorner", {
                    CornerRadius = UDim.new(0, 4),
                })
            }),
            Roact.createElement("TextLabel", {
                Name = "Count",
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 11,
                Position = UDim2.new(0.114504747, 0, 0, 0),
                Size = UDim2.new(0.816793919, 0, 1.00000012, 0),
                ZIndex = 3,
                Font = Enum.Font.Gotham,
                Text = self.props.bads,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextScaled = true,
                TextSize = 14,
                TextStrokeTransparency = 0,
                TextWrapped = true,
                TextXAlignment = Enum.TextXAlignment.Right,
            }, {
                Roact.createElement("UITextSizeConstraint", {
                    MaxTextSize = 17,
                    MinTextSize = 8,
                })
            })
        }),
        Roact.createElement("Frame", {
            Name = "Misses",
            BackgroundColor3 = Color3.fromRGB(74, 0, 1),
            Size = UDim2.new(1, 0, 0.16, 0),
        }, {
            Roact.createElement("UICorner", {
                CornerRadius = UDim.new(0, 4),
            }),
            Roact.createElement("Frame", {
                Name = "Total",
                BackgroundColor3 = Color3.fromRGB(255, 0, 4),
                BorderSizePixel = 0,
                Size = UDim2.new(self.props.misses/total_count, 0, 1, 0),
                ZIndex = 2,
            }, {
                Roact.createElement("UICorner", {
                    CornerRadius = UDim.new(0, 4),
                })
            }),
            Roact.createElement("TextLabel", {
                Name = "Count",
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 11,
                Position = UDim2.new(0.114504747, 0, 0, 0),
                Size = UDim2.new(0.816793919, 0, 1.00000012, 0),
                ZIndex = 3,
                Font = Enum.Font.Gotham,
                Text = self.props.misses,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextScaled = true,
                TextSize = 14,
                TextStrokeTransparency = 0,
                TextWrapped = true,
                TextXAlignment = Enum.TextXAlignment.Right,
            }, {
                Roact.createElement("UITextSizeConstraint", {
                    MaxTextSize = 17,
                    MinTextSize = 8,
                })
            })
        })
    })
end


return SpreadDisplay