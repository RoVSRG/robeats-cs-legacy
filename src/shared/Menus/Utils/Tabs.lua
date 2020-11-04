local SPDict = require(game.ReplicatedStorage.Shared.SPDict)

local Tabs = {}

function Tabs:new(_tabs, _default_tab)
    local self = {}
    self.tabs = SPDict:new():add_table(_tabs)
    local _currently_activated_tab

    function self:cons()
        for k, tab in self.tabs:key_itr() do
            tab.Visible = k == _default_tab
        end
    end

    function self:switch_tab(tab) --tweening?
        _currently_activated_tab.Visible = false
        _currently_activated_tab = self.tabs:get(tab)
        _currently_activated_tab.Visible = true
    end

    self:cons()

    return self
end

return Tabs
