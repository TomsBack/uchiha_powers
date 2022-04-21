AddCSLuaFile()

ENT.PrintName = "Shiny Knife"
ENT.Description = "Itachi's susanoo totsuka blade"
ENT.Category = "Susanoo Weapons"
ENT.Type = "anim"
ENT.Spawnable = false
ENT.AdminOnly = true

ENT.Lifetime = 10

local stabSound = Sound("gordon/stab.wav")
local hitObjectSound = Sound("gordon/hit_object.wav")

function ENT:Initialize()
    if SERVER then
        self:SetHealth(500)
        self:SetModel("models/itachi_susanoo_sword/itachi_susanoo_sword.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)

        local phys = self:GetPhysicsObject()
        if IsValid(phys) then
            phys:SetMass(10)
        end
    
        self.CanTool = false
    
        timer.Simple(self.Lifetime, function()
            if IsValid(self) then
                self:Remove()
            end
        end)
    end
end

function ENT:PhysicsCollide(data, phys)
    if SERVER then
        local player = self:GetOwner()
        if data.HitEntity ~= player then
            local weapon = player:GetActiveWeapon()
            if IsValid(data.HitEntity) then

                local dmgInfo = DamageInfo()
                dmgInfo:SetAttacker(player)
                dmgInfo:SetInflictor(weapon)
                dmgInfo:SetDamage(weapon.SusanooSecondaryDamage)
                dmgInfo:SetDamageForce(player:GetAimVector() * 5000)

                SuppressHostEvents(nil)
                data.HitEntity:TakeDamageInfo(dmgInfo)
                SuppressHostEvents(player)

                local phys = data.HitEntity:GetPhysicsObject()
                if IsValid(phys) then
                    phys:SetVelocity(self:GetForward() * 10000)
                end
            end

            local effectData = EffectData()
            effectData:SetOrigin(data.HitPos)
            util.Effect("Explosion", effectData, true, true)

            for k, v in ipairs(ents.FindInSphere(data.HitPos, 225)) do
                if IsValid(v) and v ~= self and v ~= player and v:IsSolid() then
                    SuppressHostEvents(nil)
                    v:TakeDamage(weapon.SusanooSecondaryDamage / 2, player, weapon)
                    SuppressHostEvents(player)
        
                    local phys = v:GetPhysicsObject()
                    if IsValid(phys) then
                        phys:SetVelocity((v:GetPos() - data.HitPos) * 2500 / phys:GetMass())
                    end
                end
            end
            self:Remove()
        end
    end
end