local SongDatabase = require(game.ReplicatedStorage.Shared.Core.API.Map.SongDatabase)
local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local AutoSize = require(game.ReplicatedStorage.Shared.Utils.AutoSize)

local SongButton = require(game.ReplicatedStorage.Client.Components.Screens.SongSelect.SongButton)

local SongButtonLayout = Roact.Component:extend("SongButtonLayout")

--[[
    startIndex = floor(scrollPosition / elementHeight)
    endIndex = ceil((scrollPosition + scrollSize) / elementHeight)
]]

function SongButtonLayout:init()
    self:setState({
        search = "";
        startIndex = 1;
        endIndex = 115;
    })
    self.on_button_click = self.props.on_button_click

    self.on_search_changed = function(o)
        self:setState({
            search = o.Text;
        })     
    end
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

function SongButtonLayout:render()
    local _buttons = {}

    for key_itr = self.state.startIndex, self.state.endIndex do
        local itr_data = SongDatabase:get_data_for_key(key_itr)
        -- if SongButtonLayout:search(self.state.search, key_itr) then
            _buttons["SongKey"..key_itr] = Roact.createElement(SongButton, {
                song_key = key_itr or 1,
                artist = itr_data.AudioArtist,
                title = itr_data.AudioFilename,
                difficulty = itr_data.AudioDifficulty,
                image = itr_data.AudioCoverImageAssetId,
                on_click = self.on_button_click,
                index = key_itr
            })
        -- end
    end

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
            CanvasSize = UDim2.fromOffset(0, SongDatabase:number_of_keys()*125),
            [Roact.Ref] = self.songListRef,
            [Roact.Change.CanvasPosition] = function(songList)
                local scrollPosition = songList.CanvasPosition
                local startIndex = math.floor(scrollPosition.Y / 125)+1;
                local endIndex = math.ceil((scrollPosition.Y + songList.AbsoluteSize.Y) / 125);

                print(startIndex, endIndex)

                self:setState({
                    startIndex = startIndex;
                    endIndex = endIndex;
                })
            end;
            [Roact.Change.AbsoluteSize] = function(songList)
                local scrollPosition = songList.CanvasPosition
                local startIndex = math.floor(scrollPosition.Y / 125)+1;
                local endIndex = math.ceil((scrollPosition.Y + songList.AbsoluteSize.Y) / 125);

                print(startIndex, endIndex)

                self:setState({
                    startIndex = startIndex;
                    endIndex = endIndex;
                })
            end;
        }, {
            SongButtons = Roact.createFragment(_buttons);
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
