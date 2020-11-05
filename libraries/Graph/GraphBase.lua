local GraphBase = {}

function GraphBase:new()
    local self = {}

    self.x_upper_bound = 10
    self.x_lower_bound = 10
    self.y_upper_bound = 10
    self.y_lower_bound = 10

    function self:add_data_point() error("Not implemented") end
    function self:zoom(zoom_delta) error("Not implemented") end
    function self:set_bounds(x1, y1, x2, y2)
        self.x_upper_bound = x1
        self.x_lower_bound = x2
        self.y_upper_bound = y1
        self.y_lower_bound = y2
    end
    function self:add_data_point(params) error("Not implemented") end
    function self:attach_to_instance(instance)
        self.attached_instance = instance
    end

    return self
end

return GraphBase
