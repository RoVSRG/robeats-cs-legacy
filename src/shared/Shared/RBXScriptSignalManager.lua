local SPDict = require(game.ReplicatedStorage.Shared.SPDict)

local RBXScriptSignalManager = {}

function RBXScriptSignalManager:new()
    local self = {}
    self._signals = SPDict:new()

    function self:add_signal(handle, rbx_script_signal)
        self._signals:add(handle, rbx_script_signal)
    end

    function self:disconnect_all()
        for _, rbx_script_signal in self._signals:key_itr() do
            if rbx_script_signal.Connected then
                rbx_script_signal:Disconnect()
            end
        end
    end

    function self:get_signal(name)
        return self._signals:get(name)
    end
    
    return self
end

return RBXScriptSignalManager
