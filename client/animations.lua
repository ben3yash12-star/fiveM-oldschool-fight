function PlayFighterAnimation(animDict, animName, duration)
    if not animDict or not animName then
        return
    end

    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Wait(0)
    end

    local ped = PlayerPedId()
    if not IsEntityPlayingAnim(ped, animDict, animName, 3) then
        TaskPlayAnim(ped, animDict, animName, 8.0, 8.0, duration, 0, 1.0, false, false, false)
    end
end
