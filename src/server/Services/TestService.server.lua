local Knit = require(game:GetService("ReplicatedStorage").Knit)

local TestService = Knit.CreateService {
    Name = "TestService";
}

function TestService.Client:GET_TEXT()
    return "HELLO YOU FUCKEN LOSER"
end
