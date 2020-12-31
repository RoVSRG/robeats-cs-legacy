local Promise = require(game.ReplicatedStorage.Libraries.Promise)

function WaitForChildAsync(instance, child, timeout)
    return Promise.new(function(resolve, reject)
        local _child = instance:WaitForChild(child, timeout)

        if _child then
            resolve(_child)
        else
            reject({error = "WaitForChild failed"})
        end
    end)
end

return WaitForChildAsync
