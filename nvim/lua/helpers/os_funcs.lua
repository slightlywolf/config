function IsLinux()
	local os = vim.loop.os_uname().sysname

	if os == "Linux" then
		return true
	end

	return false
end
