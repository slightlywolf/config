local scheme_whitelist = {
	"duskfox"
}

local scheme_blacklist = {
	"bold-light",
	"contrasty"
}

local other_color_filters = {
	function(colorscheme_name) -- contrast
		if string.find(colorscheme_name, "contrast") then
			return true
		end

		return false
	end
}

-- ##############################################################################

function C_filter_copy_array(arr, func)
	local ret_schemes = {}

	for _, scheme_name in ipairs(arr) do
		if func(scheme_name) then
			ret_schemes[#ret_schemes+1] = scheme_name
		end
	end

	return ret_schemes
end

local function get_key_for_value( t, value )
  for k,v in pairs(t) do
    if v==value then return k end
  end
  return nil
end

function C_get_random_colorscheme(filter_func)
	-- every colorscheme should be valid
	math.randomseed(os.time())
	local colors_to_use = C_get_random_colorscheme_list(filter_func)

	local rand_scheme = colors_to_use[math.ceil(#colors_to_use * math.random())]

    if rand_scheme == vim.g.colors_name and #colors_to_use > 1 then
		-- if there is more than one color than

		local current_scheme = vim.g.colors_name
		local key_of_current_scheme = get_key_for_value(colors_to_use, current_scheme)

		if colors_to_use[key_of_current_scheme] then -- if in the list
			colors_to_use.remove(key_of_current_scheme)
		end

		-- pick a different scheme
		rand_scheme = colors_to_use[math.ceil(#colors_to_use * math.random())]
	end

	return rand_scheme
end

-- gets the list of colorschemes to pick from
function C_get_random_colorscheme_list(filter_func)
	local func_to_use = filter_func or C_all_filter

	local my_colors = vim.fn.getcompletion("","color")
	local colors_to_use = C_filter_copy_array(my_colors, func_to_use)

	return colors_to_use
end


function C_print_colorscheme_list(filter_func)
	local schemes = C_get_random_colorscheme_list(filter_func)
	vim.print(schemes)
end

function C_set_random_colorscheme(filter_func)
	local color = C_get_random_colorscheme(filter_func)
	vim.print(color)

	vim.cmd.colorscheme(color)
end

-- combines a large number of filters into one
function C_all_filter(colorscheme_name)
	--whitelist acts before other filters

	if ColorIsWhitelisted(colorscheme_name) then
		return true
	end

	if ColorIsBlackListed(colorscheme_name) then
		return false
	end

	for _, colorfilter in ipairs(other_color_filters) do
		if not colorfilter(colorscheme_name) then
			return false
		end
	end

	return true
end

function ColorIsBlackListed(colorscheme_name)
	for _, v in ipairs(scheme_blacklist) do
		if colorscheme_name == v then
			return true
		end
	end

	return false
end

function ColorIsWhitelisted(colorscheme_name)
	for _, v in ipairs(scheme_whitelist) do
		if colorscheme_name == v then
			return true
		end
	end

	return false
end



