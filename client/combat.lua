local combatState = {
    stamina = CombatConfig.maxStamina,
    comboIndex = 1,
    lastAttack = 0,
    isBlocking = false,
    isDodging = false,
    dodgeCooldown = 0,
    lastComboReset = 0
}

local function isAttackPossible()
    local now = GetGameTimer()
    return (now - combatState.lastAttack) >= (CombatConfig.hitCooldown * 1000)
end

local function getNearestTarget()
    local player = PlayerPedId()
    local playerPos = GetEntityCoords(player)
    local nearestPed = nil
    local nearestDistance = 99.0

    for _, ped in ipairs(GetGamePool('CPed')) do
        if ped ~= player and not IsPedAPlayer(ped) then
            local targetPos = GetEntityCoords(ped)
            local distance = #(playerPos - targetPos)
            if distance < nearestDistance and distance <= CombatConfig.attackReach then
                nearestPed = ped
                nearestDistance = distance
            end
        end
    end

    return nearestPed
end

local function consumeStamina(value)
    combatState.stamina = math.max(0, combatState.stamina - value)
end

local function damageTarget(ped, amount)
    if ped and ped > 0 and DoesEntityExist(ped) then
        ApplyDamageToPed(ped, amount, false)
    end
end

function TriggerCombatAttack()
    if not isAttackPossible() then
        return
    end

    local currentMove = CombatCombos[combatState.comboIndex]
    if not currentMove then
        combatState.comboIndex = 1
        currentMove = CombatCombos[combatState.comboIndex]
    end

    if combatState.stamina < currentMove.stamina then
        return
    end

    local target = getNearestTarget()
    if target then
        consumeStamina(currentMove.stamina)
        combatState.lastAttack = GetGameTimer()
        PlayFighterAnimation(currentMove.animDict, currentMove.animName, currentMove.duration)
        damageTarget(target, currentMove.damage)

        combatState.comboIndex = combatState.comboIndex + 1
        if combatState.comboIndex > #CombatCombos then
            combatState.comboIndex = 1
        end
    end
end

function ToggleCombatBlock()
    combatState.isBlocking = not combatState.isBlocking
    if combatState.isBlocking then
        TriggerEvent('oldschool_fight:notify', 'الوضع: Block فعال')
    else
        TriggerEvent('oldschool_fight:notify', 'الوضع: Block متوقف')
    end
end

function TriggerCombatDodge()
    local now = GetGameTimer()
    if now - combatState.dodgeCooldown < 900 then
        return
    end

    if combatState.stamina < CombatConfig.dodgeCost then
        return
    end

    combatState.dodgeCooldown = now
    combatState.stamina = math.max(0, combatState.stamina - CombatConfig.dodgeCost)
    combatState.isDodging = true

    local player = PlayerPedId()
    local coords = GetEntityCoords(player)
    local heading = GetEntityHeading(player)
    local moveX = math.cos(math.rad(heading)) * CombatConfig.dodgeDistance
    local moveY = math.sin(math.rad(heading)) * CombatConfig.dodgeDistance
    SetEntityCoords(player, coords.x + moveX, coords.y + moveY, coords.z, false, false, false, false)
    PlayFighterAnimation('move_m@_idles@shake_off', 'shake_off', 550)

    SetTimeout(350, function()
        combatState.isDodging = false
    end)
end

function GetCombatState()
    return combatState
end

RegisterNetEvent('oldschool_fight:attack')
AddEventHandler('oldschool_fight:attack', function()
    TriggerCombatAttack()
end)

RegisterNetEvent('oldschool_fight:block')
AddEventHandler('oldschool_fight:block', function()
    ToggleCombatBlock()
end)

RegisterNetEvent('oldschool_fight:dodge')
AddEventHandler('oldschool_fight:dodge', function()
    TriggerCombatDodge()
end)

Citizen.CreateThread(function()
    while true do
        Wait(100)
        if combatState.stamina < CombatConfig.maxStamina then
            combatState.stamina = math.min(CombatConfig.maxStamina, combatState.stamina + CombatConfig.staminaRegen * 0.1)
        end
    end
end)
