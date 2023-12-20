local component = require("lualine.component"):extend()
local highlight = require("lualine.highlight")

local copilot = require "copilot-lualine"

---@class CopilotComponentOptions
local default_options = {
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
        spinners = require("spinners").dots,
        spinner_color = "#6272A4"
    },
    show_colors = false,
    show_loading = true
}

local spinner_count = 1

---Return a spinner from the list of spinners
---@param spinners table
---@return string
local function get_spinner(spinners)
    local spinner = spinners[spinner_count]
    spinner_count = spinner_count + 1
    if spinner_count > #spinners then
        spinner_count = 1
    end
    return spinner
end

-- Whether copilot is attached to a buffer
local attached = false

---Initialize component
---@override
---@param options CopilotComponentOptions
function component:init(options)
    component.super.init(self, options)
    self.options = vim.tbl_deep_extend("force", default_options, options or {})

    if options.symbols then
        if options.symbols.status.icons.enabled then
            options.symbols.status.icons = options.symbols.status.icons or {}
            options.symbols.status.icons.enabled = options.symbols.status.icons.enabled
        end

        if options.symbols.status.icons.disabled then
            options.symbols.status.icons = options.symbols.status.icons or {}
            options.symbols.status.icons.disabled = options.symbols.status.icons.disabled
        end

        if options.symbols.status.icons.offline then
            options.symbols.status.icons = options.symbols.status.icons or {}
            options.symbols.status.icons.offline = options.symbols.status.icons.offline
        end

        if options.symbols.status.hl.enabled then
            options.symbols.status.hl = options.symbols.status.hl or {}
            options.symbols.status.hl.enabled = options.symbols.status.hl.enabled
        end

        if options.symbols.status.hl.disabled then
            options.symbols.status.hl = options.symbols.status.hl or {}
            options.symbols.status.hl.disabled = options.symbols.status.hl.disabled
        end

        if options.symbols.status.hl.offline then
            options.symbols.status.hl = options.symbols.status.hl or {}
            options.symbols.status.hl.offline = options.symbols.status.hl.offline
        end

        if options.symbols.spinner_color then
            options.symbols = options.symbols or {}
            options.symbols.spinner_color = options.symbols.spinner_color
        end
    end

    self.highlights = { enabled = '', disabled = '', offline = '' }

    self.highlights.enabled = highlight.create_component_highlight_group(
        { fg = self.options.symbols.status.hl.enabled },
        'copilot_enabled', self.options)
    self.highlights.disabled = highlight.create_component_highlight_group(
        { fg = self.options.symbols.status.hl.disabled },
        'copilot_disabled', self.options)
    self.highlights.offline = highlight.create_component_highlight_group(
        { fg = self.options.symbols.status.hl.offline },
        'copilot_offline', self.options)
    self.highlights.spinner = highlight.create_component_highlight_group(
        { fg = self.options.symbols.spinner_color },
        'copilot_spinner', self.options)

    vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("copilot-status", {}),
        desc = "Update copilot attached status",
        callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client and client.name == "copilot" then
                attached = true
                return true
            end
            return false
        end,
    })
end

---@override
function component:update_status()
    -- All copilot API calls are blocking before copilot is attached,
    -- To avoid blocking the startup time, we check if copilot is attached
    if not attached then
        return self.options.symbols.status.icons.disabled
    end

    if self.options.show_loading and copilot.is_loading() then
        if self.options.show_colors then
            return highlight.component_format_highlight(self.highlights.spinner) ..
               get_spinner(self.options.symbols.spinners)
        end
        return get_spinner(self.options.symbols.spinners)
    elseif not copilot.is_online() then
        if self.options.show_colors then
            return highlight.component_format_highlight(self.highlights.offline) ..
                self.options.symbols.status.icons.offline
        end
        return self.options.symbols.status.icons.offline
    elseif not copilot.is_enabled() then
        if self.options.show_colors then
            return highlight.component_format_highlight(self.highlights.disabled) ..
                self.options.symbols.status.icons.disabled
        end
        return self.options.symbols.status.icons.disabled
    else
        if self.options.show_colors then
            return highlight.component_format_highlight(self.highlights.enabled) ..
                self.options.symbols.status.icons.enabled
        end
        return self.options.symbols.status.icons.enabled
    end
end

return component
