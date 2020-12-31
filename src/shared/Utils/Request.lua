local Promise = require(game.ReplicatedStorage.Promise)
local HTTP_SERVICE = game:GetService("HttpService")

local Request = {}

function Request:new()
	local self = {
		uri = "",
		headers = nil,
		method = "GET",
		body = nil
	}
	
	function self:setUri(uri)
		self.uri = uri
	end
	
	function self:setMethod(method)
		assert(type(method) == "string", "You must pass a valid string for the method!")
		self.method = method		
	end
	
	function self:setHeaders(headers)
		self.headers = headers
	end
	
	function self:exec()
		local response = HTTP_SERVICE:RequestAsync({
			Url = self.uri,
			Method = self.method,
			Headers = self.headers,
			Body = self.body
		})
		
		local ret = {
			body = response.Body,
			statusCode = response.StatusCode,
			statusMessage = response.StatusMessage,
			headers = response.Headers,
			success = response.Success,
		}
		pcall(function()
			ret.decodedBody = HTTP_SERVICE:JSONDecode(response.Body)
		end)
		
		return ret
	end
	
	return self
end

return Request
