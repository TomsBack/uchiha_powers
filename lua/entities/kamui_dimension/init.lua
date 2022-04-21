AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:DrawShadow(false)
	self.walls = {}
	self:SetPos(self:GetPos() - Vector(0,0,1950))
	self:SetModel("models/madarad/madaradimension.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)

	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:AddGameFlag(bit.bor(FVPHYSICS_NO_PLAYER_PICKUP, FVPHYSICS_NO_SELF_COLLISIONS, FVPHYSICS_NO_NPC_IMPACT_DMG, FVPHYSICS_NO_IMPACT_DMG, FVPHYSICS_CONSTRAINT_STATIC))
		phys:EnableMotion(false)
		phys:EnableDrag(false)
		phys:EnableGravity(false)
	end
	self:SetRenderMode(RENDERMODE_NORMAL)

	self:Activate()
end

function ENT:AddWall(ent)
	self.walls[#self.walls+1] = ent
	ent:SetKamuiDimension(self)
end

local noRemoveEnts = {
	predicted_viewmodel = false,
}

function ENT:OnRemove()
	for k,v in ipairs(self.walls) do
		if v:IsValid() then
			v:Remove()
		end
	end
	for k,v in ipairs(ents.GetAll()) do
		if v:IsValid() and noRemoveEnts[v:GetClass()] != false and (!v:IsWeapon() or !v:GetParent():IsValid()) and self:PositionInside(v:GetPos()) then
			if v:IsPlayer() then
				v:KillSilent()
			else
				v:Remove()
			end
		end
	end
end