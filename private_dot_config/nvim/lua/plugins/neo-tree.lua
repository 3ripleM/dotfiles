return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function()
      require("neo-tree").setup({
        disable_netrw = true,
        hijack_netrw = true,
        open_on_setup = false,
        auto_close = false,
        update_to_buf_dir = {
          enable = true,
          auto_open = true,
        },
        window = {
          position = "right",
          mappings = {
            ["u"] = "toggle_auto_expand_width",
            ["e"] = "",
            ["Y"] = function(state)
              local node = state.tree:get_node()
              if not node or not node.id then
                vim.notify("No node selected.", vim.log.levels.WARN)
                return
              end

              if vim.fn.has("clipboard") == 0 then
                vim.notify("System clipboard is not available.", vim.log.levels.ERROR)
                return
              end

              local filepath = node:get_id()
              local filename = node.name
              local modify = vim.fn.fnamemodify

              local choices = {
                { label = "Filename", value = filename },
                { label = "Filename without extension", value = modify(filename, ":r") },
                { label = "Absolute path", value = filepath },
                { label = "Path relative to CWD", value = modify(filepath, ":.") },
                { label = "Path relative to HOME", value = modify(filepath, ":~") },
                { label = "Extension of the filename", value = modify(filename, ":e") },
              }

              -- THE CHANGE IS ON THIS LINE:
              -- Instead of vim.ui.select, we call the snacks picker directly.
              require("snacks").picker.select(choices, {
                prompt = "Choose to copy to clipboard:",
                format_item = function(item)
                  return string.format("%-30s %s", item.label, item.value)
                end,
              }, function(choice)
                if not choice then
                  vim.notify("Copy cancelled.", vim.log.levels.INFO)
                  return
                end

                local value_to_copy = choice.value

                vim.fn.setreg("+", value_to_copy)
                vim.notify("Copied to clipboard: " .. value_to_copy)
              end)
            end,
          },
        },
        filesystem = {
          follow_current_file = {
            enabled = true, -- This will find and focus the file in the active buffer every time
            --               -- the current file is changed while the tree is open.
            leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
          },
        },
      })
    end,
  },
}
