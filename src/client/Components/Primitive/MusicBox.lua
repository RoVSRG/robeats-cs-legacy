local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local ImageButton = require(game:GetService("ReplicatedStorage"):WaitForChild("Client").Components.Primitive["ImageButton"])
local Slider = require(game:GetService("ReplicatedStorage"):WaitForChild("Client").Components.Primitive["Slider"])
local SongDatabase = require(game.ReplicatedStorage.Shared.Core.API.Map.SongDatabase)
local Gradient = require(game.ReplicatedStorage.Shared.Utils.Gradient)
local Sound = require(game:GetService("ReplicatedStorage"):WaitForChild("Client").Components.Primitive["Sound"])

local SPUtil = require(game.ReplicatedStorage.Shared.Utils.SPUtil)

local MusicBox = Roact.Component:extend("MusicBox")

function MusicBox:init()
    self.soundRef = Roact.createRef()
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
        print(sound.PlaybackLoudness)
    end)
end

function MusicBox:render()
    return Roact.createElement("Frame", {
        Name = "Profile";
        Size = self.props.Size;
        Position = self.props.Position;
        BackgroundColor3 = Color3.fromRGB(17,17,17);
        ZIndex = 1;
        AnchorPoint = Vector2.new(1,0);
        --time to win
        --YES WE WILL WIN
    }, {
        Corner = Roact.createElement("UICorner",{
            CornerRadius = UDim.new(0,4);
        });

        SongName = Roact.createElement("TextLabel",{
            Name = "SongName";
            Text = "bobux man - bobux dance";
            TextColor3 = Color3.fromRGB(255,255,255);
            TextScaled = true;
            Position = UDim2.fromScale(.5, .06);
            Size = UDim2.fromScale(.5,.25);
            AnchorPoint = Vector2.new(0.5,0);
            BackgroundTransparency = 1;
            Font = Enum.Font.GothamSemibold;
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
            Size = UDim2.fromScale(0.3, 0.3);
            Image = "rbxassetid://51811789";
            ImageColor3 = Color3.fromRGB(255,255,255);
            ScaleType = Enum.ScaleType.Fit;
            SliceScale = 1;
            shrinkBy = 0.025;
        });

        SongCover = Roact.createElement("ImageLabel", {
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundColor3 = Color3.fromRGB(15, 15, 15),
            BorderSizePixel = 0,
            Position = UDim2.new(0, 0, 0.5, 0),
            Size = UDim2.new(0.5, 0, 1, 0),
            Image = "rbxassetid://698514070",
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
            Playing = true;
            SoundId = SongDatabase:get_data_for_key(self.props.songKey).AudioAssetId;
            [Roact.Ref] = self.ref;
        })
    });
end

return MusicBox