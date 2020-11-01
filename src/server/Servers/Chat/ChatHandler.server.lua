local Players = game:GetService("Players")
local httpService = game:GetService("HttpService")
local messagingService = game:GetService("MessagingService")
local TextService = game:GetService("TextService")

local deb = true
local name

game.Players.PlayerAdded:Connect(function(p)
	name = p.Name
end)

local function getTextObject(message, fromPlayerId)
	local textObject
	local success, errorMessage = pcall(function()
		textObject = TextService:FilterStringAsync(message, fromPlayerId)
	end)
	if success then
		return textObject
	end
	return false
end
 
local function getFilteredMessage(textObject, toPlayerId)
	local filteredMessage
	local success, errorMessage = pcall(function()
		filteredMessage = textObject:GetChatForUserAsync(toPlayerId)
	end)
	if success then
		return filteredMessage
	end
	return false
end

function callbackFunction(serviceData)
	print(serviceData)
	local decodedData = httpService:JSONDecode(serviceData.Data)
	print(decodedData.sender)
	print(decodedData.message)
	print(decodedData.channel)
	game.ReplicatedStorage.FilterText:FireAllClients(decodedData.sender, decodedData.message, decodedData.channel)
end

game.ReplicatedStorage.FilterText.OnServerEvent:Connect(function(plr,msg,channel)
	if msg ~= "" then
		local messageObject = getTextObject(msg, plr.UserId)
		if messageObject then
			local filteredMessage = getFilteredMessage(messageObject,plr.UserId)
			local messageData = {
				sender = plr.Name,
				message = filteredMessage,
				channel = channel,
			}
			local encoded = httpService:JSONEncode(messageData)
			messagingService:PublishAsync("chatservice", encoded)
		end
	end
end)

messagingService:SubscribeAsync("chatservice", callbackFunction)