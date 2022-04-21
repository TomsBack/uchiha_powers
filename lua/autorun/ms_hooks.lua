hook.Add("CreateEntityRagdoll", "AmaterasuRagdollBurn", function(owner, ragdoll)
    if owner.IsOnAmaterasu then
        MS_StopAmaterasu(owner)
        timer.Remove("Amaterasu " .. tostring(owner:EntIndex()))
        timer.Simple(0.1, function()
            if IsValid(ragdoll) then
                ragdoll:Ignite(GetConVar("itachi_amaterasu_length"):GetFloat())
                MS_StartAmaterasu(ragdoll)
            end
        end)
    end
end)

hook.Add("EntityRemoved", "RemoveAmaterasuTimer", function(entity)
    if timer.Exists("Amaterasu " .. tostring(entity:EntIndex())) then
        timer.Remove("Amaterasu " .. tostring(entity:EntIndex()))
    end
end)