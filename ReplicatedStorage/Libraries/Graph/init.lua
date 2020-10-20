local libs = {}

for i, v in pairs(script:GetChildren()) do
    libs[v.Name] = require(v)
end

return libs