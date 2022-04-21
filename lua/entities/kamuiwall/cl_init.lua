include("shared.lua")

local material = Material("color")
local sunBlockerMat = Material("phoenix_storms/cube")

function ENT:Initialize()
	local bounds = self:GetWallBounds()
	self:SetRenderBounds(-bounds,bounds)
end

function ENT:GetDrawMesh()
	if !self.mesh then
		local bounds = self:GetWallBounds()
		self.mesh = Mesh(sunBlockerMat)
		self.mesh:BuildFromTriangles({--This is autistic
			[1] = {pos = Vector(-bounds.x,bounds.y,bounds.z)},
			[2] = {pos = Vector(-bounds.x,-bounds.y,-bounds.z)},
			[3] = {pos = Vector(-bounds.x,bounds.y,-bounds.z)},
			[4] = {pos = Vector(-bounds.x,-bounds.y,bounds.z)},
			[5] = {pos = Vector(-bounds.x,-bounds.y,-bounds.z)},
			[6] = {pos = Vector(-bounds.x,bounds.y,bounds.z)},
			[7] = {pos = Vector(bounds.x,-bounds.y,-bounds.z)},
			[8] = {pos = Vector(-bounds.x,bounds.y,-bounds.z)},
			[9] = {pos = Vector(-bounds.x,-bounds.y,-bounds.z)},
			[10] = {pos = Vector(bounds.x,bounds.y,-bounds.z)},
			[11] = {pos = Vector(-bounds.x,bounds.y,-bounds.z)},
			[12] = {pos = Vector(bounds.x,-bounds.y,-bounds.z)},
			[13] = {pos = Vector(-bounds.x,-bounds.y,bounds.z)},
			[14] = {pos = Vector(bounds.x,-bounds.y,-bounds.z)},
			[15] = {pos = Vector(-bounds.x,-bounds.y,-bounds.z)},
			[16] = {pos = Vector(bounds.x,-bounds.y,bounds.z)},
			[17] = {pos = Vector(bounds.x,-bounds.y,-bounds.z)},
			[18] = {pos = Vector(-bounds.x,-bounds.y,bounds.z)},
			[19] = {pos = Vector(bounds.x,bounds.y,-bounds.z)},
			[20] = {pos = Vector(bounds.x,bounds.y,bounds.z)},
			[21] = {pos = Vector(-bounds.x,bounds.y,-bounds.z)},
			[22] = {pos = Vector(bounds.x,bounds.y,bounds.z)},
			[23] = {pos = Vector(-bounds.x,bounds.y,bounds.z)},
			[24] = {pos = Vector(-bounds.x,bounds.y,-bounds.z)},
			[25] = {pos = Vector(bounds.x,-bounds.y,-bounds.z)},
			[26] = {pos = Vector(bounds.x,-bounds.y,bounds.z)},
			[27] = {pos = Vector(bounds.x,bounds.y,-bounds.z)},
			[28] = {pos = Vector(bounds.x,-bounds.y,bounds.z)},
			[29] = {pos = Vector(bounds.x,bounds.y,bounds.z)},
			[30] = {pos = Vector(bounds.x,bounds.y,-bounds.z)},
			[31] = {pos = Vector(bounds.x,-bounds.y,bounds.z)},
			[32] = {pos = Vector(-bounds.x,-bounds.y,bounds.z)},
			[33] = {pos = Vector(bounds.x,bounds.y,bounds.z)},
			[34] = {pos = Vector(-bounds.x,-bounds.y,bounds.z)},
			[35] = {pos = Vector(-bounds.x,bounds.y,bounds.z)},
			[36] = {pos = Vector(bounds.x,bounds.y,bounds.z)},
		})
	end
	return self.mesh
end

local matScale = Vector(5,5,5)
function ENT:Draw()
	if self:GetKamuiDimension():IsValid() and !self:GetKamuiDimension():ShouldRenderInterior() then
		return
	end
	local mat = Matrix()
	mat:Translate(self:GetPos())
	mat:Rotate(self:GetAngles())
	render.SetMaterial(sunBlockerMat)
	cam.PushModelMatrix(mat)
	self:GetDrawMesh():Draw() --Blocks the sun
	cam.PopModelMatrix()
	
	local bounds = self:GetWallBounds()
	bounds.z = bounds.z+2 --Fix a clipping error with the sun blocker
	
	render.SetMaterial(material)
	local m = Matrix()
	m:SetScale(matScale)
	material:SetMatrix("$basetexturetransform",m)
	
	render.DrawQuad(self:LocalToWorld(Vector(-bounds.x,-bounds.y,bounds.z)),self:LocalToWorld(Vector(-bounds.x,bounds.y,bounds.z)),self:LocalToWorld(bounds),self:LocalToWorld(Vector(bounds.x,-bounds.y,bounds.z)),Color(0,0,0))
end
