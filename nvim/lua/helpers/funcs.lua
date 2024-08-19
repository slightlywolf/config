-- blink-light
-- Base2Tone-Morning-light
-- for some reason the backgrounds behind tabs become a different color
-- with some schemes, the Base2Tone schemes do not have this issue though

vim.o.background = 'dark'
vim.o.termguicolors = true

local scheme_whitelist = {
	--"fox",
	"Base2Tone",
	"contrast",
	"Contrast",
	-- "light",
	-- "monokai-soda",
	-- "duskfox",

}

local scheme_blacklist = {
	-- light themes specifically
	
	-- "laederon",
	-- "nicotine",
	-- "pleasant",
	--
	--
	"light",
	"Light",
	-- "flight",
	
	-- other themes
	-- "Base2Tone-Lake-Dark",
	-- "Base2Tone-Sea-Dark",
	-- "Base2Tone-Meadow-Dark",
	-- "Base2Tone-Lake-dark",
	-- "Base2Tone-Sea-dark",
	-- "Base2Tone-Meadow-dark",
	-- "Base2Tone-Lakedark",
	-- "Base2Tone-Seadark",
	-- "Base2Tone-Meadowdark",
	-- "Base2Tone-LakeDark",
	-- "Base2Tone-SeaDark",
	-- "Base2Tone-MeadowDark",
	-- "bold-light",
	-- "contrasty",
}


local other_color_filters = {
	function(colorscheme_name) -- contrast
		if string.find(colorscheme_name, "contrast") then
			return true
		end

		return false
	end,
}

function C_filter_copy_array(arr, func)
	local ret_schemes = {}

	for _, scheme_name in ipairs(arr) do
		if func(scheme_name) then
			ret_schemes[#ret_schemes + 1] = scheme_name
		end
	end

	return ret_schemes
end

local function get_key_for_value(t, value)
	for k, v in pairs(t) do
		if v == value then return k end
	end
	return nil
end

function C_get_random_colorscheme(filter_func)
	-- every colorscheme should be valid
	math.randomseed(os.time())
	local colors_to_use = C_get_random_colorscheme_list(filter_func)

	local rand_scheme = colors_to_use[math.ceil(#colors_to_use * math.random())]

	local tries = 0
	while (rand_scheme == vim.g.colors_name and #colors_to_use > 1 and tries < 10)  do
		--
		-- if there is more than one color than

		-- local current_scheme = vim.g.colors_name
		-- local key_of_current_scheme = get_key_for_value(colors_to_use, current_scheme)
		--
		-- if colors_to_use[key_of_current_scheme] then -- if in the list
		-- 	table.remove(colors_to_use, key_of_current_scheme)
		-- end
		--
		-- -- pick a different scheme
		rand_scheme = colors_to_use[math.ceil(#colors_to_use * math.random())]
		tries = tries + 1
	end

	return rand_scheme
end

-- gets the list of colorschemes to pick from
function C_get_random_colorscheme_list(filter_func)
	local func_to_use = filter_func or C_all_filter

	local my_colors = vim.fn.getcompletion("", "color")
	-- local colors_to_use = C_filter_copy_array(my_colors, func_to_use)
	local colors_to_use = my_colors

	return colors_to_use
end

function C_print_colorscheme_list(filter_func)
	local schemes = C_get_random_colorscheme_list(filter_func)
	vim.print(schemes)
end

function SetRandomColorScheme(filter_func)
	C_set_random_colorscheme(filter_func)
end

function C_set_random_colorscheme(filter_func)
	local color = C_get_random_colorscheme(filter_func)

	if pcall(
			function()
				vim.cmd.colorscheme(color)
			end
		) then
		-- do nothing
	else
		SetRandomColorScheme(filter_func)
	end
end

-- combines a large number of filters into one
function C_all_filter(colorscheme_name)
	--whitelist acts before other filters
	if ColorIsBlackListed(colorscheme_name) then
		return false
	end

	if ColorIsWhitelisted(colorscheme_name) then
		return true
	end


	for _, colorfilter in ipairs(other_color_filters) do
		if not colorfilter(colorscheme_name) then
			return false
		end
	end

	-- change this to true for all schemes but those blacklisted
	-- otherwise false to only have the whitelisted schemes
	local AllExceptBlackListed = true
	local OnlyWhitelisted = false
	return AllExceptBlackListed
end

function ColorIsBlackListed(colorscheme_name)
	for _, v in ipairs(scheme_blacklist) do
		if string.find(colorscheme_name, v) or colorscheme_name == v then
			return true
		end
	end

	return false
end

function ColorIsWhitelisted(colorscheme_name)
	for _, v in ipairs(scheme_whitelist) do
		if string.find(colorscheme_name, v) or colorscheme_name == v then
			return true
		end
	end

	return false
end
