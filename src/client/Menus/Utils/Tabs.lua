local SPDict = require(game.ReplicatedStorage.Shared.SPDict)

local Tabs = {}

function Tabs:new(_tabs, _default_tab)
    local self = {}
    self.tabs = SPDict:new():add_table(_tabs)
    self._instance_name_to_tab = SPDict:new()
    local _currently_activated_tab

    function self:cons()
        for k, tab in self.tabs:key_itr() do
            tab.Visible = tab.Name == _default_tab
            self._instance_name_to_tab:add(tab.Name, tab)
        end
    end

    function self:switch_tab(tab) --tweening?
        if _currently_activated_tab then
            _currently_activated_tab.Visible = false
        end
        _currently_activated_tab = self._instance_name_to_tab:get(tab)
        _currently_activated_tab.Visible = true
    end

    self:cons()

    return self
end

return Tabs
