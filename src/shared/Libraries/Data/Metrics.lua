local Metrics = {}

function Metrics.calculate_rating(rate, acc, difficulty)
	local ratemult = 1
	if rate then
		if rate >= 1 then
			ratemult = 1 + (rate-1) * 0.6
		else
			ratemult = 1 + (rate-1) * 2
		end
	end
	return ratemult * ((acc/97)^4) * difficulty
end

return Metrics
