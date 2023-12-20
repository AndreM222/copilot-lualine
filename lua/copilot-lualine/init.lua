local component = {}
<<<<<<< HEAD
local c = require("copilot.client")
local a = require("copilot.api")

print("hi")

=======
local status_c, c = pcall(require, "copilot.client")
if (not status_c) then return end
local status_a, a = pcall(require, "copilot.api")
if (not status_a) then return end
>>>>>>> f11d5e8fe12220e25ceb3b18707fa312f327533e

---Check if copilot is enabled
---@return boolean
component.is_enabled = function()
    if c.is_disabled() then
        return false
    end

    return true
end

---Check if copilot is offline
---@return boolean
component.is_online = function()
    if not c.get() then
        return true
    end

    -- a.handlers.statusNotification
    local data = c.startup_error
    if data ~= "Warning" then
        return true
    end

    return false
end

---Show copilot running status
---@return boolean
component.is_loading = function()
    if not c.get() then
        return false
    end

    local data = a.status.data.status
    if data == 'InProgress' then
        return true
    end

    return false
end

return component
