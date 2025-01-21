local component = require("lualine.component"):extend()
local highlight = require("lualine.highlight")

local copilot = require("copilot-lualine")

---@class CopilotComponentOptions
local default_options = {
    symbols = {
        status = {
            icons = {
                enabled = " ",
                sleep = " ",
                disabled = " ",
                warning = " ",
                unknown = " "
            },
            hl = {
                enabled = "#50FA7B",
                sleep = "#AEB7D0",
                disabled = "#6272A4",
                warning = "#FFB86C",
                unknown = "#FF5555"
            }
        },
        spinners = "dots",
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
    if type(spinners) == "table" then
        local spinner = spinners[spinner_count]

        spinner_count = spinner_count + 1

        if spinner_count > #spinners then
            spinner_count = 1
        end

        return spinner
    end

    if type(spinners) == "string" then
        if not require("copilot-lualine.spinners")[spinners] then
            return spinners
        end

        local spinner = require("copilot-lualine.spinners")[spinners][spinner_count]

        spinner_count = spinner_count + 1

        if spinner_count > #spinners then
            spinner_count = 1
        end

        return spinner
    end

    return "Invalid"
end

-- Whether copilot is attached to a buffer
local attached = false

---Initialize component
---@override
---@param options CopilotComponentOptions
function component:init(options)
    component.super.init(self, options)
    self.options = vim.tbl_deep_extend("force", default_options, options or {})

    self.highlights = { enabled = '', disabled = '', warning = '' }

    self.highlights.sleep = highlight.create_component_highlight_group(
        { fg = self.options.symbols.status.hl.sleep },
        'copilot_sleep', self.options)
    self.highlights.enabled = highlight.create_component_highlight_group(
        { fg = self.options.symbols.status.hl.enabled },
        'copilot_enabled', self.options)
    self.highlights.disabled = highlight.create_component_highlight_group(
        { fg = self.options.symbols.status.hl.disabled },
        'copilot_disabled', self.options)
    self.highlights.warning = highlight.create_component_highlight_group(
        { fg = self.options.symbols.status.hl.warning },
        'copilot_offline', self.options)
    self.highlights.unknown = highlight.create_component_highlight_group(
        { fg = self.options.symbols.status.hl.unknown },
        'copilot_unknown', self.options)
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
                require("copilot.api").register_status_notification_handler(function()
                    require("lualine").refresh()
                end)
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
    local copilot_loaded = package.loaded["copilot"] ~= nil
    if not copilot_loaded or not attached then
        if self.options.show_colors then
            return highlight.component_format_highlight(self.highlights.unknown) ..
                self.options.symbols.status.icons.unknown
        end
        return self.options.symbols.status.icons.unknown
    end

    if self.options.show_loading and copilot.is_loading() then
        if self.options.show_colors then
            return highlight.component_format_highlight(self.highlights.spinner) ..
                get_spinner(self.options.symbols.spinners)
        end
        return get_spinner(self.options.symbols.spinners)
    elseif copilot.is_error() then
        if self.options.show_colors then
            return highlight.component_format_highlight(self.highlights.warning) ..
                self.options.symbols.status.icons.warning
        end
        return self.options.symbols.status.icons.warning
    elseif not copilot.is_enabled() then
        if self.options.show_colors then
            return highlight.component_format_highlight(self.highlights.disabled) ..
                self.options.symbols.status.icons.disabled
        end
        return self.options.symbols.status.icons.disabled
    elseif copilot.is_sleep() then
        if self.options.show_colors then
            return highlight.component_format_highlight(self.highlights.sleep) ..
                self.options.symbols.status.icons.sleep
        end
        return self.options.symbols.status.icons.sleep
    else
        if self.options.show_colors then
            return highlight.component_format_highlight(self.highlights.enabled) ..
                self.options.symbols.status.icons.enabled
        end
        return self.options.symbols.status.icons.enabled
    end
end

return component
