local Roact = require(gaame.ReplicatedStorage.Libraries.Roact)

local Note2D = require(script.Parent.NoteTypes["2D"].Note)
local Note3D = require(script.Parent.NoteTypes["3D"].Note)
local Hold2D = require(script.Parent.NoteTypes["2D"].Hold)
local Hold3D = require(script.Parent.NoteTypes["3D"].Hold)

local HitObject = Roact.Component:extend("HitObject")

function HitObject:render()
    
end

return HitObject
