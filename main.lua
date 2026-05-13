-- ReGui Loader with Prefabs Fix
local ReGui

local success, err = pcall(function()
    ReGui = loadstring(game:HttpGet("https://raw.githubusercontent.com/myethg/Dear-ReGui/main/ReGui.lua"))()
end)

if not success then
    warn("Не удалось загрузить ReGui:", err)
    return
end

-- === ФИКС PREFABS ===
ReGui.LoadPrefabs = function(self)
    local Name = "ReGui-Prefabs"

    -- Попытка 1: Встроенные префабы
    local s, p = pcall(function() return script:WaitForChild(Name, 2) end)
    if s and p then return p end

    -- Попытка 2: В PlayerGui
    local s2, p2 = pcall(function() return self.PlayerGui:WaitForChild(Name, 2) end)
    if s2 and p2 then return p2 end

    warn("[ReGui] Prefabs not found! Trying asset load...")
    return nil
end

-- Запуск
ReGui:CheckImportState()

local Window = ReGui:Window({
    Title = "ReGui Fixed",
    Size = UDim2.fromOffset(680, 520)
})

Window:Label({Text = "ReGui запущена с фиксом Prefabs"})
Window:Button({
    Text = "Тест кнопка",
    Callback = function()
        print("ReGui работает!")
    end
})
