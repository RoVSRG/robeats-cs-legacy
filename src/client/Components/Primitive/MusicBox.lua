local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local Flipper = require(game.ReplicatedStorage.Libraries.Flipper)
local RoactFlipper = require(game.ReplicatedStorage.Libraries.RoactFlipper)
local ImageButton = require(game:GetService("ReplicatedStorage"):WaitForChild("Client").Components.Primitive["ImageButton"])
local Slider = require(game:GetService("ReplicatedStorage"):WaitForChild("Client").Components.Primitive["Slider"])
local SongDatabase = require(game.ReplicatedStorage.Shared.Core.API.Map.SongDatabase)
local Gradient = require(game.ReplicatedStorage.Shared.Utils.Gradient)
local Sound = require(game:GetService("ReplicatedStorage"):WaitForChild("Client").Components.Primitive["Sound"])

local SPUtil = require(game.ReplicatedStorage.Shared.Utils.SPUtil)

local MusicBox = Roact.Component:extend("MusicBox")

MusicBox.defaultProps = {
    Position = UDim2.new(0, 0, 0, 0);
    Size = UDim2.fromScale(1, 1);
    AnchorPoint = Vector2.new(0,0);
    songKey = 87;
}

function MusicBox:init()
    self.soundRef = Roact.createRef()
    
    self.motor = Flipper.GroupMotor.new({
        loudness = 0;
        position = 0;
    })
    self.motorBinding = RoactFlipper.getBinding(self.motor)

    -- store number of keys in a variable because it is too expensive to get the count
    local numOfKeys = SongDatabase:number_of_keys()

    self:setState({
        songKey = 1; --math.random(1, SongDatabase:number_of_keys());
        isPlaying = true;
    })

    self.switchSongKey = function(increment)
        self:setState(function(state)
            local newIndex = state.songKey + increment
            if newIndex == 0 then
                return {
                    songKey = numOfKeys
                }
            elseif newIndex > numOfKeys then
                return {
                    songKey = 1
                }
            end
            return {
                songKey = newIndex
            }
        end)
    end
end

function MusicBox:getGradient()
    local gradient = Gradient:new()

    for i = 0, 1, 0.1 do
        gradient:add_number_keypoint(i, i)
    end

    return gradient:number_sequence()
end

function MusicBox:didMount()
    local sound = self.soundRef:getValue()
    
    self.con = SPUtil:bind_to_frame(function()
        self.motor:setGoal({
            loudness = Flipper.Spring.new(sound.PlaybackLoudness, {
                frequency = 8;
                dampingRatio = 1.5;
            });
            position = Flipper.Spring.new(sound.TimePosition/sound.TimeLength, {
                frequency = 5;
                dampingRatio = 3;
            })
        })
    end)
end

function MusicBox:render()
    return Roact.createElement("Frame", {
        Name = "Profile";
        Size = self.props.Size;
        Position = self.motorBinding:map(function(a)
            return self.props.Position - UDim2.fromOffset(20*(a.loudness/1000), 0)
        end);
        BackgroundColor3 = Color3.fromRGB(17,17,17);
        ZIndex = 1;
        AnchorPoint = self.props.AnchorPoint;
        --time to win
        --YES WE WILL WIN
        --POG , let this be our little secret conversation
    }, {
        Corner = Roact.createElement("UICorner",{
            CornerRadius = UDim.new(0,4);
        });

        SongName = Roact.createElement("TextLabel",{
            Name = "SongName";
            Text = string.format("%s - %s", SongDatabase:get_artist_for_key(self.state.songKey), SongDatabase:get_title_for_key(self.state.songKey));
            TextColor3 = Color3.fromRGB(255,255,255);
            TextScaled = true;
            Position = UDim2.fromScale(.5, .06);
            Size = UDim2.fromScale(.5,.25);
            AnchorPoint = Vector2.new(0.5,0);
            BackgroundTransparency = 1;
            Font = Enum.Font.GothamSemibold;
            ZIndex = 2;
            LineHeight = 1;
            TextStrokeColor3 = Color3.fromRGB(0, 0, 0);
            TextStrokeTransparency = .5;
        });

        Play = Roact.createElement(ImageButton,{
            Name = "ProfileImage";
            AnchorPoint = Vector2.new(0.5,0);
            AutomaticSize = Enum.AutomaticSize.None;
            BackgroundColor3 = Color3.fromRGB(11,11,11);
            BackgroundTransparency = 1;
            Position = UDim2.fromScale(.5, .55);
            Size = UDim2.fromScale(0.1, 0.3);
            Image = "rbxassetid://51811789";
            ImageColor3 = Color3.fromRGB(255,255,255);
            ScaleType = Enum.ScaleType.Fit;
            SliceScale = 1;
            shrinkBy = 0.025;
            onActivated = function()
                self:setState(function(state)
                    return {
                        isPlaying = not state.isPlaying;
                    }
                end)
            end
        });

        Back = Roact.createElement(ImageButton, {
            AutomaticSize = Enum.AutomaticSize.None;
            AnchorPoint = Vector2.new(0.5,0);
            BackgroundColor3 = Color3.fromRGB(11,11,11);
            BackgroundTransparency = 1;
            Position = UDim2.fromScale(.35, .55);
            Size = UDim2.fromScale(0.2, 0.3);
            Rotation = 180;
            Image = "rbxassetid://6323574622";
            ScaleType = Enum.ScaleType.Fit;
            SliceScale = 1;
            shrinkBy = 0.025;
            ImageColor3 = Color3.fromRGB(255, 255, 255);
            ImageTransparency = 0.65;
            onActivated = function()
                self.switchSongKey(1)
            end
        });

        Forward = Roact.createElement(ImageButton, {
            AutomaticSize = Enum.AutomaticSize.None;
            AnchorPoint = Vector2.new(0.5,0);
            BackgroundColor3 = Color3.fromRGB(11,11,11);
            BackgroundTransparency = 1;
            Position = UDim2.fromScale(.65, .55);
            Size = UDim2.fromScale(0.2, 0.3);
            Image = "rbxassetid://6323574622";
            ScaleType = Enum.ScaleType.Fit;
            SliceScale = 1;
            shrinkBy = 0.025;
            ImageColor3 = Color3.fromRGB(255, 255, 255);
            ImageTransparency = 0.65;
            onActivated = function()
                self.switchSongKey(1)
            end
        });

        SongCover = Roact.createElement("ImageLabel", {
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundColor3 = Color3.fromRGB(15, 15, 15),
            BorderSizePixel = 0,
            Position = UDim2.new(0, 0, 0.5, 0),
            Size = UDim2.new(0.5, 0, 1, 0),
            Image = SongDatabase:get_image_for_key(self.props.songKey),
            ScaleType = Enum.ScaleType.Crop,
        }, {
            Corner = Roact.createElement("UICorner", {
                CornerRadius = UDim.new(0,4)
            });
            Gradient = Roact.createElement("UIGradient",{
                Transparency = self:getGradient()
            })
        });
        
        Sound = Roact.createElement(Sound, {
            Playing = self.state.isPlaying;
            SoundId = SongDatabase:get_data_for_key(self.state.songKey).AudioAssetId;
            [Roact.Ref] = self.soundRef;
        });
    });
end

function MusicBox:willUnmount()
    self.con:Disconnect()
end

return MusicBox