local function auto_dark_mode(interval)
	local function check_system_mode()
		local system = vim.loop.os_uname().sysname
		local cmd = nil
		if system == "Darwin" then
			cmd = { "defaults", "read", "-g", "AppleInterfaceStyle" }
		end

		if cmd == nil then
			return
		end

		-- Use sync job to ensure this runs before other configs
		local output = vim.fn.system(cmd)
		local is_dark = output and string.match(output, "Dark")
		if is_dark then
			vim.o.background = "dark"
		else
			vim.o.background = "light"
		end
	end

	check_system_mode()

	-- Set up timer for subsequent checks if interval is provided
	if interval then
		local timer_id = vim.fn.timer_start(interval, function()
			check_system_mode()
		end, { ["repeat"] = -1 })
		-- vim.fn.timer_stop(timer_id)
	end
end

auto_dark_mode()

require("config.options")
require("config.keymaps")
require("config.autocmd")
require("config.lazy")
