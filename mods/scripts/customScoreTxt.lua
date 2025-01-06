-- Script by Raltyro
-- Originally Made for 900n1 Mod :D
-- 12/20/2022

-- Score Formats - %score, %misses, %rating, %percent, %health
noRatingScoreFormat = 'Points: %score // Mistakes: %misses // Progress:'
scoreFormat = 'Points: %score // Mistakes: %misses // Progress: %rating - %percent%'
percentDecimals = 2

-- Ratings - {percent - 0 to 100, ratingname} (orders doesn't matter)
noRatingName = 'Lets Start This.'
ratingNames = {
	{100, "Perfect."},
	{90, "Very Well Done."},
	{80, "Heh Great."},
	{70, "Still Good."},
	{69, "Kind of Nice."},
	{60, "Huh."},
	{50, "Very Bad.."},
	{40, "..."},
	{20, "Really?"},
	{0, "Fatal."}
}

local errors
function updateRating()
	luaDebugMode = true
	local percent, rating = tonumber(getProperty("ratingPercent")) * 100, noRatingName
	local health = math.max(0, math.min(getHealth() * 50, 100))
	local showAcc = hits ~= 0

	if showAcc then
		local v
		for i = #ratingNames, 1, -1 do
			v = ratingNames[i]
			if (percent >= v[1]) then
				rating = v[2]
			else
				break
			end
		end
	end

	local decimals = 10 ^ percentDecimals
	percent = math.floor(percent * decimals) / decimals

	local str = showAcc and scoreFormat or noRatingScoreFormat
	str = str:gsub('%%score', score)
	str = str:gsub('%%misses', misses)
	str = str:gsub('%%rating', rating)
	str = str:gsub('%%percent', percent)
	str = str:gsub('%%health', health)

	setTextString("scoreTxt", str)
end



-- backwards compatibility
function onUpdateScore()
	onUpdate = nil; onUpdateScore = updateRating
	return updateRating()
end

onUpdate = updateRating