local telescope = require('telescope')
local telescopeConfig = require('telescope.config')

-- Clone the default Telescope configuration
local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

-- Show hidden/dot files
table.insert(vimgrep_arguments, "--hidden")
-- Ignore .git directory
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!**/.git/*")

-- Setup

telescope.setup {
    defaults = {
        -- `hidden = true` is not supported in text grep commands
        vimgrep_arguments = vimgrep_arguments
    },
    pickers = {
        find_files = {
            -- `hidden = true` will show .git folder, so we pass ripgrep args directly
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" }
        }
    }
}

local builtin = require('telescope.builtin')

-- Keymaps

vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>pg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
