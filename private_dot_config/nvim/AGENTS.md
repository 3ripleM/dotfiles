# AGENTS.md

## Project Overview
This project is a Neovim configuration that makes use of LazyVim, a modular and customization-friendly framework. It includes a variety of plugins designed to enhance developer productivity and user experience.

## Key Directories and Files

- **init.lua**: Entry point for the Neovim configuration.
- **lua/config/autocmds.lua**: Defines custom autocommands for specific events.
- **lua/config/keymaps.lua**: Contains key mappings for various functionalities.
- **lua/config/lazy.lua**: Responsible for managing the LazyVim setup and plugin structure.
- **lua/config/options.lua**: Provides additional Vim options.
- **lua/plugins/**: Contains plugin configurations. Each plugin often has a dedicated file.
  - **core.lua**: Manages settings related to LazyVim itself.
  - Specific plugins like `telescope`, `treesitter`, and `buffer-line` enhance navigation, syntax highlighting, and user interface.

## Contribution Guidelines

1. **Understanding the Structure**: Familiarize yourself with the `lua/config/` directory for core configurations and `lua/plugins/` for plugin-specific tweaks.
2. **Adding Plugins**: To add new plugins, edit `lua/config/lazy.lua` to include the plugin specification. You can also create a new file in `lua/plugins/` for detailed configuration.
3. **Testing Changes**: Run Neovim and ensure that no errors or plugin misbehaviors occur after making changes. Test the changes with relevant file types or functionality, especially if modifying plugins.
4. **Code Style**: Maintain consistency with the existing Lua code style. Use 2 spaces for indentation and follow the conventions observed in current files.

## Key Plugins and Their Functions

- **Telescope**: Advanced file searching and navigation.
- **Treesitter**: Syntax highlighting support for multiple programming languages.
- **Buffer-line**: Handles tabs and buffers in the UI.
- **Lazy.nvim**: Manages lazy-loading of plugins and ensures a fast startup.
- **Various Utility Plugins**: Includes `harpoon`, `neotree`, and others to enhance specific workflows.

## Additional Notes

- Default LazyVim options and autocommands are already integrated. Check their respective upstream documentation for advanced usage.
- Key mappings follow standard conventions, but some defaults have been removed or altered for better compatibility.

