# copilot-lualine
Component for lualine with the purpose of recieving and previewing status of [copilot.lua](https://github.com/zbirenbaum/copilot.lua)

#### Requirements
- [x] [Neovim](https://neovim.io/)
- [x] [Lualine](https://github.com/nvim-lualine/lualine.nvim)
- [x] [Copilot.lua](https://github.com/zbirenbaum/copilot.lua)

## Installation

#### Using lazy.nvim
```lua
("AndreM222/copilot-lualine")
```
#### Using packer.nvim
```lua
use "AndreM222/copilot-lualine"
```

## Setup

You can add it anywhere you will like to.
example:
```lua
lualine.setup({
    options = {
        icons_enabled = true,
        theme = cozynight,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {},
        always_divide_middle = true
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff',
            {
                'diagnostics',
                sources = { "nvim_diagnostic" },
                symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' }
            }
        },
        lualine_c = { 'filename' },
        lualine_x = { 'copilot' ,'encoding', 'fileformat', 'filetype' }, -- I added copilot here
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    extensions = {}
})
```
Customization is available. For example:
```lua
sections = {
    lualine_x = { 
        {
            'copilot',
            -- Default values
            symbols = {
                status = {
                    icons = {
                        enabled = "",
                        disabled = "󰚦",
                        offline = ""
                    },
                    hl = {
                        enabled = "#50FA7B",
                        disabled = "#6272A4",
                        offline = "#FF5555"
                    }
                },
                spinners = require("copilot-lualine.spinners").dots,
                spinner_color = "#6272A4"
            },
            show_colors = false,
            show_loading = true
        },
        'encoding',
        'fileformat',
        'filetype'
    }
}
```
