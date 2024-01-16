local component = {}
local status_c, c = pcall(require, "copilot.client")
if (not status_c) then return end
local status_a, a = pcall(require, "copilot.api")
if (not status_a) then return end

---Check if copilot is enabled
---@return boolean
component.is_enabled = function()
    if c.is_disabled() then
        return false
    end

    return true
end

---Check if copilot is online
---@return boolean
component.is_error = function()
    if c.is_disabled() then
        return false
    end

    local data = a.status.data.status
    if data == 'Warning' then
        return true
    end

    return false
end

---Show copilot running status
---@return boolean
component.is_loading = function()
    if c.is_disabled() then
        return false
    end

    local data = a.status.data.status
    if data == 'InProgress' then
        return true
    end

    return false
end

---Check auto trigger suggestions
---@return boolean
component.is_sleep = function()
    if c.is_disabled() then
        return false
    end

    return vim.b.copilot_suggestion_auto_trigger
end

return component
