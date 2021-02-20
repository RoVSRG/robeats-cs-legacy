local SongDatabase = require(game.ReplicatedStorage.Shared.Core.API.Map.SongDatabase)
local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local AutoSize = require(game.ReplicatedStorage.Shared.Utils.AutoSize)

local SongButton = require(game.ReplicatedStorage.Client.Components.Screens.SongSelect.SongButton)

local ScrollingFrame = require(game.ReplicatedStorage.Client.Components.Primitive.ScrollingFrame)

local SongButtonLayout = Roact.Component:extend("SongButtonLayout")

-- LOL SEARCHING GO BYE BYE, PLEASE FIX
-- RIP SEARCHING

--[[
    startIndex = floor(scrollPosition / elementHeight)
    endIndex = ceil((scrollPosition + scrollSize) / elementHeight)
]]

function SongButtonLayout:init()
    self._songbuttons = {}
    self._list_layout_ref = Roact.createRef()
    self:setState({
        search = "";
        found = {};
        numberFound =  0;
    })
    self.on_button_click = self.props.on_button_click

    self.on_search_changed = function(o)
        self:setState({
            search = o.Text;
        })
        self:makeSearch(o.Text) 
    end
end

function SongButtonLayout:makeSearch(search)
    local time = tick()
    spawn(function()
        SongDatabase:search(search):andThen(function(found)
            self:setState({
                found = found
            })
        end)

        -- SongDatabase:lol():andThen(function(value)
        --     print(value)
        -- end)
        print(tick()-time)
    end)
end

function SongButtonLayout:render()
    return Roact.createElement("Frame", {
        AnchorPoint = self.props.AnchorPoint,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = self.props.Position,
        Size = self.props.Size,
    }, {
        UICorner = Roact.createElement("UICorner", {
            CornerRadius = UDim.new(0, 4),
        }),
        SongList = Roact.createElement(ScrollingFrame, {
            Active = true,
            BackgroundTransparency = 1;
            BorderSizePixel = 0,
            Position = UDim2.new(0, 0, 0.05, 0),
            Size = UDim2.new(1, 0, 0.95, 0),
            BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
            ScrollBarThickness = 8,
            TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
            VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right,
            numberOfItems = SongDatabase:number_of_keys();
            getElementForIndex = function(i)
                local itr_data = SongDatabase:get_data_for_key(i)
                return Roact.createElement(SongButton, {
                    song_key = i or 1,
                    artist = itr_data.AudioArtist,
                    title = itr_data.AudioFilename,
                    difficulty = itr_data.AudioDifficulty,
                    image = itr_data.AudioCoverImageAssetId,
                    on_click = self.on_button_click,
                    index = i,
                    LayoutOrder = i
                })
            end,
        }),
        SearchBar = Roact.createElement("Frame", {
            BackgroundColor3 = Color3.fromRGB(31, 31, 31),
            Position = UDim2.new(1, 0, 0.04, 0),
            Size = UDim2.new(1, 0, 0.04, 0),
            AnchorPoint = Vector2.new(1, 1),
        }, {
            UICorner = Roact.createElement("UICorner", {
                CornerRadius = UDim.new(0, 4),
            }),
            SearchBox = Roact.createElement("TextBox", {
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                Position = UDim2.new(0.02, 0, 0, 0),
                Size = UDim2.new(0.98, 0, 1, 0),
                ClearTextOnFocus = false,
                Font = Enum.Font.GothamBold,
                PlaceholderColor3 = Color3.fromRGB(181, 181, 181),
                PlaceholderText = "Search here...",
                Text = self.state.search,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextScaled = true,
                TextSize = 14,
                TextWrapped = true,
                TextXAlignment = Enum.TextXAlignment.Left,
                [Roact.Change.Text] = self.on_search_changed
            }, {
                UITextSizeConstraint = Roact.createElement("UITextSizeConstraint", {
                    MaxTextSize = 17,
                    MinTextSize = 7,
                })
            })
        })
    })
end

return SongButtonLayout
