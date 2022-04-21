ENT.Type 		= "anim"
ENT.Base 		= "base_gmodentity"
ENT.Category 	= "Misc"
ENT.PrintName 	= "Kamui Dimension Wall"
ENT.Author    	= "Tom"
ENT.Spawnable 	= false
ENT.PhysgunDisabled = true
ENT.UnEatable = true
ENT.RenderGroup = RENDERGROUP_BOTH

function ENT:SetupDataTables()
	self:NetworkVar("Int",0,"Width")
	self:NetworkVar("Int",1,"Length")
	self:NetworkVar("Int",2,"Height")
	self:NetworkVar("Entity",0,"KamuiDimension")
end

function ENT:GetWallBounds()
	return Vector(self:GetWidth()/2,self:GetLength()/2,self:GetHeight()/2)
end
