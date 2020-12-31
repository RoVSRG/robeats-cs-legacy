local SongDatabase = require(game.ReplicatedStorage.Shared.Core.API.Map.SongDatabase)
local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local SongButton = require(game.ReplicatedStorage.Client.Components.Screens.SongSelect.SongButton)

local SongButtonLayout = Roact.Component:extend("SongButtonLayout")

function SongButtonLayout:init()
    self._songbuttons = {}
    self._list_layout_ref = Roact.createRef()
    self:setState({
        search = "";
    })
    self.on_button_click = self.props.on_button_click

    self.on_search_changed = function(o)
        self:setState({
            search = o.Text;
        })     
    end
end

function SongButtonLayout:didMount()
    local song_list_layout = self._list_layout_ref:getValue()
    local song_list = song_list_layout.Parent
    song_list_layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        song_list_layout.Parent.CanvasSize = UDim2.new(0, 0, 0, song_list.UIListLayout.AbsoluteContentSize.Y)
    end)
end

function SongButtonLayout:search(search, _songkey)
    search = search or ""
    search = string.split(search, " ")

    local _to_search = SongDatabase:get_searchable_string_for_key(_songkey)
    local found = 0
    for i = 1, #search do
        local search_term = search[i]
        if string.find(_to_search:lower(), search_term:lower()) ~= nil then
            found = found + 1
        end
    end

    return found == #search
end

function SongButtonLayout:renderableButtons()
    local _buttons = {}
    
    for key_itr, itr_data in pairs(self.props.songs) do
        _buttons["SongKey"..key_itr] = Roact.createElement(SongButton, {
            song_key = key_itr or 1,
            artist = itr_data.AudioArtist,
            title = itr_data.AudioFilename,
            difficulty = itr_data.AudioDifficulty,
            image = itr_data.AudioCoverImageAssetId,
            on_click = self.on_button_click,
            visible = SongButtonLayout:search(self.state.search, key_itr)
        })
    end

    return _buttons
end

function SongButtonLayout:render()
    return Roact.createElement("Frame", {
        Name = "SongSection",
        AnchorPoint = self.props.AnchorPoint,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = self.props.Position,
        Size = self.props.Size,
    }, {
        Roact.createElement("UICorner", {
            CornerRadius = UDim.new(0, 4),
        }),
        SongList = Roact.createElement("ScrollingFrame", {
            Active = true,
            AnchorPoint = Vector2.new(1, 1),
            BackgroundTransparency = 1;
            BorderSizePixel = 0,
            Position = UDim2.new(1, 0, 1, 0),
            Size = UDim2.new(1, 0, 0.95, 0),
            BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
            ScrollBarThickness = 8,
            TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
            VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right,
        }, {
            Layout = Roact.createFragment({
                UIListLayout = Roact.createElement("UIListLayout", {
                    HorizontalAlignment = Enum.HorizontalAlignment.Right;
                    Padding = UDim.new(0, 5);
                    [Roact.Ref] = self._list_layout_ref
                });
                SongButtons = Roact.createFragment(self:renderableButtons());
            })
        }),
        Roact.createElement("Frame", {
            Name = "SearchBar",
            BackgroundColor3 = Color3.fromRGB(31, 31, 31),
            Position = UDim2.new(1, 0, 0.04, 0),
            Size = UDim2.new(1, 0, 0.04, 0),
            AnchorPoint = Vector2.new(1, 1),
        }, {
            Roact.createElement("UICorner", {
                CornerRadius = UDim.new(0, 4),
            }),
            Roact.createElement("TextBox", {
                Name = "SearchBox",
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                Position = UDim2.new(0.02, 0, 0, 0),
                Size = UDim2.new(0.98, 0, 1, 0),
                ClearTextOnFocus = false,
                Font = Enum.Font.GothamBold,
                PlaceholderColor3 = Color3.fromRGB(181, 181, 181),
                PlaceholderText = "Search here...",
                Text = "",
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextScaled = true,
                TextSize = 14,
                TextWrapped = true,
                TextXAlignment = Enum.TextXAlignment.Left,
                [Roact.Change.Text] = self.on_search_changed
            }, {
                Roact.createElement("UITextSizeConstraint", {
                    MaxTextSize = 17,
                    MinTextSize = 7,
                })
            })
        })
    })
end

return SongButtonLayout
