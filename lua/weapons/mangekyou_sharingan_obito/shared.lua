AddCSLuaFile()

SWEP.PrintName = "Obito Sharingan"
SWEP.Author = "Tomik"
SWEP.Purpose = "Use the mighty powers of obitos's mangekyou sharingan"
SWEP.Instructions = "--Normal Mode--\nLMB - KamuiEnt\nLMB + ALT - Extinguish target\nLMB + CTRL - Extinguish yourself\nRMB - KamuiSelf\nR - Counter \nB - Susano'o \n\n--Susano'o Mode--\nLMB - Slash\nRMB - Throw Sword\nR - Wings\nB - Disable Susano'o\nPassive - No damage from bullets\nPassive - KamuiSelf does not effect susanoo\nPassive - When you land, you deal damage to entities in range"
SWEP.Category = "Sharingan Powers"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel = ""
SWEP.WorldModel = ""
SWEP.ViewModelFOV = 54
SWEP.HoldType = "normal"
SWEP.UseHands = true
SWEP.BounceWeaponIcon = false
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("huds/obito_select")
    SWEP.AccurateCrosshair = true
end

SWEP.Slot = 2
SWEP.SlotPos = 1
SWEP.DrawCrosshair = true
SWEP.DrawAmmo = false

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"

SWEP.BaseHealth = 500

SWEP.KamuiEntCD = GetConVar("obito_amaterasu_cd"):GetFloat() or 4
SWEP.KamuiEntStart = -SWEP.KamuiEntCD
SWEP.KamuiEntRange = GetConVar("obito_amaterasu_range"):GetFloat() or 2500 --How far can amaterasu ignite targets
SWEP.KamuiEntLength = GetConVar("obito_amaterasu_length"):GetFloat() or 1000 --How long will the target burn
SWEP.KamuiEntDamage = GetConVar("obito_amaterasu_damage"):GetFloat() or 160

SWEP.KamuiSelfCD = 5
SWEP.KamuiSelfStart = -SWEP.KamuiSelfCD
SWEP.KamuiSelfRange = GetConVar("obito_kagutsuchi_range"):GetFloat() or 450 --How far can kagutsuchi go
SWEP.KamuiSelfDamage = GetConVar("obito_kagutsuchi_damage"):GetFloat() or 200

SWEP.CounterCD = GetConVar("obito_counter_cd"):GetFloat() or 8
SWEP.CounterStart = -SWEP.CounterCD
SWEP.CounterDuration = 10
SWEP.CounterDurationStart = 0 --Used for showing how much time left in counter
SWEP.IsInCounter = false

SWEP.SusanooCD = GetConVar("obito_susanoo_cd"):GetFloat() or 10
SWEP.SusanooStart = -SWEP.SusanooCD
SWEP.SusanooActive = false
SWEP.SusanooModel = Model("models/player/susanoo_obito_closewings/susanoo_obito_closewings.mdl") or nil
SWEP.SusanooScale = 4
SWEP.SusanooHealth = GetConVar("obito_susanoo_health"):GetFloat() or 5000

SWEP.SusanooFlightCD =  GetConVar("obito_susanoo_wings_cd"):GetFloat() or 1
SWEP.SusanooFlightStart = -SWEP.SusanooFlightCD
SWEP.SusanooFlightMode = false
SWEP.SusanooWingsModel = Model("models/player/susanoo_obito/susanoo_obito.mdl")

SWEP.SusanooPrimaryCD = GetConVar("obito_susanoo_primary_cd"):GetFloat() or 0.75
SWEP.SusanooPrimaryStart = -SWEP.SusanooPrimaryCD
SWEP.SusanooPrimaryDamage = GetConVar("obito_susanoo_primary_damage"):GetFloat() or 350
SWEP.SusanooPrimaryRange = 850

SWEP.SusanooSecondaryCD = GetConVar("obito_susanoo_secondary_cd"):GetFloat() or 5
SWEP.SusanooSecondaryDamage = GetConVar("obito_susanoo_secondary_damage"):GetFloat() or 550
SWEP.SusanooSecondaryStart = -SWEP.SusanooSecondaryCD

SWEP.SusanooRegenCD = 5
SWEP.SusanooRegenStart = 0
SWEP.SusanooRegenAmount = 50

SWEP.QuoteCD = 2
SWEP.QuoteStart = 0
SWEP.IsInQuote = false

SWEP.ThemeStart = SysTime()

SWEP.IsAttacking = false

--Sounds
local deathSound = Sound("mangekyou_obito/death.wav")
local hurtSound = Sound("mangekyou_obito/hurt.wav")
local hurtSound2 = Sound("mangekyou_obito/hurt2.wav")
local activationShout = Sound("mangekyou_obito/activation.wav")
local activationSound = Sound("sharingan/activation.wav")
local deactivationSound = Sound("sharingan/deactivation.wav")
local kamuiSound = Sound("mangekyou_obito/kamui.wav")
local counterSound = Sound("mangekyou_obito/kamui_counter.wav")
local kamuiTouchSound = Sound("mangekyou_obito/kamui_touch.wav")
local susanooActivateSound = Sound("mangekyou_obito/susanoo_activate.wav")
local susanooDeactivateSound = Sound("mangekyou_obito/susanoo_deactivate.wav")
local wingsActivateSound = Sound("mangekyou_obito/susanoo_wings_activate.wav")
local wingsDeactivateSound = Sound("mangekyou_obito/susanoo_wings_deactivate.wav")
local susanooAttackSound = Sound("mangekyou_obito/susanoo_attack.wav")
local susanooHitSound = Sound("mangekyou_obito/susanoo_hit.wav")
local susanooFallSound = Sound("mangekyou_obito/susanoo_fall.wav")
local susanooStepSound = Sound("susanoo/susanoo_step.wav")
local susanooGrowSound = Sound("susanoo/susanoo_grow.wav")

local themeSound = Sound("mangekyou_obito/obito_theme.mp3")

local quotes = {
    Sound("mangekyou_obito/quotes/quote1.wav"),
    Sound("mangekyou_obito/quotes/quote2.wav")
}

local hurtSounds = {
    hurtSound,
    hurtSound2
}

--Adding custom icon when someone is killed by sharingan
if CLIENT then
    killicon.Add("mangekyou_sharingan_obito", "huds/obito_killicon", Color(255,80,0,255))
end

local kamuiBlackList = {
    ["ba_stand_rewritten"] = true,
    ["ba_thefool"] = true,
    ["kamui_dimension"] = true,
    ["kamuiwall"] = true
}

function SWEP:SetupDataTables()
    self:NetworkVar("Float", 0, "KamuiEntTime")
    self:NetworkVar("Float", 1, "KamuiSelfTime")
    self:NetworkVar("Float", 2, "CounterTime")
    self:NetworkVar("Float", 3, "CounterDurationTime")
    self:NetworkVar("Float", 4, "SusanooSlashTime")
    self:NetworkVar("Float", 5, "SusanooFlightTime")
    self:NetworkVar("Float", 6, "SusanooSecondaryTime")
    self:NetworkVar("String", 0, "DefaultModel")
    self:NetworkVar("Int", 0, "DefaultHealth")
    self:NetworkVar("Int", 1, "SusanooHealth")
    self:NetworkVar("Bool", 0, "IsInKamui")

    if SERVER then
        self:SetSusanooHealth(self.SusanooHealth)
        self:SetIsInKamui(false)
    end
end

function SWEP:Initialize()
    self:SetHoldType(self.HoldType) --Set third person animation

    self:SetKamuiEntTime(-self.KamuiEntCD)
    self:SetKamuiSelfTime(-self.KamuiSelfCD)
    self:SetCounterTime(-self.CounterCD)
    self:SetSusanooSlashTime(-self.SusanooPrimaryCD)
    self:SetSusanooSecondaryTime(-self.SusanooSecondaryCD)
    self:SetSusanooFlightTime(-self.SusanooFlightCD)
end

local function GetKamuiDimension(ply)
	if SERVER then
		if IsValid(KamuiDimension) then
			return KamuiDimension
		end
		local KamuiDimensionWidth = 4600
		local KamuiDimensionLength = 4600
		local KamuiDimensionHeight = 2000
		
		local KamuiDimensionBounds = Vector(-KamuiDimensionWidth/2,-KamuiDimensionLength/2,-KamuiDimensionHeight/2)
		local maxs = -KamuiDimensionBounds
		
		--16384 is the "bounds" for the max map size, so we search between it, taking into account KamuiDimension s.
		local worldBounds = Vector(-16384+KamuiDimensionWidth,-16384+KamuiDimensionLength,-16384+KamuiDimensionHeight)
		local KamuiDimensionPos = Vector(0,0,-worldBounds.z)
		local tr = {
			mins = KamuiDimensionBounds,
			maxs = maxs,
		}
		
		while tr != nil and KamuiDimensionWidth > 500 and KamuiDimensionLength > 500 and KamuiDimensionHeight > 500 do
			while KamuiDimensionPos.z > -16384 do
				tr.start = Vector(math.random(worldBounds.x,-worldBounds.x),math.random(worldBounds.x,-worldBounds.x),KamuiDimensionPos.z)
				tr.endpos = tr.start
				if util.IsInWorld(tr.start) and !util.TraceHull(tr).Hit then
					KamuiDimensionPos = tr.start
					tr = nil
					break
				end
				KamuiDimensionPos.z = KamuiDimensionPos.z - 1
			end
			KamuiDimensionWidth = KamuiDimensionWidth-100
			KamuiDimensionLength = KamuiDimensionLength-100
			KamuiDimensionHeight = KamuiDimensionHeight-100
		end
		if tr then
			return NULL
		end
		
		local floor = ents.Create("kamuiwall")
        floor:SetWidth(KamuiDimensionWidth)
        floor:SetLength(KamuiDimensionLength)
        floor:SetHeight(100)
        floor:SetPos(KamuiDimensionPos+vector_up*-(KamuiDimensionHeight/2+floor:GetHeight()/2))
        floor:Spawn()
        floor:Activate()
        
        local ceiling = ents.Create("kamuiwall")
        ceiling:SetWidth(KamuiDimensionWidth)
        ceiling:SetLength(KamuiDimensionLength)
        ceiling:SetHeight(100)
        ceiling:SetPos(KamuiDimensionPos+vector_up*(KamuiDimensionHeight/2+ceiling:GetHeight()/5))
        ceiling:SetAngles(Angle(0,0,180))
        ceiling:Spawn()
        ceiling:Activate()
        
        local wallRight = ents.Create("kamuiwall")
        wallRight:SetWidth(KamuiDimensionWidth)
        wallRight:SetLength(KamuiDimensionHeight)
        wallRight:SetHeight(100)
        wallRight:SetPos(KamuiDimensionPos+Vector(-KamuiDimensionWidth/2-wallRight:GetHeight()/2,0,0))
        wallRight:SetAngles(Angle(0,90,90))
        wallRight:Spawn()
        wallRight:Activate()
        
        local wallLeft = ents.Create("kamuiwall")
        wallLeft:SetWidth(KamuiDimensionWidth)
        wallLeft:SetLength(KamuiDimensionHeight)
        wallLeft:SetHeight(100)
        wallLeft:SetPos(KamuiDimensionPos+Vector(KamuiDimensionWidth/2+wallLeft:GetHeight()/2,0,0))
        wallLeft:SetAngles(Angle(0,270,90))
        wallLeft:Spawn()
        wallLeft:Activate()
        
        local wallBack = ents.Create("kamuiwall")
        wallBack:SetWidth(KamuiDimensionWidth)
        wallBack:SetLength(KamuiDimensionHeight)
        wallBack:SetHeight(100)
        wallBack:SetPos(KamuiDimensionPos+Vector(0,KamuiDimensionLength/2+wallBack:GetHeight()/2,0))
        wallBack:SetAngles(Angle(0,0,90))
        wallBack:Spawn()
        wallBack:Activate()
        
        local wallFront = ents.Create("kamuiwall")
        wallFront:SetWidth(KamuiDimensionWidth)
        wallFront:SetLength(KamuiDimensionHeight)
        wallFront:SetHeight(100)
        wallFront:SetPos(KamuiDimensionPos+Vector(0,-KamuiDimensionLength/2-wallFront:GetHeight()/2,0))
        wallFront:SetAngles(Angle(0,180,90))
        wallFront:Spawn()
        wallFront:Activate()
		
		local KamuiDimensionRoom = ents.Create("kamui_dimension")
		KamuiDimensionRoom:SetWidth(KamuiDimensionWidth)
		KamuiDimensionRoom:SetLength(KamuiDimensionLength)
		KamuiDimensionRoom:SetHeight(KamuiDimensionHeight)
		KamuiDimensionRoom:SetPos(KamuiDimensionPos+vector_up*(KamuiDimensionHeight/1.68+ceiling:GetHeight()/2))
		KamuiDimensionRoom:Spawn()
		KamuiDimensionRoom:Activate()
        KamuiDimensionRoom:AddWall(ceiling)
        KamuiDimensionRoom:AddWall(floor)
        KamuiDimensionRoom:AddWall(wallLeft)
        KamuiDimensionRoom:AddWall(wallRight)
        KamuiDimensionRoom:AddWall(wallFront)
        KamuiDimensionRoom:AddWall(wallBack)
		
		KamuiDimension = KamuiDimensionRoom
		return KamuiDimension
	end
end

function SendToKamuiDimension(ent)
	local rand = VectorRand()
	rand.z = 1
	local tr = util.TraceLine({
		start = KamuiDimension:GetPos() + Vector(0,0,500),
		endpos = KamuiDimension:GetPos() - rand * 800,
		filter = function(ent) if ent == KamuiDimension then return true else return false end end
		})

    ent:SetPos(tr.HitPos - tr.Normal * 100)

    local phys = ent:GetPhysicsObject()
    if IsValid(phys) then
        phys:SetPos(tr.HitPos - tr.Normal * 100)
    end

    ent:PhysWake()
end

function SWEP:Deploy()
    local player = self:GetOwner()

    if SERVER then
        local KamuiDimension = GetKamuiDimension(player)

        if not IsValid(KamuiDimension) then
            player:ChatPrint("This map is too small for kamui dimension to work.")
        end
    end

    if SERVER then
        if player:Health() == 100 or player:Health() == player:GetMaxHealth() then
            if self.HasRinnegan then
                player:SetHealth(self.BaseHealth * 1.25)
                player:SetMaxHealth(self.BaseHealth * 1.25)
                player:SetArmor(30)
            else
                player:SetHealth(self.BaseHealth)
                player:SetMaxHealth(self.BaseHealth)
                player:SetArmor(25)
            end
        end
    end

    if SERVER then
        if player:GetInfoNum("obito_theme", 0) == 1 then
            player:PlayClientSound(themeSound, 75, 100, 0.15)
            self.ThemeStart = SysTime()
        end
    end
    player:StopSound(deactivationSound)

    if player:GetInfoNum("obito_voice", 1) == 1 then
        if SERVER then
            player:EmitSound(activationShout)
        end
    
        timer.Create("Obito_Activation " .. player:Nick(), SoundDuration(activationShout), 1, function()
            if IsValid(self) and IsValid(player) then
                self:EmitSound(activationSound)
    
                --Set sharingan eye on model if having the obito model
                if player:GetInfoNum("obito_eye_change", 1) == 1 then
                    if player:GetModel() == "models/obitoall/obitoall.mdl" then
                        player:SetBodygroup(5, 2)
                    end
                end
            end
        end)
    else
        self:EmitSound(activationSound)

        --Set sharingan eye on model if having the obito model
        if player:GetInfoNum("obito_eye_change", 1) == 1 then
            if player:GetModel() == "models/obitoall/obitoall.mdl" then
                player:SetBodygroup(3, 2)
            end
        end
    end
end

function SWEP:Holster()
    if self.IsAttacking or self.IsInCounter or self.SusanooActive then
        return false
    else
        local player = self:GetOwner()
        timer.Remove("Obito_Activation " .. player:Nick())

        if SERVER then
            player:StopClientSound(themeSound)
        end

        player:StopSound(activationShout)
        if SERVER then
            player:EmitSound(deactivationSound, 75, 100, 0.45)
        end
        if player:GetInfoNum("obito_eye_change", 1) == 1 then
            player:SetBodygroup(5, 0)
        end

        return true
    end
end

function SWEP:Think()
    local player = self:GetOwner()
    
    --Settting convars
    self.KamuiEntCD = GetConVar("obito_amaterasu_cd"):GetFloat() or 7.5
    self.KamuiEntRange = GetConVar("obito_amaterasu_range"):GetFloat() or 1250
    self.KamuiEntLength = GetConVar("obito_amaterasu_length"):GetFloat() or 1000
    self.KamuiEntDamage = GetConVar("obito_amaterasu_damage"):GetFloat() or 75
    self.KamuiSelfCD = 5
    self.KamuiSelfRange = GetConVar("obito_kagutsuchi_range"):GetFloat() or 450
    self.KamuiSelfDamage = GetConVar("obito_kagutsuchi_damage"):GetFloat() or 200
    self.CounterCD = GetConVar("obito_counter_cd"):GetFloat() or 7
    self.CounterDuration = 10
    self.SusanooCD = GetConVar("obito_susanoo_cd"):GetFloat() or 10
    self.SusanooHealth = GetConVar("obito_susanoo_health"):GetFloat() or 3500
    self.SusanooFlightCD =  GetConVar("obito_susanoo_wings_cd"):GetFloat() or 1
    self.SusanooPrimaryCD = GetConVar("obito_susanoo_primary_cd"):GetFloat() or 0.75
    self.SusanooPrimaryDamage = GetConVar("obito_susanoo_primary_damage"):GetFloat() or 350
    self.SusanooSecondaryCD = GetConVar("obito_susanoo_secondary_cd"):GetFloat() or 5
    self.SusanooSecondaryDamage = GetConVar("obito_susanoo_secondary_damage"):GetFloat() or 550

    if SERVER then
        if not IsValid(KamuiDimension) and self:GetIsInKamui() then
            player.IsInKamui = false
            self:SetIsInKamui(false)
        end
    end

    --Susanoo Health Regen
    if SERVER then
        if not self.SusanooActive and self:GetSusanooHealth() < self.SusanooHealth then
            if CurTime() - self.SusanooRegenStart >= self.SusanooRegenCD then
                self.SusanooRegenStart = CurTime()

                self:SetSusanooHealth(math.Clamp(self:GetSusanooHealth() + self.SusanooRegenAmount, 0, self.SusanooHealth))
            end
        end
    end

    --Theme Handling
    if SERVER then
        if SysTime() - self.ThemeStart >= 115 and player:GetInfoNum("obito_theme", 0) == 1 then
            self.ThemeStart = SysTime()
            player:PlayClientSound(themeSound, 75, 100, 0.15)
        end
    end

    if SERVER then
        if self.IsInCounter then
            MS_StopAmaterasu(player)
        end
    end

    --Armor
    if SERVER then
        if not self.SusanooActive then
            if self:GetOwner():Armor() < 25 then
                self:GetOwner():SetArmor(25)
            end
        else
            if self:GetOwner():Armor() < 100 then
                self:GetOwner():SetArmor(40)
            end
        end
    end
end

function SWEP:PrimaryAttack()
    if SERVER then
        if CurTime() - self.KamuiEntStart >= self.KamuiEntCD and not self.IsAttacking and not self.SusanooActive then
            local player = self:GetOwner()

            player:LagCompensation(true)

            local traceEnt = player:GetEyeTrace().Entity
            local distance = player:GetPos():Distance(traceEnt:GetPos())

            if traceEnt:IsValid() and not traceEnt:IsWorld() and not kamuiBlackList[traceEnt:GetClass()] and IsValid(KamuiDimension) then
                if distance <= 200 and not player:KeyDown(IN_WALK) then

                    local lastHeldDuck = false

                    if player:KeyDown(IN_DUCK) then
                        lastHeldDuck = true
                    end

                    local tracePos = player:GetEyeTrace().HitPos
                    player:Freeze(true)
                    if traceEnt:IsPlayer() then
                        traceEnt:Freeze(true)
                    elseif traceEnt:IsNPC() then
                        traceEnt:AddFlags(FL_FROZEN)
                    end
        
                    local effectdata = EffectData()
                    effectdata:SetEntity(player)
                    effectdata:SetOrigin(player:GetPos() + player:GetUp() * 60 + player:GetForward())
                    util.Effect("vm_distort_in", effectdata, true, true)

                    player:EmitSound(kamuiSound, 75, 100, 2)

                    timer.Simple(0.85, function()
                        if IsValid(player) and IsValid(traceEnt) then
                            self.KamuiEntStart = CurTime() - self.KamuiEntCD / 2
                            self:SetKamuiEntTime(CurTime() - self.KamuiEntCD / 2)

                            if KamuiDimension:PositionInside(traceEnt:GetPos()) then
                                if lastHeldDuck then
                                    traceEnt:SetPos(traceEnt.LastKamuiPos or (player.LastKamuiPos or Vector(0,0,0)))

                                    local phys = traceEnt:GetPhysicsObject()
                                    if IsValid(phys) then
                                        phys:SetPos(traceEnt.LastKamuiPos or (player.LastKamuiPos or Vector(0,0,0)))
                                    end
                                else
                                    traceEnt:SetPos(player.LastKamuiPos or Vector(0,0,0))

                                    local phys = traceEnt:GetPhysicsObject()
                                    if IsValid(phys) then
                                        phys:SetPos(player.LastKamuiPos or Vector(0,0,0))
                                    end
                                end
                            else
                                traceEnt.LastKamuiPos = traceEnt:GetPos()
                                SendToKamuiDimension(traceEnt)
                            end
                                    
                            local effectdata = EffectData()
                            effectdata:SetOrigin(traceEnt:GetPos() + traceEnt:GetUp())
                            effectdata:SetEntity(traceEnt)
                            util.Effect("vm_distort_in", effectdata, true, true)

                            player:Freeze(false)
                            if traceEnt:IsPlayer() then
                                traceEnt:Freeze(false)
                            elseif traceEnt:IsNPC() then
                                traceEnt:RemoveFlags(FL_FROZEN)
                            end
                        elseif IsValid(player) and not IsValid(traceEnt) then
                            self.KamuiEntStart = CurTime()
                            self:SetKamuiEntTime(CurTime())

                            player:Freeze(false)
                        elseif not IsValid(player) and IsValid(traceEnt) then
                            if traceEnt:IsPlayer() then
                                traceEnt:Freeze(false)
                            elseif traceEnt:IsNPC() then
                                traceEnt:RemoveFlags(FL_FROZEN)
                            end
                        end
                    end)
                elseif distance <= 2500 and player:KeyDown(IN_WALK) then
                    player:Freeze(true)

                    local effectdata = EffectData()
                    effectdata:SetEntity(player)
                    effectdata:SetOrigin(player:GetPos() + player:GetUp() * 60 + player:GetForward())
                    util.Effect("vm_distort_in", effectdata, true, true)

                    local effectdata2 = EffectData()
                    effectdata2:SetEntity(traceEnt)
                    effectdata2:SetOrigin(traceEnt:GetPos())
                    util.Effect("vm_distort", effectdata2, true, true)

                    player:EmitSound(kamuiSound, 75, 100, 2)
                    traceEnt:EmitSound(kamuiSound, 75, 100, 2)

                    timer.Simple(1.55, function()
                        if IsValid(player) and IsValid(traceEnt) then
                            self.KamuiEntStart = CurTime() + self.KamuiEntCD / 2
                            self:SetKamuiEntTime(CurTime() + self.KamuiEntCD / 2)
                            player:Freeze(false)

                            local damageInfo = DamageInfo()
                            damageInfo:SetDamageType(bit.bor(DMG_DISSOLVE, DMG_PREVENT_PHYSICS_FORCE))
                            damageInfo:SetDamage(200)
                            damageInfo:SetAttacker(player or eyeHit)
                            damageInfo:SetInflictor(self or player)
                            damageInfo:SetDamageForce(player:EyePos())
                            traceEnt:TakeDamageInfo(damageInfo)

                        elseif IsValid(player) and not IsValid(traceEnt) then
                            self.KamuiEntStart = CurTime() + self.KamuiEntCD / 2
                            self:SetKamuiEntTime(CurTime() + self.KamuiEntCD / 2)

                            player:Freeze(false)
                        end
                    end)
                end
            end

            player:LagCompensation(false)
        end
    end
end

function SWEP:SecondaryAttack()
    if SERVER then
        local player = self:GetOwner()
        if IsValid(player) and CurTime() - self.KamuiSelfStart >= self.KamuiSelfCD and not self.IsAttacking and not self.SusanooActive then
            if not player:KeyDown(IN_WALK) then
                self.IsAttacking = true
                
                local tracePos = player:GetEyeTrace().HitPos
                player:Freeze(true)
    
                local effectdata = EffectData()
                effectdata:SetEntity(player)
                effectdata:SetOrigin(player:GetPos() + player:GetUp() * 60 + player:GetForward() * 5)
                util.Effect("vm_distort", effectdata, true, true)
    
                timer.Simple(0.75, function()
                    player:ScreenFade(SCREENFADE.OUT, Color(0,0,0), 0.35, 0.3)
                end)
    
                player:EmitSound(kamuiSound, 75, 100, 2)
    
                timer.Simple(1, function()
                    if IsValid(self) and IsValid(player) then
                        player:SetPos(tracePos)
        
                        self.KamuiSelfStart = CurTime()
                        self:SetKamuiSelfTime(CurTime())
                        
                        local traceData = {
                            start = player:GetPos(),
                            endpos = start,
                            maxs = player:OBBMaxs(),
                            mins = player:OBBMins(),
                            filter = player
                        }
                        
                        local trace = util.TraceHull(traceData)
                        
                        if trace.Hit then
                            local tr = self.Owner:GetEyeTrace()
                            player:SetPos(player:GetPos() - (tr.Normal * (player:BoundingRadius() * 2.25)))
                        end
        
                        player:ScreenFade(SCREENFADE.IN, Color(0,0,0), 0.45, 0.5)
        
                        local effectdata = EffectData()
                        effectdata:SetOrigin(player:GetPos() + player:GetUp() * 60 + player:GetForward() * 5)
                        effectdata:SetEntity(player)
                        util.Effect("vm_distort_in", effectdata, true, true)
        
                        timer.Simple(0.75, function()
                            if IsValid(player) then
                                player:Freeze(false)
                                self.IsAttacking = false
                            end
                        end)
                    end
                end)
            elseif player:KeyDown(IN_WALK) and IsValid(KamuiDimension) then
                self.IsAttacking = true
    
                local effectdata = EffectData()
                effectdata:SetEntity(player)
                effectdata:SetOrigin(player:GetPos() + player:GetUp() * 60 + player:GetForward() * 5)
                util.Effect("vm_distort", effectdata, true, true)
    
                timer.Simple(0.75, function()
                    player:ScreenFade(SCREENFADE.OUT, Color(0,0,0), 0.35, 0.3)
                end)
    
                player:EmitSound(kamuiSound, 75, 100, 2)
    
                timer.Simple(1, function()
                    if IsValid(self) and IsValid(player) then
                        if IsValid(KamuiDimension) then
                            if not KamuiDimension:PositionInside(player:GetPos()) then
                                player.LastKamuiPos = player:GetPos()
                                SendToKamuiDimension(player)
                                player.InsideKamui = true
                                self:SetIsInKamui(true)
                            else
                                player:SetPos(player.LastKamuiPos or Vector(0,0,0))
                                player.InsideKamui = false
                                self:SetIsInKamui(false)
                            end
                        else
                            player:SetPos(player.LastKamuiPos or Vector(0,0,0))
                            player.InsideKamui = false
                            self:SetIsInKamui(false)
                        end
        
                        self.KamuiSelfStart = CurTime()
                        self:SetKamuiSelfTime(CurTime())
        
                        player:ScreenFade(SCREENFADE.IN, Color(0,0,0), 0.45, 0.5)
        
                        local effectdata = EffectData()
                        effectdata:SetOrigin(player:GetPos() + player:GetUp() * 60 + player:GetForward() * 5)
                        effectdata:SetEntity(player)
                        util.Effect("vm_distort_in", effectdata, true, true)
        
                        timer.Simple(0.75, function()
                            if IsValid(player) then
                                player:Freeze(false)
                                self.IsAttacking = false
                            end
                        end)
                    end
                end)
            end
        end
    end
end

function SWEP:Reload()
    if CurTime() - self.CounterStart >= self.CounterCD and not self.IsInCounter and not self.SusanooActive then
        local player = self:GetOwner()
        if not self:GetIsInKamui() then
            self.CounterDurationStart = CurTime()
            self:SetCounterDurationTime(CurTime())
            self.CounterStart = CurTime()
            self:SetCounterTime(CurTime())

            self.IsInCounter = true
            self.IsAttacking = true
            
            player:CollisionRulesChanged()
            player:SetCustomCollisionCheck(true)
            if SERVER then
                player:EmitSound(counterSound)
            end
    
            player.KamuiCounter = true
            player:CollisionRulesChanged()
    
            if SERVER then
                if player.IsOnAmaterasu then
                    MS_StopAmaterasu(player)
                end
            end
            
            timer.Create("Obito Counter " .. player:Nick(), self.CounterDuration, 1, function()
                if IsValid(player) then
                    player:CollisionRulesChanged()
                    self.CounterStart = CurTime()
                    self:SetCounterTime(CurTime())
    
                    self.IsInCounter = false
                    self.IsAttacking = false
                    player.KamuiCounter = false
                    player:CollisionRulesChanged()
                end
            end)
        end
    elseif CurTime() - self.CounterStart >= 0.5 and self.IsInCounter and self:GetOwner().KamuiCounter then
        self.CounterStart = CurTime()
        self:SetCounterTime(CurTime())

        local player = self:GetOwner()

        player:CollisionRulesChanged()
        self.IsInCounter = false
        self.IsAttacking = false
        player.KamuiCounter = false

        timer.Remove("Obito Counter " .. player:Nick())

        if SERVER then
            player:EmitSound(counterSound)
        end
    end
end

function SWEP:DrawHUD()
    if GetConVar("obito_disableHud"):GetInt() == 0 then
        local amaterasuEYE = {
            texture = surface.GetTextureID("huds/obito"),
            x = ScrW() / 1.045,
            y = ScrH() / 2,
            w = relativeW(64),
            h = relativeH(64)
        }

        local kagutsuchiEYE = {
            texture = surface.GetTextureID("huds/obito"),
            x = ScrW() / 1.045,
            y = ScrH() / 1.75,
            w = relativeW(64),
            h = relativeH(64)
        }
        local counterEYE = {
            texture = surface.GetTextureID("huds/obito"),
            x = ScrW() / 1.045,
            y = ScrH() / 1.56,
            w = relativeW(64),
            h = relativeH(64)
        }

        local susanoo = {
            texture = surface.GetTextureID("huds/susanoo"),
            x = ScrW() / 1.045,
            y = ScrH() / 1.40,
            w = relativeW(64),
            h = relativeH(64)
        }

        local susanooNoWings = {
            texture = surface.GetTextureID("huds/susanoo_no_wings"),
            x = ScrW() / 1.045,
            y = ScrH() / 1.40,
            w = relativeW(64),
            h = relativeH(64)
        }
    
        --Kamui Ent/Susanoo Slas HUD
        draw.NoTexture()
        surface.SetDrawColor(GetConVar("obito_r"):GetInt(), GetConVar("obito_g"):GetInt(), GetConVar("obito_b"):GetInt(), 255)
        if self.SusanooActive then
            draw.SimpleText("Slash", "NarutoFont", ScrW() / 1.13, ScrH() / 1.92)
            draw.Circle(ScrW() / 1.0273, ScrH() / 1.8875, Lerp((CurTime() - self:GetSusanooSlashTime()) / self.SusanooPrimaryCD, 0, relativeW(31)), 64)
        else
            draw.SimpleText("Kamui Ent", "NarutoFont", ScrW() / 1.13, ScrH() / 1.92)
            draw.Circle(ScrW() / 1.0273, ScrH() / 1.8875, Lerp((CurTime() - self:GetKamuiEntTime()) / self.KamuiEntCD, 0, relativeW(31)), 64)
        end
        draw.TexturedQuad(amaterasuEYE)

        --Kamui Self HUD
        draw.NoTexture()
        surface.SetDrawColor(GetConVar("obito_r"):GetInt(), GetConVar("obito_g"):GetInt(), GetConVar("obito_b"):GetInt(), 255)
        if self.SusanooActive then
            draw.SimpleText("Sword Throw", "NarutoFont", ScrW() / 1.13, ScrH() / 1.685)
            draw.Circle(ScrW() / 1.0273, ScrH() / 1.665, Lerp((CurTime() - self:GetSusanooSecondaryTime()) / self.SusanooSecondaryCD, 0, relativeW(31)), 64)
        else
            draw.SimpleText("Kamui Self", "NarutoFont", ScrW() / 1.13, ScrH() / 1.685)
            draw.Circle(ScrW() / 1.0273, ScrH() / 1.665, Lerp((CurTime() - self:GetKamuiSelfTime()) / self.KamuiSelfCD, 0, relativeW(31)), 64)
        end
        draw.TexturedQuad(kagutsuchiEYE)

        --Counter HUD
        draw.NoTexture()
        surface.SetDrawColor(GetConVar("obito_r"):GetInt(), GetConVar("obito_g"):GetInt(), GetConVar("obito_b"):GetInt(), 255)
        if self.SusanooActive then
            if self.SusanooFlightMode then
                draw.SimpleText("Normal Mode", "NarutoFont", ScrW() / 1.13, ScrH() / 1.51)
            else
                draw.SimpleText("Fly Mode", "NarutoFont", ScrW() / 1.13, ScrH() / 1.51)
            end
            draw.Circle(ScrW() / 1.0273, ScrH() / 1.492, Lerp((CurTime() - self:GetSusanooFlightTime()) / self.SusanooFlightCD, 0, relativeW(31)), 64)
        else
            draw.SimpleText("Counter", "NarutoFont", ScrW() / 1.13, ScrH() / 1.51)
            if self.IsInCounter then
                draw.Circle(ScrW() / 1.0273, ScrH() / 1.492, Lerp((CurTime() - self:GetCounterDurationTime()) / self.CounterDuration, relativeW(31), 0), 64)
            else
                draw.Circle(ScrW() / 1.0273, ScrH() / 1.492, Lerp((CurTime() - self:GetCounterTime()) / self.CounterCD, 0, relativeW(31)), 64)
            end
        end
        draw.TexturedQuad(counterEYE)

        --Susanoo HUD
        if self.SusanooActive then
            draw.NoTexture()
            draw.SimpleText("Susanoo", "NarutoFont", ScrW() / 1.13, ScrH() / 1.37)
            if self.SusanooFlightMode then
                surface.SetDrawColor(GetConVar("obito_r"):GetInt(), GetConVar("obito_g"):GetInt(), GetConVar("obito_b"):GetInt(), 255)
                draw.TexturedQuad(susanoo)
            else
                surface.SetDrawColor(GetConVar("obito_r"):GetInt(), GetConVar("obito_g"):GetInt(), GetConVar("obito_b"):GetInt(), 255)
                draw.TexturedQuad(susanooNoWings)
            end
        end
    end
end

hook.Add("ShouldCollide", "KamuiCollision", function(ent1, ent2)
    if ent1.KamuiCounter or ent2.KamuiCounter then
        return false
    end     
end)

hook.Add("EntityTakeDamage", "ObitoTakeDamage", function(entity, dmg)
    if IsValid(entity) and entity:IsPlayer() then
        if entity:MS_UsingObito() then
            local weapon = entity:GetActiveWeapon()

            --Counter Handling
            if weapon.IsInCounter then
                local attacker = dmg:GetAttacker()
                if IsValid(attacker) then
                    entity:EmitSound(kamuiTouchSound)
                end
                return true
            end
        end
    end
end)

hook.Add("DoPlayerDeath", "ObitoDeath", function(victim, inflict, attacker)
    if victim:IsPlayer() then
        victim.IsInKamui = false

        victim:StopClientSound(themeSound)
    end
end)