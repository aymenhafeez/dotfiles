local function hex_to_rgb(hex)
	local r = tonumber(hex:sub(2, 3), 16)
	local g = tonumber(hex:sub(4, 5), 16)
	local b = tonumber(hex:sub(6, 7), 16)

	return r, g, b
end

local function alter(col, percent)
	return math.floor(col * (100 + percent) / 100)
end

local function modify_colour(colour, percent)
	local r, g, b = hex_to_rgb(colour)

	r, g, b = alter(r, percent), alter(g, percent), alter(b, percent)
	r, g, b = math.min(r, 255), math.min(g, 255), math.min(b, 255)

	return ("#%02x%02x%02x"):format(r, g, b)
end

print(modify_colour("#282c34", 20))
