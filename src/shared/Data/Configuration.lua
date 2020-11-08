local DatastoreSerializer = require(game.ReplicatedStorage.Libraries.Serialization.Datastore)
local Network = require(game.ReplicatedStorage.Libraries.Network)
local SPUtil = require(game.ReplicatedStorage.Shared.Utils.SPUtil)

--[[
Use this class to access player settings. Example:
local Configuration = require(game.ReplicatedStorage.Shared.Data.Configuration)
print(Configuration.Preferences.NoteSpeed) --To access player NoteSpeed
]]--

local Configuration = {
		Preferences = SPUtil:copy_table(require(game.ReplicatedStorage.Shared.Data.DefaultSettings));
		SessionSettings = SPUtil:copy_table(require(game.ReplicatedStorage.Shared.Data.SessionSettings));
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