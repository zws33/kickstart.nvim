-- TypeScript/JavaScript enhanced tooling
return {
  'pmizio/typescript-tools.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
  ft = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
  opts = {
    settings = {
      -- Spawn separate tsserver for each project for better performance
      separate_diagnostic_server = true,
      -- Expose as "rename file" command
      expose_as_code_action = { 'fix_all', 'add_missing_imports', 'remove_unused' },
      tsserver_file_preferences = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
  },
  keys = {
    { '<leader>to', '<cmd>TSToolsOrganizeImports<cr>', desc = '[T]ypeScript [O]rganize imports' },
    { '<leader>ts', '<cmd>TSToolsSortImports<cr>', desc = '[T]ypeScript [S]ort imports' },
    { '<leader>tu', '<cmd>TSToolsRemoveUnused<cr>', desc = '[T]ypeScript remove [U]nused' },
    { '<leader>ta', '<cmd>TSToolsAddMissingImports<cr>', desc = '[T]ypeScript [A]dd missing imports' },
    { '<leader>tf', '<cmd>TSToolsFixAll<cr>', desc = '[T]ypeScript [F]ix all' },
    { '<leader>tg', '<cmd>TSToolsGoToSourceDefinition<cr>', desc = '[T]ypeScript [G]o to source' },
    { '<leader>tr', '<cmd>TSToolsRenameFile<cr>', desc = '[T]ypeScript [R]ename file' },
  },
}
