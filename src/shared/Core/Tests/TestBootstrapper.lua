local ReplicatedStorage = game:GetService("ReplicatedStorage")

local TestEZ = require(ReplicatedStorage.Libraries.TestEZ)

local TestBootstrapper = {}

function TestBootstrapper:run(testFolders)
    local results = TestEZ.TestBootstrap:run(testFolders, TestEZ.Reporters.TextReporter)

    if #results.errors > 0 or results.failureCount > 0 then
        warn("Tests failed")
    end
end

return TestBootstrapper