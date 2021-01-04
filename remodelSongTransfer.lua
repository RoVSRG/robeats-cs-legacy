local game = remodel.readModelFile("models/Songs.rbxm")

-- If the directory does not exist yet, we'll create it.
remodel.createDirAll("models")

local Models = game.ReplicatedStorage.Models

for _, model in ipairs(Models:GetChildren()) do
	-- Save out each child as an rbxmx model
	remodel.writeModelFile(model, "models/" .. model.Name .. ".rbxmx")
end