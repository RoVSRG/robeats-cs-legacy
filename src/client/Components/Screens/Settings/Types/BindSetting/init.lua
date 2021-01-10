local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local Llama = require(game.ReplicatedStorage.Libraries.Llama)

local BaseSetting = require(script.Parent.BaseSetting)

local TableUtil = require(game.ReplicatedStorage.Shared.Utils.TableUtil)

local Bind = require(script.Bind)

local BindSetting = Roact.Component:extend("BindSetting")

BindSetting.defaultProps = {
    bindingProps = {}
}

function BindSetting:init()
    self.changeSetting = self.props.changeSetting
    self.increment = self.props.increment or 1
end

function BindSetting:render()
    local binds = TableUtil.Map(self.props.bindingProps, function(props, i, t)
        local mergedProps = Llama.Dictionary.join({
            size = 1/#t;
            position = (i-1)/#t;
            changeSetting = self.props.changeSetting;
        }, props)
        return Roact.createElement(Bind, mergedProps)
    end)

    return Roact.createElement(BaseSetting, {
        BackgroundColor3 = Color3.fromRGB(25, 25, 25),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 1, 0),
        valueDisplayVisible = false
    }, binds)
end

return BindSetting
