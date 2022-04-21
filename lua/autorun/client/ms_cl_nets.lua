net.Receive("RemoveItachiCounter", function()
    local player = LocalPlayer()

    hook.Remove("RenderScreenspaceEffects", "ItachiCounterColor " .. player:Nick())
    timer.Remove("Itachi Counter " .. player:Nick())

    if player:HasWeapon("mangekyou_sharingan_itachi") then
        local weapon = player:GetWeapon("mangekyou_sharingan_itachi")
        weapon.CounterStart = CurTime()
        weapon:SetCounterDurationTime(CurTime())
        weapon.IsInCounter = false
        weapon.IsAttacking = false
    end
end)

net.Receive("RemoveSasukeCounter", function()
    local player = LocalPlayer()

    hook.Remove("RenderScreenspaceEffects", "SasukeCounterColor " .. player:Nick())
    timer.Remove("Sasuke Counter " .. player:Nick())

    if player:HasWeapon("mangekyou_sharingan_sasuke") then
        local weapon = player:GetWeapon("mangekyou_sharingan_sasuke")
        weapon.CounterStart = CurTime()
        weapon:SetCounterDurationTime(CurTime())
        weapon.IsInCounter = false
        weapon.IsAttacking = false
    end
end)

net.Receive("TsukuyomiEffect", function()
    local player = LocalPlayer()

    hook.Add("RenderScreenspaceEffects", "TsukuyomiLaggedScreen", function()
        DrawMotionBlur(1, 1, 1000)
    end)

    player:ScreenFade(SCREENFADE.IN, Color(255,0,0,155), 0.3, 10)
end)

net.Receive("TsukuyomiEffectRemove", function()
    hook.Remove("RenderScreenspaceEffects", "TsukuyomiLaggedScreen")
end)

net.Receive("AmenotejikaraEffect", function()
    local amenotejikaraColor = {
        [ "$pp_colour_addr" ] = 0,
        [ "$pp_colour_addg" ] = 0,
        [ "$pp_colour_addb" ] = 0,
        [ "$pp_colour_brightness" ] = -0.58,
        [ "$pp_colour_contrast" ] = 10,
        [ "$pp_colour_colour" ] = 0,
        [ "$pp_colour_mulr" ] = 0,
        [ "$pp_colour_mulg" ] = 0,
        [ "$pp_colour_mulb" ] = 0
    }

    hook.Add("RenderScreenspaceEffects", "AmenotejikaraColor " .. LocalPlayer():Nick(), function()
        DrawColorModify(amenotejikaraColor)
    end)
end)

net.Receive("AmenotejikaraEffectRemove", function()
    hook.Remove("RenderScreenspaceEffects", "AmenotejikaraColor " .. LocalPlayer():Nick())
end)

net.Receive("SpawnAmaterasu", function()
    local entity = net.ReadEntity()
    if IsValid(entity) then
        entity.IsOnAmaterasu = true
        entity:StopParticlesNamed("amaterasu")
        for k, attach in ipairs(entity:GetAttachments()) do
            CreateParticleSystem(entity, "amaterasu", PATTACH_POINT_FOLLOW, attach.id, Vector(math.random(-5,10),math.random(-5,15),math.random(-10,30)))
        end
        for i = 1, 3 do
            CreateParticleSystem(entity, "amaterasu", PATTACH_ABSORIGIN_FOLLOW, 1, Vector(math.random(-5,10),math.random(-10,10),math.random(-10,30)))
        end
    end
end)

net.Receive("StopAmaterasu", function()
    local entity = net.ReadEntity()
    if IsValid(entity) then
        entity.IsOnAmaterasu = false
        entity:StopParticlesNamed("amaterasu")
    end
end)

net.Receive("ActivateRinnegan", function()
    local player = LocalPlayer()
    local weapon = player:GetActiveWeapon()

    if IsValid(player) and player:MS_UsingSasuke() then
        weapon.HasRinnegan = true
    end
end)

net.Receive("AddHalo", function()
    local player = net.ReadEntity()
    local color = net.ReadColor()

    hook.Add("PreDrawHalos", player:GetActiveWeapon():GetClass() .. player:GetName(), function()
        if IsValid(player) then
            local haloEntities = {}
    
            table.insert(haloEntities, player)
    
            for _, v in ipairs(player:GetChildren()) do
                if IsValid(v) and v:GetModel() ~= nil and not string.match(v:GetModel(), "madara") then
                    table.insert(haloEntities, v)
                end
            end
    
            halo.Add(haloEntities, color, 7, 7, 2)
        end
    end)
end)

net.Receive("RemoveHalo", function()
    local hookName = net.ReadString()
    hook.Remove("PreDrawHalos", hookName)
end)

net.Receive("ClientSoundPlay", function()
    local player = LocalPlayer()
    local sound = Sound(net.ReadString())
    local soundLevel = net.ReadFloat()
    local pitchPercent = net.ReadFloat()
    local volume = net.ReadFloat()

    player:EmitSound(sound, soundLevel, pitchPercent, volume)
end)

net.Receive("ClientSoundStop", function()
    local player = LocalPlayer()
    local sound = Sound(net.ReadString())

    player:StopSound(sound)
end)