local SongDatabase = require(game.ReplicatedStorage.RobeatsGameCore.SongDatabase)
local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local SongButton = require(game.ReplicatedStorage.Components.UI.SongSelect.SongButton)

local SongButtonLayout = Roact.Component:extend("SongButtonLayout")

function SongButtonLayout:init()
    self._list_layout_ref = Roact.createRef()
    self:setState({
        search = ""
    })
end

function SongButtonLayout:didMount()
    local song_list_layout = self._list_layout_ref:getValue()
    local song_list = song_list_layout.Parent
    song_list_layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        song_list_layout.Parent.CanvasSize = UDim2.new(0, 0, 0, song_list.UIListLayout.AbsoluteContentSize.Y)
    end)
end

function SongButtonLayout:render()
    local _songbuttons = {}

    for key_itr, itr_data in SongDatabase:key_itr() do
        if key_itr >= 50 then break end
        _songbuttons[#_songbuttons+1] = Roact.createElement(SongButton, {
            song_key = key_itr or 1,
            on_click = function(key)
                print(key)
            end
        })
    end

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
            Layout = Roact.createFragment({
                UIListLayout = Roact.createElement("UIListLayout", {
                    HorizontalAlignment = Enum.HorizontalAlignment.Right;
                    Padding = UDim.new(0, 5);
                    [Roact.Ref] = self._list_layout_ref
                });
                SongButtons = Roact.createFragment(_songbuttons);
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