local Bindable = {}

function Bindable:new(initialValue)
    local bindable = {}
    bindable._value = initialValue

    bindable.onChange = Instance.new("BindableEvent")

    function bindable:change(value)
        self._value = value
        self.onChange:Fire(self._value)
    end

    function bindable:getValue() return self._value end

    return bindable
end

return Bindable
