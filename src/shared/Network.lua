local module = {}

local ReplicatedStorage = game.ReplicatedStorage
local Remotes = script

local IsServer = game:GetService("RunService"):IsServer()

local function ServerConnectEvent(self, f)
	return self.remoteEvent.OnServerEvent:Connect(f)
end

local function ClientConnectEvent(self, f)
	return self.remoteEvent.OnClientEvent:Connect(f)
end

local function ServerFireEvent(self, ...)
	local player = ...
	if typeof(player) == "Instance" and player.ClassName == "Player" then
		self.remoteEvent:FireClient(...)
	else
		error("Expected player as first argument got "..tostring(player))
	end
end

local function ClientFireEvent(self, ...)
	self.remoteEvent:FireServer(...)
end

local function ServerFireAllEvent(self, ...)
	self.remoteEvent:FireAllClients(...)
end

local function ServerSetFunction(self, f)
	self.remoteFunction.OnServerInvoke = f
end

local function ClientSetFunction(self, f)
	self.remoteFunction.OnClientInvoke = f
end

local function ServerInvokeFunction(self, ...)
	return self.remoteFunction:InvokeClient(...)
end

local function ClientInvokeFunction(self, ...)
	return self.remoteFunction:InvokeServer(...)
end

local function NewNetworkEvent(remoteevent)
	local event = {remoteEvent = remoteevent}
	if IsServer	then
		event.Connect = ServerConnectEvent
		event.Fire = ServerFireEvent
		event.FireAll = ServerFireAllEvent
	else
		event.Connect = ClientConnectEvent
		event.Fire = ClientFireEvent
	end
	return event
end

local function NewNetworkFunction(remotefunction)
	local t = {remoteFunction = remotefunction}
	if IsServer	then
		t.Set = ServerSetFunction
		t.Invoke = ServerInvokeFunction
	else
		t.Set = ClientSetFunction
		t.Invoke = ClientInvokeFunction
	end
	return t
end

function module.AddEvent(name)
	assert(type(name) == "string", "Need a string for module.AddEvent function argument")
	assert(IsServer, "Client cannot create events")
	assert(Remotes:FindFirstChild(name) == nil, "RemoteEvent already exists")
	local RemoteEvent = Instance.new("RemoteEvent")
	RemoteEvent.Name = name
	RemoteEvent.Parent = Remotes
	module[name] = NewNetworkEvent(RemoteEvent)
	return module[name]
end

function module.AddFunction(name)
	assert(type(name) == "string", "Need a string for module.AddFunction function argument")
	assert(Remotes:FindFirstChild(name) == nil, "RemoteFunction already exists")
	local RemoteFunction = Instance.new("RemoteFunction")
	RemoteFunction.Name = name
	RemoteFunction.Parent = Remotes
	module[name] = NewNetworkFunction(RemoteFunction)
	return module[name]
end

function module.Get(name)
	repeat
		wait()
	until module[name] ~= nil
	return module[name]
end

if IsServer == false then
	local function ChildHandler(child)
		local ChildName = child.Name
		if child:IsA("RemoteEvent") then
			module[ChildName] = NewNetworkEvent(child)
		elseif child:IsA("RemoteFunction") then
			module[ChildName] = NewNetworkFunction(child)
		end
	end

	for i, child in ipairs(Remotes:GetChildren()) do
		ChildHandler(child)
	end
	Remotes.ChildAdded:Connect(function(child)
		ChildHandler(child)
	end)
end

return module