ENT.Type 		= "anim"
ENT.Base 		= "base_anim"
ENT.PrintName 	= "Kamui Dimension"
ENT.Name 		= "Kamui Dimension"
ENT.Spawnable 	= false
ENT.PhysgunDisabled = true
ENT.UnEatable = true
ENT.DisableDuplicator = true

function ENT:SetupDataTables()
	self:NetworkVar("Int",0,"Width")
	self:NetworkVar("Int",1,"Length")
	self:NetworkVar("Int",2,"Height")
end

function ENT:GetKamuiBounds()
	return Vector(self:GetWidth()/1.25,self:GetLength()/1.25,self:GetHeight()/1.1)
end

function ENT:PositionInside(pos)
	local bounds = self:GetKamuiBounds()
	return pos:WithinAABox(self:GetPos()-bounds,self:GetPos()+bounds)
end
if SERVER then return end

function ENT:Initialize()
	local bounds = self:GetKamuiBounds()
	self:SetRenderBounds(-bounds,bounds)
end

function ENT:Draw()
	if self:IsValid() and !self:ShouldRenderInterior() then
		return
	end
	self:DrawModel()
end

function ENT:ShouldRenderInterior()
	return self:PositionInside(EyePos())
end

hook.Add("PreRender","PreRenderKamuiEnts",function()
	for k,Kamui in ipairs(ents.FindByClass("kamui_dimension")) do
		if Kamui:ShouldRenderInterior() then continue end
		for o,ent in ipairs(ents.GetAll()) do
			if !ent.KamuiRenderingMode and ent != Kamui and ent:GetClass() != "kamuiwall" and Kamui:PositionInside(ent:GetPos()) then
				ent.KamuiRenderingMode = true
				local prevRender = ent.RenderOverride
				ent.RenderOverride = function(self)
					if !Kamui:IsValid() or !Kamui:PositionInside(self:GetPos()) or Kamui:ShouldRenderInterior() then
						self.RenderOverride = prevRender
						self.KamuiRenderingMode = nil
						return
					end
				end
			end
		end
	end
end)

hook.Add("PreDrawTranslucentRenderables","CatchKamuiEyePos",function()
	EyePos()
end)
