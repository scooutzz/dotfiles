# AGENTS.md - Neovim Configuration

## Overview
This is a Neovim configuration written in Lua using the Lazy.nvim plugin manager.

## Commands
- **Testing**: This is a config-only repository with no automated tests
- **Reload config**: `:source init.lua` or restart Neovim
- **Plugin management**: `:Lazy` (sync, install, update plugins)
- **LSP restart**: `<leader>zig` or `:LspRestart`

## Code Style
- **Indentation**: 2 spaces (no tabs), configured in `lua/config/options.lua:11-14`
- **File structure**: Main config in `init.lua`, modules in `lua/config/`, plugins in `lua/plugins/`
- **Plugin format**: Return table with plugin specs (see `lua/plugins/*.lua`)
- **Comments**: Use `--` for single line, avoid excessive commenting
- **Naming**: snake_case for files/variables, descriptive function names
- **Keymaps**: Use `vim.keymap.set()`, leader key is space, descriptive descriptions

## Conventions
- **Imports**: Use `require()` at top of files, no relative paths from lua/
- **Plugin configs**: Each plugin in separate file returning table
- **LSP setup**: All language servers configured in `lua/plugins/lsp.lua`
- **Autocommands**: Use `vim.api.nvim_create_autocmd()` with descriptive groups
- **Error handling**: LSP handlers silenced for notifications (line 50-52 in lsp.lua)
- **Formatting**: Auto-format on save for supported filetypes (line 144-149 in lsp.lua)