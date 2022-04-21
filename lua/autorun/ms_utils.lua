game.AddParticles("particles/amaterasu.pcf")
PrecacheParticleSystem("amaterasu")

local MPLY = FindMetaTable("Player")
local MENT = FindMetaTable("Entity")

local ENT_BLACKLIST = {
    ["ba_stand_rewritten"] = true,
    ["ba_thefool"] = true,
    ["kamui_dimension"] = true,
    ["kamuiwall"] = true
}

function MS_IsInBlacklist(ent)
    if not ENT_BLACKLIST[ent:GetClass()] then
        return false
    end
    return true
end

function MS_StartAmaterasu(entity)
    if IsValid(entity) then
        for k, v in ipairs(entity:GetChildren()) do --Disable normal fire
            if v:GetClass() == "entityflame" then
                v:SetNoDraw(true)
            end
        end
    
        net.Start("SpawnAmaterasu")
        net.WriteEntity(entity)
        net.Broadcast()
    
        entity.IsOnAmaterasu = true

        if SERVER then
            timer.Create("Amaterasu " .. tostring(entity:EntIndex()), GetConVar("itachi_amaterasu_length"):GetFloat(), 1, function()
                if IsValid(entity) then
                    MS_StopAmaterasu(entity)
                else
                    timer.Remove("Amaterasu " .. tostring(entity:EntIndex()))
                end
            end)
        end
    end
end

function MS_StopAmaterasu(entity)
    if IsValid(entity) then
        entity:Extinguish()
        net.Start("StopAmaterasu")
        net.WriteEntity(entity)
        net.Broadcast()
    
        entity.IsOnAmaterasu = false
        timer.Remove("Amaterasu " .. tostring(entity:EntIndex()))
    end
end

function MPLY:MS_UsingMangekyou()
    if IsValid(self) and IsValid(self:GetActiveWeapon()) and string.match(self:GetActiveWeapon():GetClass(), "mangekyou") then
        return true
    end
    return false
end

function MPLY:MS_UsingItachi()
    if IsValid(self) and IsValid(self:GetActiveWeapon()) and self:GetActiveWeapon():GetClass() == "mangekyou_sharingan_itachi" then
        return true
    end
    return false
end

function MPLY:MS_UsingSasuke()
    if IsValid(self) and IsValid(self:GetActiveWeapon()) and self:GetActiveWeapon():GetClass() == "mangekyou_sharingan_sasuke" then
        return true
    end
    return false
end

function MPLY:MS_UsingObito()
    if IsValid(self) and IsValid(self:GetActiveWeapon()) and self:GetActiveWeapon():GetClass() == "mangekyou_sharingan_obito" then
        return true
    end
    return false
end

function MPLY:MS_UsingMadara()
    if IsValid(self) and IsValid(self:GetActiveWeapon()) and self:GetActiveWeapon():GetClass() == "mangekyou_sharingan_madara" then
        return true
    end
    return false
end

--Thanks to XYZ
function MPLY:MS_SetScale(scale, time)
    time = time or 0

    self:SetModelScale(scale, time)
    self:SetStepSize(18 * scale)
	self:SetRunSpeed(400 * scale)
	self:SetWalkSpeed(200 * scale)
    if scale > 1 then
        self:SetJumpPower(200 * (scale * 1.5))
    else
        self:SetJumpPower(200 * scale)
    end
    self:SetCrouchedWalkSpeed(0.3*scale)
    if scale > 1 then
        self:SetViewOffset(Vector(0,0,72) * scale)
        self:SetViewOffsetDucked(Vector(0,0,28) * scale)
    else
        self:SetViewOffset(Vector(0,0,64) * scale)
        self:SetViewOffsetDucked(Vector(0,0,28) * scale)
    end
end

--Sound related
function MPLY:PlayClientSound(sound, soundLevel, pitchPercent, volume)
    soundLevel = soundLevel or 75
    pitchPercent = pitchPercent or 100
    volume = volume or 1

    net.Start("ClientSoundPlay")
    net.WriteString(sound)
    net.WriteFloat(soundLevel)
    net.WriteFloat(pitchPercent)
    net.WriteFloat(volume)
    net.Send(self)
end

function MPLY:StopClientSound(sound)
    net.Start("ClientSoundStop")
    net.WriteString(sound)
    net.Send(self)
end

--Math :O
if CLIENT then
    function draw.Circle( x, y, radius, seg )
        local cir = {}
    
        table.insert( cir, { x = x, y = y, u = 0.5, v = 0.5 } )
        for i = 0, seg do
            local a = math.rad( ( i / seg ) * -360 )
            table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )
        end
    
        local a = math.rad( 0 ) -- This is needed for non absolute segment counts
        table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )
    
        surface.DrawPoly( cir )
    end
end

--For making things same on all screens
function relativeW(px)
    return ScrW() * px/1920
end

function relativeH(px)
    return ScrH() * px/1080
end