require 'custom.keybindings'

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
