return {
  'feline-nvim/feline.nvim',
  config = function(_, opts)
    local feline = require('feline')
    local git = require('feline.providers.git') -- explicitly load Git providers

    -- Tokyo Night-inspired colors
    local colors = {
      bg       = "#1a1b26",
      fg       = "#c0caf5",
      black    = "#414868",
      white    = "#a9b1d6",
      red      = "#f7768e",
      green    = "#9ece6a",
      yellow   = "#e0af68",
      blue     = "#7aa2f7",
      magenta  = "#bb9af7",
      cyan     = "#7dcfff",
    }

    -- LEFT SECTION COMPONENTS

    local vi_mode = {
      provider = function()
        local mode_map = {
          n = "NORMAL",
          i = "INSERT",
          v = "VISUAL",
          V = "V-LINE",
          [''] = "V-BLOCK", -- Ctrl+V block mode
          c = "COMMAND",
          R = "REPLACE",
        }
        local mode = vim.fn.mode()
        return " " .. (mode_map[mode] or mode) .. " "
      end,
      hl = function()
        local mode_colors = {
          n = colors.blue,
          i = colors.green,
          v = colors.yellow,
          V = colors.yellow,
          [''] = colors.yellow,
          c = colors.red,
          R = colors.red,
        }
        local mode = vim.fn.mode()
        return { fg = colors.bg, bg = mode_colors[mode] or colors.magenta, style = "bold" }
      end,
      left_sep  = " ",
      right_sep = "",
    }

    local git_branch = {
      provider = function()
        local branch = git.git_branch()
        if branch == nil or branch == '' then
          return ''
        else
          return "  " .. branch .. " "
        end
      end,
      hl = { fg = colors.magenta, bg = colors.bg, style = "bold" },
      left_sep  = " ",
      right_sep = "",
    }

    local git_diff_added = {
      provider = function()
        local added = git.git_diff_added()
        if added and added ~= '' and tonumber(added) > 0 then
          return "  " .. added .. " "
        else
          return ""
        end
      end,
      hl = { fg = colors.green, bg = colors.bg },
      left_sep  = " ",
      right_sep = " ",
    }

    local git_diff_modified = {
      provider = function()
        local modified = git.git_diff_changed()
        if modified and modified ~= '' and tonumber(modified) > 0 then
          return " 柳 " .. modified .. " "
        else
          return ""
        end
      end,
      hl = { fg = colors.yellow, bg = colors.bg },
      left_sep  = " ",
      right_sep = " ",
    }

    local git_diff_removed = {
      provider = function()
        local removed = git.git_diff_removed()
        if removed and removed ~= '' and tonumber(removed) > 0 then
          return "  " .. removed .. " "
        else
          return ""
        end
      end,
      hl = { fg = colors.red, bg = colors.bg },
      left_sep  = " ",
      right_sep = "",
    }

    local file_info = {
      provider = "file_info",
      hl = { fg = colors.fg, bg = colors.bg },
      left_sep  = " ",
      right_sep = "",
    }

    -- RIGHT SECTION COMPONENTS

    local diagnostic_errors = {
      provider = "diagnostic_errors",
      icon = "  ",
      hl = { fg = colors.red, bg = colors.bg },
      left_sep  = " ",
      right_sep = " ",
    }

    local diagnostic_warnings = {
      provider = "diagnostic_warnings",
      icon = "  ",
      hl = { fg = colors.yellow, bg = colors.bg },
      left_sep  = " ",
      right_sep = " ",
    }

    local diagnostic_info = {
      provider = "diagnostic_info",
      icon = "  ",
      hl = { fg = colors.cyan, bg = colors.bg },
      left_sep  = " ",
      right_sep = " ",
    }

    local diagnostic_hints = {
      provider = "diagnostic_hints",
      icon = "  ",
      hl = { fg = colors.blue, bg = colors.bg },
      left_sep  = " ",
      right_sep = " ",
    }

    local lsp_clients = {
      provider = "lsp_client_names",
      icon = "   ",
      hl = { fg = colors.white, bg = colors.bg },
      left_sep  = " ",
      right_sep = "",
    }

    local file_type = {
      provider = "file_type",
      hl = { fg = colors.cyan, bg = colors.bg, style = "bold" },
      left_sep  = " ",
      right_sep = "",
    }

    local file_encoding = {
      provider = "file_encoding",
      hl = { fg = colors.green, bg = colors.bg },
      left_sep  = " ",
      right_sep = "",
    }

    local line_percentage = {
      provider = "line_percentage",
      hl = { fg = colors.yellow, bg = colors.bg },
      left_sep  = " ",
      right_sep = " ",
    }

    local position = {
      provider = "position",
      hl = { fg = colors.fg, bg = colors.bg },
      left_sep  = " ",
      right_sep = " ",
    }

    -- COMPONENT LAYOUT

    local components = {
      active = {
        -- LEFT SECTION: Mode, Git branch, and Git diff info
        {
          vi_mode,
          git_branch,
          git_diff_added,
          git_diff_modified,
          git_diff_removed,
          file_info,
        },
        -- CENTER SECTION: (Empty)
        {},
        -- RIGHT SECTION: Diagnostics, LSP, File details, etc.
        {
          diagnostic_errors,
          diagnostic_warnings,
          diagnostic_info,
          diagnostic_hints,
          lsp_clients,
          file_type,
          file_encoding,
          line_percentage,
          position,
        },
      },
      inactive = {
        { file_info }
      },
    }

    feline.setup({
      theme = { bg = colors.bg, fg = colors.fg },
      components = components,
      force_inactive = {
        filetypes = { "NvimTree", "packer", "qf" },
        buftypes = { "terminal" },
      },
    })
  end
}
