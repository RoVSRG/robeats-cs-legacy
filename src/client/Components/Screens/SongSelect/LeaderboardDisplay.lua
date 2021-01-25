local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local LeaderboardSlot = require(game.ReplicatedStorage.Client.Components.Screens.SongSelect.LeaderboardSlot)

local LeaderboardDisplay = Roact.Component:extend("LeaderboardDisplay")

local Button = require(game.ReplicatedStorage.Client.Components.Primitive.Button)

function LeaderboardDisplay:init()
    self._list_layout_ref = Roact.createRef()
    self.on_leaderboard_slot_activated = self.on_leaderboard_slot_activated or function() end

    self.onSongInfoClick = self.props.onSongInfoClick
end

function LeaderboardDisplay:didMount()
    local leaderboard_list_layout = self._list_layout_ref:getValue()
    local leaderboard_list = leaderboard_list_layout.Parent
    leaderboard_list_layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        leaderboard_list_layout.Parent.CanvasSize = UDim2.new(0, 0, 0, leaderboard_list.UIListLayout.AbsoluteContentSize.Y)
    end)
end

function LeaderboardDisplay:render()
    local _leaderboard_slots

    for i, v in pairs(self.props.leaderboard) do
        if not _leaderboard_slots then _leaderboard_slots = {} end
        v.place = v.place or i
        _leaderboard_slots["Slot"..i] = Roact.createElement(LeaderboardSlot, v)
    end

    return Roact.createElement("Frame", {
        BackgroundColor3 = Color3.fromRGB(25, 25, 25),
        BorderSizePixel = 0,
        AnchorPoint = self.props.AnchorPoint;
        Position = self.props.Position,
        Size = self.props.Size,
    }, {
        LeaderboardList = Roact.createElement("ScrollingFrame", {
            Active = true,
            BackgroundColor3 = Color3.fromRGB(25, 25, 25),
            BackgroundTransparency = 1,
            BorderColor3 = Color3.fromRGB(25, 25, 25),
            BorderSizePixel = 0,
            Position = UDim2.new(0.0075, 0, 0.015, 0),
            Size = UDim2.new(0.99, 0, 0.9, 0),
            BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
            ScrollingDirection = Enum.ScrollingDirection.Y,
            TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
        }, {
            UIListLayout = Roact.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                [Roact.Ref] = self._list_layout_ref
            }),
            LeaderboardSlots = Roact.createFragment(_leaderboard_slots)
        });
        ToSongInfoDisplay = Roact.createElement(Button, {
            Size = UDim2.new(0.2,0,0.057,0);
            Position = UDim2.new(0.0075,0,0.96,0);
            shrinkBy = 0.01;
            AnchorPoint = Vector2.new(0, 0.5);
            darkenBy = 8;
            BackgroundColor3 = Color3.fromRGB(40, 40, 40);
            TextColor3 = Color3.fromRGB(255, 255, 255);
            TextSize = 15;
            Text = "< Song Info";
            onActivated = self.onSongInfoClick
        })
    })
end

return LeaderboardDisplay
