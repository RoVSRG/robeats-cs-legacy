local EnumHandler = require(script.Parent.Parent.System.EnumHandler)
local Vector3Handler = EnumHandler:new()

function Vector3Handler:serialize(item)
		return self:new_object("Vector3", {X = item.X, Y = item.Y, Z = item.Z})
		
end

function Vector3Handler:deserialize(item)
		return Vector3.new(item.X, item.Y, item.Z)
end

return Vector3Handler