-- RemoteProperty
-- Stephen Leitnick

--[[

	[Server]

		property = RemoteProperty.new(value [, overrideClass])

		property:Get()
		property:Set(value)
		property:Replicate()  [Only for table values]
		property:Destroy()

		property.Changed(newValue)


	[Client]

		property = RemoteProperty.new(valueObject)

		property:Get()
		property:Destroy()

		property.Changed(newValue)

--]]

local IS_SERVER = game:GetService("RunService"):IsServer()
local Signal = require(script.Parent.Parent.Signal)

local typeClassMap = {
	boolean = "BoolValue";
	string = "StringValue";
	table = "RemoteEvent";
	CFrame = "CFrameValue";
	Color3 = "Color3Value";
	BrickColor = "BrickColorValue";
	number = "NumberValue";
	Instance = "ObjectValue";
	Ray = "RayValue";
	Vector3 = "Vector3Value";
	["nil"] = "ObjectValue";
}

local RemoteProperty = {}
RemoteProperty.__index = RemoteProperty

function RemoteProperty.Is(object)
	return (type(object) == "table" and getmetatable(object) == RemoteProperty)
end

if (IS_SERVER) then

	function RemoteProperty.new(value, overrideClass)

		if (overrideClass ~= nil) then
			assert(type(overrideClass) == "string", "OverrideClass must be a string; got " .. type(overrideClass))
			assert(overrideClass:match("Value$"), "OverrideClass must be of super type ValueBase (e.g. IntValue); got " .. overrideClass)
		end

		local t = typeof(value)
		local class = overrideClass or typeClassMap[t]
		assert(class, "RemoteProperty does not support type \"" .. t .. "\"")

		local self = setmetatable({
			_value = value;
			_type = t;
			_isTable = (t == "table");
			_object = Instance.new(class);
		}, RemoteProperty)

		if (self._isTable) then
			local req = Instance.new("RemoteFunction")
			req.Name = "TableRequest"
			req.Parent = self._object
			function req.OnServerInvoke(_player)
				return self._value
			end
		end

		self.Changed = self._object.Changed
		self:Set(value)

		return self

	end

	function RemoteProperty:Replicate()
		if (self._isTable) then
			self:Set(self._value)
		end
	end

	function RemoteProperty:Set(value)
		if (self._isTable) then
			self._object:FireAllClients(value)
		else
			self._object.Value = value
		end
		self._value = value
	end

	function RemoteProperty:Get()
		return self._value
	end

	function RemoteProperty:Destroy()
		self._object:Destroy()
	end

else

	function RemoteProperty.new(object)
		local self = setmetatable({
			_object = object;
			_value = nil;
			_isTable = object:IsA("RemoteEvent");
		}, RemoteProperty)
		local function SetValue(v)
			self._value = v
		end
		if (self._isTable) then
			self.Changed = Signal.new()
			self._change = object.OnClientEvent:Connect(function(tbl)
				SetValue(tbl)
				self.Changed:Fire(tbl)
			end)
			SetValue(object.TableRequest:InvokeServer())
		else
			SetValue(object.Value)
			self.Changed = object.Changed
			self._change = object.Changed:Connect(SetValue)
		end
		return self
	end

	function RemoteProperty:Get()
		return self._value
	end

	function RemoteProperty:Destroy()
		self._change:Disconnect()
		self._set:Destroy()
		if (self._isTable) then
			self.Changed:Destroy()
		end
	end

end

return RemoteProperty
