local DatastoreSerializer = require(game.ReplicatedStorage.Serialization.Datastore)
local Network = require(game.ReplicatedStorage.Network)
local SPUtil = require(game.ReplicatedStorage.Shared.SPUtil)

--[[
Use this class to access player settings. Example:
local Configuration = require(game.ReplicatedStorage.Configuration)
print(Configuration.Preferences.NoteSpeed) --To access player NoteSpeed
]]--

local Configuration = {
		Preferences = SPUtil:copy_table(require(game.ReplicatedStorage.DefaultSettings));
		SessionSettings = SPUtil:copy_table(require(game.ReplicatedStorage.SessionSettings));
}

function Configuration:modify(key, value)
		self.Preferences[key] = value
end

function Configuration:load_from_save()
	local suc, err = pcall(function()
		local settings = Network.Get("RetrieveSettings"):Invoke()
		local deserialized = DatastoreSerializer:deserialize_table(settings or {})
		if settings ~= nil then
			for i, v in pairs(deserialized) do
				self.Preferences[i] = v
			end
		end
	end)
	
	if not suc then
		warn(err)
	end
end

return Configuration