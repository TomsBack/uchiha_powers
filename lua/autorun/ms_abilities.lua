function DamageOverTime(entity, damage, retries, delay, player)
    if IsValid(entity) then
        local timerName = "DamageOverTime " .. tostring(entity:EntIndex())

        timer.Create(timerName, delay, retries, function()
            if IsValid(entity) and entity:Health() > 0 then
                if SERVER then
                    entity:TakeDamage(damage, player, player)
                end
            else
                timer.Remove(timerName)
            end
        end)
    end
end

function Tsukuyomi(entity, player, damage, sound)
    if IsValid(entity) then
        if IsValid(entity) and entity:IsPlayer() then --Hit entity is a player
            local weapon = entity:GetActiveWeapon()

            if entity:MS_UsingMangekyou() then
                if weapon.IsInCounter then 
                    if SERVER then
                        entity:TakeDamage(damage, player, player:GetActiveWeapon())
                        return 
                    end
                elseif weapon.SusanooActive then
                    return 
                end
            end

            net.Start("TsukuyomiEffect")
            net.Send(entity)

            entity:PlayClientSound(sound)

            entity:Freeze(true)
            if SERVER then
                entity:SetLaggedMovementValue(0)
            end
 
            if SERVER then
                entity:TakeDamage(damage, player, player:GetActiveWeapon())
                DamageOverTime(entity, 25, 10, 1, player)
            end

            timer.Simple(10, function()
                if IsValid(entity) then
                    entity:Freeze(false)
                    net.Start("TsukuyomiEffectRemove")
                    net.Send(entity)
                    if SERVER then
                        entity:SetLaggedMovementValue(1)
                        entity:StopClientSound(sound)
                    end
                end
            end)

        elseif IsValid(entity) and entity:IsNPC() then --Hit entity is a npc
            if SERVER then
                entity:TakeDamage(damage, player, player:GetActiveWeapon())
                DamageOverTime(entity, 10, 10, 1, player)
            end
            if SERVER then
                entity:FearSound()
            end
            entity:NextThink(CurTime() + 1000)

            timer.Simple(10, function()
                if IsValid(entity) then
                    entity:NextThink(CurTime() + 0.1)
                end
            end)
        elseif IsValid(entity) and string.match(entity:GetClass(), "prop") or entity:GetClass() == "npc_grenade_frag" or string.match(entity:GetClass(), "weapon") or string.match(entity:GetClass(), "item") then
            if SERVER then
                for i = 1, math.random(3,5) do
                    crow = ents.Create("npc_crow")
                    crow:SetPos(entity:GetPos() + Vector(math.random(10,50), math.random(10,50), math.random(10,50)))
                    crow:Spawn()
                end
                entity:Remove()
            end
        end
    end
end