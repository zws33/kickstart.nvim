return {
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'

      -- Define the markdownlint linter here
      lint.linters.markdownlint = {
        name = 'markdownlint',
        cmd = 'markdownlint-cli2',
        args = {
          '--config',
          '.markdownlint.jsonc',
          '--stdin',
          '--',
          '$FILENAME',
        },
        parser = require('lint.parser').from_json,
      }

      lint.linters_by_ft = {
        markdown = { 'markdownlint' },
      }

      -- Enable linting on save
      vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
