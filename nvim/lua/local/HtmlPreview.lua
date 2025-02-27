--
-- NAME: HtmlPreview
--
-- Display a HTML preview of the current directory using Python, with live
-- reloading.
--
-- AUTHOR: agge3
-- DATE: 2024.16.2
--

function HtmlPreview()
	local server_pid = nil
	local fh = vim.fn.expand('%:p')
	local dir = vim.fn.expand('%:p:h')
	local name = vim.fn.expand('%:t')

	if vim.fn.executable('python3') == 0 then
		vim.notify('Python3 is required but not found!', vim.log.levels.ERROR)
		return -1
	end

	-- Start Python HTML server.
	if server_pid == nil then
		server_pid = vim.fn.jobstart({'python3', '-m', 'http.server'}, {cwd=dir})

		if server_pid > 0 then
			vim.notify('Started HTTP server in ' .. dir, vim.log.levels.INFO)
			vim.fn.system({ 'xdg-open', 'http://localhost:8000/' .. name })

		else
			-- xxx get stdout from python cmd
			vim.notify('Failed to start HTTP server.', vim.log.levels.ERROR)
			server_pid = nil
			return -1
		end
	end

	local watcher_cmd
	-- Linux
	if vim.fn.executable('inotifywait') == 1 then
		watcher_cmd = {'inotifywait', '-m', '-e', 'close_write', fh}
	-- macOS
	elseif vim.fn.executable('fswatch') == 1 then
		watcher_cmd = {'fswatch', fh}
	else
		vim.notify('inotifywait (Linux) or fswatch (macOS) not found. '
			.. 'Unable to auto-refresh.')
		return -1
	end

	while true do
	vim.fn.jobstart(watcher_cmd, {
		on_stdout = function()
			vim.notify('Detected changes in ' .. fh .. '. Reloading...',
				vim.log.levels.INFO)
			vim.fn.system({'xdg-open', 'http://localhost:8000/' .. name},
				{detach = true})
		end,
		stdout_buffered = true
	})
	end

	vim.notify('Watching ' .. fh .. ' for changes...', vim.log.levels.INFO)
end

-- Create a command to call HtmlPreview
vim.api.nvim_create_user_command('HtmlPreview', HtmlPreview, {})
