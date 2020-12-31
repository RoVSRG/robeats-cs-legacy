local Knit = require(game:GetService("ReplicatedStorage").Knit)
local PreviewController = Knit.CreateController { Name = "PreviewController" }

local TweenService = game:GetService("TweenService")

function PreviewController:KnitInit()
    self.audio = Instance.new("Sound")
    self.audio = Instance.new("Sound")
    self.audio.Parent = workspace
    print(self.Shared)
    self.audio.Loaded:Connect(function()
        self.audio.TimePosition = self.Shared.NumberUtil.Lerp(0,self.audio.TimeLength,0.35)
        self.audio.PlaybackSpeed = 1
        self.audio.Volume = 0
        local volume_tween_info = TweenInfo.new(3)
        local volume_tween = TweenService:Create(self.audio, volume_tween_info, {
            Volume = 0.5
        })
        volume_tween:Play()
        self.audio:Play()
    end)
    self.audio.Looped = true
end

return PreviewController
