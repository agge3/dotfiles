--
-- MakeConcrete: A Lua script for NeoVim that removes "virtual" and "= 0" from
-- pure virtual C++ functions to convert them into concrete implementations.
--
-- AUTHOR: OpenAI's ChatGPT
-- MODIFIED: agge3 
-- DATE: 2024.28.10
--

function MakeConcrete()
    -- Get the current buffer
    local bufnr = vim.api.nvim_get_current_buf()
    -- Get all lines in the buffer
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local modified_lines = {}

    -- Track if we’re inside a multiline virtual function declaration
    local is_in_multiline_function = false
    local multiline_start_idx = nil
    local multiline_function = ""

    for i, line in ipairs(lines) do
        -- Keep the original line for leading whitespace
        local leading_whitespace = line:match("^(%s*)") -- Capture leading whitespace
        local trimmed_line = line:match("^%s*(.-)%s*$") -- Remove leading and trailing whitespace

        -- Check if we're inside a multiline declaration that started with `virtual`
        if is_in_multiline_function then
            multiline_function = multiline_function .. " " .. trimmed_line
            if trimmed_line:match("=%s*0%s*;%s*$") then
                -- We've reached the end of the multiline declaration, process it
                local concrete_function = multiline_function
                    :gsub("^%s*virtual%s+", "")         -- Remove 'virtual'
                    :gsub("=%s*0%s*;", ";")             -- Remove '= 0;' but keep space for leading whitespace
                -- Remove any space before the semicolon at the end
                concrete_function = concrete_function:gsub("%s*;[%s]*$", ";")
                table.insert(modified_lines, { multiline_start_idx, leading_whitespace .. concrete_function })
                is_in_multiline_function = false
                multiline_function = ""
            end
        elseif trimmed_line:match("^%s*virtual%s+[%w_:]+%s+[%w_:]+%s*%b()%s*[%w%s]*=%s*0%s*;") then
            -- Single-line virtual function: remove 'virtual' and '= 0;'
            local concrete_line = trimmed_line
                :gsub("^%s*virtual%s+", "")           -- Remove 'virtual'
                :gsub("=%s*0%s*;", ";")               -- Remove '= 0;'
            -- Remove any space before the semicolon
            concrete_line = concrete_line:gsub("%s*;[%s]*$", ";")
            table.insert(modified_lines, { i, leading_whitespace .. concrete_line })
        elseif trimmed_line:match("^%s*virtual%s+[%w_:]+%s+[%w_:]+%s*%b()%s*[%w%s]*") then
            -- Multiline virtual function: start collecting
            is_in_multiline_function = true
            multiline_start_idx = i
            multiline_function = trimmed_line
        end
    end

    -- Apply modifications in the buffer
    for _, mod in ipairs(modified_lines) do
        local idx, modified_line = mod[1], mod[2]
        vim.api.nvim_buf_set_lines(bufnr, idx - 1, idx, false, { modified_line })
    end
end

-- Create a command to call MakeConcrete
vim.api.nvim_create_user_command('MakeConcrete', MakeConcrete, {})
