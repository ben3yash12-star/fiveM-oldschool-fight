local function drawTxt(x, y, width, height, scale, text, r, g, b, a)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry('STRING')
    AddTextComponentString(text)
    DrawText(x, y)
end

local function drawBar(x, y, width, height, value, maxValue, color)
    DrawRect(x + width / 2, y + height / 2, width, height, 30, 30, 30, 120)
    DrawRect(x + width / 2, y + height / 2, width * (value / maxValue), height, color.r, color.g, color.b, 200)
end

Citizen.CreateThread(function()
    while true do
        Wait(0)

        local state = GetCombatState()
        local staminaPercent = state.stamina / CombatConfig.maxStamina

        drawBar(0.55, 0.84, 0.22, 0.02, state.stamina, CombatConfig.maxStamina, { r = 60, g = 180, b = 255 })
        drawTxt(0.55, 0.82, 0, 0, 0.34, 'Stamina: ' .. tostring(math.floor(state.stamina)) .. '%', 255, 255, 255, 255)

        if state.isBlocking then
            drawTxt(0.55, 0.79, 0, 0, 0.30, 'BLOCK ACTIVE', 255, 210, 70, 255)
        end

        if state.isDodging then
            drawTxt(0.55, 0.76, 0, 0, 0.30, 'DODGE', 120, 255, 120, 255)
        end
    end
end)
