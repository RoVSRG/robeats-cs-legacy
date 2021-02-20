local Audio = {}
Audio._channels = Instance.new("Folder")
Audio._channels.Parent = workspace

function Audio.channel(channelName)
    if Audio._channels:FindFirstChild(channelName) then
        return Audio._channels:FindFirstChild(channelName)
    end

    local channel = Instance.new("Sound")
    channel.Name = channelName
    channel.Parent = Audio._channels

    return channel
end

return Audio