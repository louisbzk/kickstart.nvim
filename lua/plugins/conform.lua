return { -- Autoformat
  'stevearc/conform.nvim',
  opts = {
    notify_on_error = false,
    format_on_save = {
      timeout_ms = 800,
      lsp_fallback = true,
    },
    formatters_by_ft = {
      lua = { 'stylua' },
      c = { 'clang-format' },
      cpp = { 'clang-format' },
      python = { 'ruff_format' },
      cmake = { 'cmake_format' },
      json = { 'dprint' },
      -- Conform can also run multiple formatters sequentially
      -- python = { "isort", "black" },
      --
      -- You can use a sub-list to tell conform to run *until* a formatter
      -- is found.
      -- javascript = { { "prettierd", "prettier" } },
    },
    formatters = {
      dprint = { -- make dprint use the default dprint config if one is not present in the project
        prepend_args = function(self, ctx)
          local local_config = vim.fs.find({ 'dprint.json', '.dprint.json' }, { path = ctx.dirname, upward = true })[1]
          if local_config then
            return {}
          end
          return {
            '--config',
            vim.fn.expand '~/.config/nvim/files/dprint.json',
          }
        end,
      },
    },
  },
}
