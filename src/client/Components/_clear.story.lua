return function(target)
    target:ClearAllChildren()
    return function()
        target:ClearAllChildren()
    end
end