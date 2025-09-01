-- [[ Basic Autocommands ]]
--  See :help lua-guide-autocommands

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
-- Define a Lua function to clear all registers
local function clear_registers()
  local regs = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-="*+'
  for i = 1, #regs do
    local reg = regs:sub(i, i)
    vim.fn.setreg(reg, '')
  end
end

-- Create a Neovim command that calls this function
vim.api.nvim_create_user_command('ClearRegisters', clear_registers, {})
