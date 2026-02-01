# AGENTS.md

This file contains guidelines and commands for agentic coding tools working in this dotfiles repository.

## Repository Overview

This is a personal dotfiles repository containing configuration files for various development tools:
- Vim configuration (`vimrc`, `vim/`)
- Neovim configuration (`nvim/init.lua`)
- Tmux configuration (`tmux.conf`)
- GDB configuration (`gdbinit`)
- Docker development environment (`dockerize/`)
- Setup automation (`set_up.sh`)

## Build/Setup Commands

### Initial Setup
```bash
# Run the complete setup script (installs and configures everything)
./set_up.sh
```

### Docker Environment
```bash
# Build and run the development container
cd dockerize/
./run.sh
```

### Testing Commands
This is a configuration repository, so testing primarily involves:
1. Syntax checking configuration files
2. Validating that setup scripts run without errors
3. Testing that symlinks are created correctly

To validate individual configurations:
```bash
# Check vim configuration syntax
vim -c "vimrc_syntax_check" -c "q"

# Check tmux configuration syntax
tmux source-file ~/dotfiles/tmux.conf

# Check neovim configuration
nvim --headless -c "lua print('Config loaded')" -c "q"
```

### Linting and Formatting

#### Vim Script
```bash
# Use vint for vimscript linting (if available)
vint vimrc vim/**/*.vim
```

#### Lua (Neovim Config)
```bash
# Use luacheck for Lua linting
luacheck nvim/

# Format Lua code
lua-format -i nvim/**/*.lua
```

#### Shell Scripts
```bash
# Shellcheck for bash scripts
shellcheck set_up.sh dockerize/run.sh
```

## Code Style Guidelines

### General Principles
- Keep configurations minimal and focused
- Use consistent 2-space indentation across all files
- Prefer spaces over tabs
- Use UTF-8 encoding for all files
- End files with a newline character

### Vim Configuration (vimrc)
- Use `set option=value` format
- Group related settings with comments
- Use descriptive keybindings with leader key
- Follow the existing plugin structure with Vundle
- Keybinding conventions:
  - `<leader>` for custom commands
  - `<C-*>` for control combinations
  - Function descriptive names after leader

### Lua Configuration (nvim/init.lua)
- Use vim.opt API over set commands
- Group related configuration with comment headers
- Use vim.keymap.set for keybindings
- Follow the established plugin loading pattern with vim.pack.add
- Use descriptive function and variable names in snake_case
- Maintain existing structure:
  ```lua
  -- INFO: section header
  vim.opt.option = value
  ```

### Shell Scripts
- Use `#!/bin/bash` shebang
- Set `set -euxo pipefail` for strict error handling
- Use double quotes for variable expansion
- Prefer functions over repeated code blocks
- Use descriptive variable names in lowercase

### Tmux Configuration
- Use `set-option` and `set-window-option` explicitly
- Group related keybindings
- Use vi-style navigation for consistency with vim/neovim
- Prefix key is `C-Space` (customized from default `C-b`)

### File Organization
- Keep configuration files at the root level
- Use subdirectories for related files (vim/, nvim/, dockerize/)
- Maintain the symlink structure from setup script
- Preserve existing file hierarchy when making changes

## Import and Plugin Guidelines

### Vim Plugins
- Use Vundle as the package manager
- Maintain the existing plugin list structure
- Add new plugins in alphabetical order within their category
- Follow the naming convention: `Plugin 'author/plugin-name'`

### Neovim Plugins
- Use vim.pack (builtin package manager)
- Add plugins using the pattern: `vim.pack.add({ "url" }, { confirm = false })`
- Use dependency declarations when required
- Configure plugins immediately after loading with setup() calls

### Language Specific Settings

#### Bash/Shell
- Use `#!/bin/bash` for bash scripts
- Prefer `[[ ]]` over `[[ ` for conditional expressions
- Use local variables in functions

#### Lua
- Use `local` for variable declarations
- Prefer function literals over separate declarations when possible
- Use pcall for error handling when loading optional modules

## Naming Conventions

### Files
- Use lowercase with extensions (.vim, .lua, .sh, .conf)
- Keep names descriptive but concise
- Use underscores for multi-word names

### Variables
- Bash: `snake_case` (lowercase with underscores)
- Lua: `snake_case` for local variables, `PascalCase` for modules
- Vim: use built-in option names where possible

### Functions
- Bash: `snake_case`
- Lua: `snake_case`
- Keybindings: descriptive with `<leader>` prefix

## Error Handling

### Shell Scripts
- Use `set -euxo pipefail` for strict error handling
- Check command exit codes explicitly where needed
- Use proper error messages with context

### Lua Configuration
- Use `pcall` for optional module loading
- Guard plugin configurations with existence checks
- Provide informative error messages via vim.notify

### Vim Configuration
- Use `try`/`catch` where appropriate in vim9script
- Use `silent!` for commands that might fail harmlessly
- Check for plugin availability before configuring

## Making Changes

1. Test configuration changes in a separate environment first
2. Validate syntax before committing
3. Update relevant setup scripts if adding new files
4. Test the complete setup process after major changes
5. Ensure changes don't break existing keybindings or workflows

## Key Configuration Notes

- Default editor is set to neovim via environment variables
- Tmux prefix is `C-Space` (customized)
- Use ripgrep for fast file searching
- Clipboard integration requires xclip/xsel
- Neovim uses Treesitter for syntax highlighting
- LSP servers are managed via Mason
- All editors use 2-space indentation with soft tabs