local AutoSize = {}

function AutoSize.list(instance)
    local listLayout = instance:FindFirstChildWhichIsA("UIListLayout")
    listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        instance.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y)
    end)
end

return AutoSize
