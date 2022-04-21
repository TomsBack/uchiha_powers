AddCSLuaFile()

ENT.PrintName = "Hashirama Cells"
ENT.Description = "Hashirama Cells"
ENT.Category = "Naruto"
ENT.Type = "anim"
ENT.Spawnable = true
ENT.AdminOnly = true

local pickUpSound = nil

function ENT:Initialize()
    if SERVER then
        self:SetHealth(500)
        self:SetModel("models/props_lab/jar01b.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)

        local phys = self:GetPhysicsObject()
        if IsValid(phys) then
            phys:SetMass(10)
        end
    end
end

function ENT:Use(activator)
    if IsValid(activator) and activator:IsPlayer() then
        if activator:MS_UsingSasuke() then
            local weapon = activator:GetActiveWeapon()

            weapon.HasRinnegan = true
            net.Start("ActivateRinnegan")
            net.Send(activator)

            activator:SetHealth(weapon.BaseHealth * 1.25)
            activator:SetMaxHealth(weapon.BaseHealth * 1.25)
            activator:SetArmor(30)
        else
            if math.random(1, 2) == 2 then
                activator:Kill()
            end
        end
        self:Remove()
    end
end