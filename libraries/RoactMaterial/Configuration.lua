local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Configuration = {
	Promise = require(ReplicatedStorage.Libraries.Promise),
	Roact = require(ReplicatedStorage.Libraries.Roact),
	RoactAnimate = require(ReplicatedStorage.Libraries.RoactAnimate),
	t = require(ReplicatedStorage.Libraries.t),
	Warnings = {},
}

return Configuration