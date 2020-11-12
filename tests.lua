local ReplicatedStorage = game:GetService("ReplicatedStorage")

local TestEZ = require(ReplicatedStorage.Libraries.TestEZ)

local results = TestEZ.TestBootstrap:run({
    game.ReplicatedStorage.Shared.Components
}, TestEZ.Reporters.TextReporter)

if #results.errors > 0 or results.failureCount > 0 then
    error("Tests failed")
end