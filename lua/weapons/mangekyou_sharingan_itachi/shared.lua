AddCSLuaFile()

SWEP.PrintName = "Itachi Sharingan"
SWEP.Author = "Tomik"
SWEP.Purpose = "Use the mighty powers of itachi's mangekyou sharingan"
SWEP.Instructions = "--Normal Mode--\nLMB - Amaterasu\nLMB + ALT - Extinguish target\nLMB + CTRL - Extinguish yourself\nRMB - Tsukuyomi\nR - Counter \nB - Susano'o \n\n--Susano'o Mode--\nLMB - Slash\nRMB - Throw Sword\nR - Wings\nB - Disable Susano'o\nPassive - No damage from bullets\nPassive - Tsukuyomi does not effect susanoo\nPassive - When you land, you deal damage to entities in range"
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
    SWEP.WepSelectIcon = surface.GetTextureID("huds/itachi_select")
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

SWEP.AmaterasuCD = GetConVar("itachi_amaterasu_cd"):GetFloat() or 7.5
SWEP.AmaterasuStart = -SWEP.AmaterasuCD
SWEP.AmaterasuRange = GetConVar("itachi_amaterasu_range"):GetFloat() or 1250 --How far can amaterasu ignite targets
SWEP.AmaterasuLength = GetConVar("itachi_amaterasu_length"):GetFloat() or 1000 --How long will the target burn
SWEP.AmaterasuDamage = GetConVar("itachi_amaterasu_damage"):GetFloat() or 75

SWEP.TsukuyomiCD = GetConVar("itachi_tsukuyomi_cd"):GetFloat() or 20
SWEP.TsukuyomiStart = -SWEP.TsukuyomiCD
SWEP.TsukuyomiRange = GetConVar("itachi_tsukuyomi_range"):GetFloat() or 450 --How far can tsukuyomi go
SWEP.TsukuyomiDamage = GetConVar("itachi_tsukuyomi_damage"):GetFloat() or 200

SWEP.CounterCD = GetConVar("itachi_counter_cd"):GetFloat() or 7
SWEP.CounterStart = -SWEP.CounterCD
SWEP.CounterDuration = GetConVar("itachi_counter_duration"):GetFloat() or 5
SWEP.CounterDurationStart = 0 --Used for showing how much time left in counter
SWEP.IsInCounter = false

SWEP.SusanooCD = GetConVar("itachi_susanoo_cd"):GetFloat() or 10
SWEP.SusanooStart = -SWEP.SusanooCD
SWEP.SusanooActive = false
SWEP.SusanooModel = Model("models/player/itachi_susanoo_closewings/itachi_susanoo_closewings.mdl") or nil
SWEP.SusanooScale = 4
SWEP.SusanooHealth = GetConVar("itachi_susanoo_health"):GetFloat() or 3500

SWEP.SusanooFlightCD =  GetConVar("itachi_susanoo_wings_cd"):GetFloat() or 1
SWEP.SusanooFlightStart = -SWEP.SusanooFlightCD
SWEP.SusanooFlightMode = false
SWEP.SusanooWingsModel = Model("models/player/itachi_susanoo/itachi_susanoo.mdl")

SWEP.SusanooPrimaryCD = GetConVar("itachi_susanoo_primary_cd"):GetFloat() or 0.75
SWEP.SusanooPrimaryStart = -SWEP.SusanooPrimaryCD
SWEP.SusanooPrimaryDamage = GetConVar("itachi_susanoo_primary_damage"):GetFloat() or 350
SWEP.SusanooPrimaryRange = 500

SWEP.SusanooSecondaryCD = GetConVar("itachi_susanoo_secondary_cd"):GetFloat() or 5
SWEP.SusanooSecondaryStart = -SWEP.SusanooSecondaryCD
SWEP.SusanooSecondaryDamage = GetConVar("itachi_susanoo_secondary_damage"):GetFloat() or 550

SWEP.SusanooRegenCD = 5
SWEP.SusanooRegenStart = 0
SWEP.SusanooRegenAmount = 50

SWEP.QuoteCD = 2
SWEP.QuoteStart = 0
SWEP.IsInQuote = false

SWEP.ThemeStart = CurTime()

SWEP.IsAttacking = false
SWEP.SusanooHasSword = true

SWEP.CrowModeActive = false
SWEP.CrowModeCD = 5
SWEP.CrowModeStart = 0

--Sounds
local deathSound = Sound("mangekyou_itachi/death.wav")
local hurtSound = Sound("mangekyou_itachi/hurt.wav")
local hurtSound2 = Sound("mangekyou_itachi/hurt2.wav")
local activationShout = Sound("mangekyou_itachi/activation.wav")
local activationSound = Sound("sharingan/activation.wav")
local deactivationSound = Sound("sharingan/deactivation.wav")
local amaterasuSound = Sound("mangekyou_itachi/amaterasu.wav")
local amaterasuHitSound = Sound("mangekyou_itachi/amaterasu_hit.wav")
local amaterasuShoutSound = Sound("mangekyou_itachi/amaterasu_shout.wav")
local tsukuyomiTrappedSound = Sound("mangekyou_itachi/tsukuyomi_trapped.wav")
local counterSound = Sound("mangekyou_itachi/counter.wav")
local susanooActivateSound = Sound("mangekyou_itachi/susanoo_activate.wav")
local susanooDeactivateSound = Sound("mangekyou_itachi/susanoo_deactivate.wav")
local wingsActivateSound = Sound("mangekyou_itachi/susanoo_wings_activate.wav")
local wingsDeactivateSound = Sound("mangekyou_itachi/susanoo_wings_deactivate.wav")
local susanooAttackSound = Sound("mangekyou_itachi/susanoo_attack.wav")
local susanooHitSound = Sound("mangekyou_itachi/susanoo_hit.wav")
local susanooFallSound = Sound("mangekyou_itachi/susanoo_fall.wav")
local susanooStepSound = Sound("susanoo/susanoo_step.wav")
local susanooGrowSound = Sound("susanoo/susanoo_grow.wav")

local themeSound = Sound("mangekyou_itachi/itachi_theme.mp3")

local quotes = {
    Sound("mangekyou_itachi/quotes/quote1.wav"),
    Sound("mangekyou_itachi/quotes/quote2.wav")
}

local hurtSounds = {
    hurtSound,
    hurtSound2
}

local amaterasuBlackList = {
    ["ba_stand_rewritten"] = true,
    ["ba_thefool"] = true,
    ["kamui_dimension"] = true,
    ["kamuiwall"] = true
}

--Adding custom icon when someone is killed by sharingan
if CLIENT then
    killicon.Add("mangekyou_sharingan_itachi", "huds/itachi_killicon", Color(255,80,0,255))
end

function SWEP:SetupDataTables()
    self:NetworkVar("Float", 0, "AmaterasuTime")
    self:NetworkVar("Float", 1, "TsukuyomiTime")
    self:NetworkVar("Float", 2, "CounterTime")
    self:NetworkVar("Float", 3, "CounterDurationTime")
    self:NetworkVar("Float", 4, "SusanooSlashTime")
    self:NetworkVar("Float", 5, "SusanooFlightTime")
    self:NetworkVar("Float", 6, "SusanooSecondaryTime")
    self:NetworkVar("Float", 7, "CrowModeTime")
    self:NetworkVar("String", 0, "DefaultModel")
    self:NetworkVar("Int", 0, "DefaultHealth")
    self:NetworkVar("Int", 1, "SusanooHealth")

    self:SetSusanooHealth(self.SusanooHealth)
end

function SWEP:Initialize()
    self:SetHoldType(self.HoldType) --Set third person animation

    self:SetAmaterasuTime(-self.AmaterasuCD)
    self:SetTsukuyomiTime(-self.TsukuyomiCD)
    self:SetCounterTime(-self.CounterCD)
    self:SetSusanooSlashTime(-self.SusanooPrimaryCD)
    self:SetSusanooSecondaryTime(-self.SusanooSecondaryCD)
    self:SetSusanooFlightTime(-self.SusanooFlightCD)
end

function SWEP:Deploy()
    local player = self:GetOwner()

    if SERVER then
        if not util.IsValidModel(self.SusanooModel) then
            player:ChatPrint("Susanoo model has not been found. Please check if you have the susanoo model pack. More on the addon page.")
        end
    end

    if SERVER then
        if player:Health() == 100 then
            player:SetHealth(500)
            player:SetArmor(25)
        end
    end

    if SERVER then
        if player:GetInfoNum("itachi_theme", 0) == 1 then
            player:PlayClientSound(themeSound, 75, 100, 0.25)
            self.ThemeStart = CurTime()
        end
    end
    self:StopSound(deactivationSound)

    if player:GetInfoNum("itachi_voice", 1) == 1 then
        if SERVER then
            player:EmitSound(activationShout)
        end
    
        timer.Create("Itachi_Activation " .. player:Nick(), SoundDuration(activationShout), 1, function()
            if IsValid(self) and IsValid(player) then
                self:EmitSound(activationSound)
    
                --Set sharingan eye on model if having the itachi model
                if player:GetInfoNum("itachi_eye_change", 1) == 1 then
                    if player:GetModel() == "models/player/ita/itachi_uchiha.mdl" then
                        player:SetBodygroup(3, 2)
                    end
                end
            end
        end)
    else
        self:EmitSound(activationSound)

        --Set sharingan eye on model if having the itachi model
        if player:GetInfoNum("itachi_eye_change", 1) == 1 then
            if player:GetModel() == "models/player/ita/itachi_uchiha.mdl" then
                player:SetBodygroup(3, 2)
            end
        end
    end
end

function SWEP:Holster()
    if IsValid(self) and self.IsAttacking or self.IsInCounter or self.SusanooActive then
        return false
    elseif IsValid(self) then
        local player = self:GetOwner()
        timer.Remove("Itachi_Activation " .. player:Nick())

        if SERVER then
            player:StopClientSound(themeSound)
        end

        player:StopSound(activationShout)
        if SERVER then
            player:EmitSound(deactivationSound, 75, 100, 0.45)
        end
        if player:GetInfoNum("itachi_eye_change", 1) == 1 then
            if player:GetModel() == "models/player/ita/itachi_uchiha.mdl" then
                player:SetBodygroup(3, 0)
            end
        end
        return true
    end
end

function SWEP:Think()
    local player = self:GetOwner()
    --Settting convars
    self.AmaterasuCD = GetConVar("itachi_amaterasu_cd"):GetFloat() or 7.5
    self.AmaterasuRange = GetConVar("itachi_amaterasu_range"):GetFloat() or 1250
    self.AmaterasuLength = GetConVar("itachi_amaterasu_length"):GetFloat() or 1000
    self.AmaterasuDamage = GetConVar("itachi_amaterasu_damage"):GetFloat() or 75
    self.TsukuyomiCD = GetConVar("itachi_tsukuyomi_cd"):GetFloat() or 20
    self.TsukuyomiRange = GetConVar("itachi_tsukuyomi_range"):GetFloat() or 450
    self.TsukuyomiDamage = GetConVar("itachi_tsukuyomi_damage"):GetFloat() or 200
    self.CounterCD = GetConVar("itachi_counter_cd"):GetFloat() or 7
    self.CounterDuration = GetConVar("itachi_counter_duration"):GetFloat() or 5
    self.SusanooCD = GetConVar("itachi_susanoo_cd"):GetFloat() or 10
    self.SusanooHealth = GetConVar("itachi_susanoo_health"):GetFloat() or 3500
    self.SusanooFlightCD =  GetConVar("itachi_susanoo_wings_cd"):GetFloat() or 1
    self.SusanooPrimaryCD = GetConVar("itachi_susanoo_primary_cd"):GetFloat() or 0.75
    self.SusanooPrimaryDamage = GetConVar("itachi_susanoo_primary_damage"):GetFloat() or 350
    self.SusanooSecondaryCD = GetConVar("itachi_susanoo_secondary_cd"):GetFloat() or 5
    self.SusanooSecondaryDamage = GetConVar("itachi_susanoo_secondary_damage"):GetFloat() or 550

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
        if CurTime() - self.ThemeStart >= 127 and player:GetInfoNum("itachi_theme", 0) == 1 then
            self.ThemeStart = CurTime()
            player:PlayClientSound(themeSound, 75, 100, 0.25)
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
                self:GetOwner():SetArmor(55)
            end
        end
    end
end

--Amaterasu
function SWEP:PrimaryAttack()
    if CurTime() - self.AmaterasuStart >= self.AmaterasuCD and not self.IsAttacking and not self.SusanooActive and not self.CrowModeActive and SERVER then
        local player = self:GetOwner()

        player:LagCompensation(true)
        
        local eyeHit = player:GetEyeTrace().Entity --Get the entity player is looking at

        local distance = player:GetPos():Distance(eyeHit:GetPos()) --Get the distance on the entity and player
        if IsValid(eyeHit) and not eyeHit:IsWorld() and distance <= self.AmaterasuRange and not player:KeyDown(IN_WALK) and not player:KeyDown(IN_DUCK) and not amaterasuBlackList[eyeHit:GetClass()] then
            self.AmaterasuStart = CurTime()
            self:SetAmaterasuTime(CurTime()) --Set the time for the client, so HUD can show correct times
            
            ---Effects and sound
            if player:GetInfoNum("itachi_voice", 1) == 1 then
                player:EmitSound(amaterasuShoutSound)

                timer.Simple(SoundDuration(amaterasuShoutSound) - 0.1, function()
                    player:EmitSound(amaterasuSound, 75, 100, 0.85)
                    player:ScreenFade(SCREENFADE.IN, Color(0,0,0,150), 0.45, 0)
                    util.ScreenShake(Vector(0, 0, 0), 5, 5, 0.25, 5000)
        
                    timer.Simple((distance / 2500), function() --Add delay based on distance from player
                        if IsValid(player) and IsValid(eyeHit) then
                            self.IsAttacking = false
        
                            eyeHit:Ignite(self.AmaterasuLength)
                            eyeHit.IsOnAmaterasu = true
                            eyeHit:TakeDamage(self.AmaterasuDamage, player, player:GetActiveWeapon())
                            eyeHit:EmitSound(amaterasuHitSound)
        
                            MS_StartAmaterasu(eyeHit)
                            
                            --AOE Damage. Will Search entities in a small area to ignite them. If convar is enabled
                            if GetConVar("itachi_amaterasu_aoe"):GetInt() == 1 then
                                for k, v in pairs(ents.FindInSphere(eyeHit:GetPos(), 65)) do
                                    if IsValid(v) and v ~= player and v ~= eyeHit and v:IsSolid() and not v:IsWeapon() and not amaterasuBlackList[v:GetClass()] then
                                        v.IsOnAmaterasu = true
                                        v:Ignite(self.AmaterasuLength)
                                        MS_StartAmaterasu(v)
                                        eyeHit:EmitSound(amaterasuHitSound, 75, 100, 0.3)
                                    end
                                end
                            end
                        end
                    end)
                end)
            else
                player:EmitSound(amaterasuSound, 75, 100, 0.85)
                player:ScreenFade(SCREENFADE.IN, Color(0,0,0,150), 0.45, 0)
                util.ScreenShake(Vector(0, 0, 0), 5, 5, 0.25, 5000)
    
                timer.Simple((distance / 2500), function() --Add delay based on distance from player
                    if IsValid(eyeHit) then
                        self.IsAttacking = false
    
                        eyeHit:Ignite(self.AmaterasuLength)
                        eyeHit.IsOnAmaterasu = true
                        eyeHit:TakeDamage(self.AmaterasuDamage, player, player:GetActiveWeapon())
                        eyeHit:EmitSound(amaterasuHitSound)
    
                        MS_StartAmaterasu(eyeHit)
                        
                        --AOE Damage. Will Search entities in a small area to ignite them. If convar is enabled
                        if GetConVar("itachi_amaterasu_aoe"):GetInt() == 1 then
                            for k, v in pairs(ents.FindInSphere(eyeHit:GetPos(), 65)) do
                                if IsValid(v) and v ~= player and v ~= eyeHit and v:IsSolid() and not v:IsWeapon() then
                                    v:Ignite(self.AmaterasuLength)
                                    MS_StartAmaterasu(v)
                                    eyeHit:EmitSound(amaterasuHitSound, 75, 100, 0.3)
                                end
                            end
                        end
                    end
                end)
            end
        elseif IsValid(eyeHit) and not eyeHit:IsWorld() and eyeHit:IsOnFire() and distance <= self.AmaterasuRange and player:KeyDown(IN_WALK) then
            self.AmaterasuStart = CurTime()
            self:SetAmaterasuTime(CurTime()) --Set the time for the client, so HUD can show correct times
            self.IsAttacking = true
            
            ---Effects and sound
            player:EmitSound(amaterasuSound, 75, 100, 0.85)
            player:ScreenFade(SCREENFADE.IN, Color(0,0,0,150), 0.45, 0)
            util.ScreenShake(player:GetPos(), 5, 5, 0.25, 50)

            timer.Simple((distance / 2500), function() --Add delay based on distance from player
                if IsValid(eyeHit) then
                    self.IsAttacking = false

                    MS_StopAmaterasu(eyeHit)
                end
            end)
        elseif IsValid(player) and player:KeyDown(IN_DUCK) then --If caster is on fire
            self.AmaterasuStart = CurTime()
            self:SetAmaterasuTime(CurTime()) --Set the time for the client, so HUD can show correct times
            
            ---Effects and sound
            player:EmitSound(amaterasuSound, 75, 100, 0.85)
            player:ScreenFade(SCREENFADE.IN, Color(0,0,0,150), 0.45, 0)
            util.ScreenShake(player:GetPos(), 5, 5, 0.25, 50)

            MS_StopAmaterasu(player)
            for k, v in ipairs(player:GetChildren()) do
                MS_StopAmaterasu(v)
            end
        end
        player:LagCompensation(false)
    elseif CurTime() - self.SusanooPrimaryStart >= self.SusanooPrimaryCD and not self.IsAttacking and self.SusanooActive and self.SusanooHasSword then --Susanoo Attack
        self.SusanooPrimaryStart = CurTime()
        self:SetSusanooSlashTime(CurTime())
        self.IsAttacking = false
        local player = self:GetOwner()

        player:LagCompensation(true)
        local tr = util.TraceLine({
            start = self.Owner:GetShootPos(),
            endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * self.SusanooPrimaryRange,
            filter = self.Owner,
            mask = MASK_SHOT_HULL
        })
    
        if not IsValid(tr.Entity) then
            tr = util.TraceHull({
                start = self.Owner:GetShootPos(),
                endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * self.SusanooPrimaryRange,
                filter = self.Owner,
                mins = Vector( -10, -10, -8 ),
                maxs = Vector( 10, 10, 8 ),
                mask = MASK_SHOT_HULL
            })
        end

        self:EmitSound("WeaponFrag.Throw")
        if SERVER then
            if math.random(1, 2) == 1 then
                player:EmitSound(susanooAttackSound)
            end
        end
        if IsValid(tr.Entity) then
            player:SetAnimation(PLAYER_ATTACK1)
            
            self:EmitSound(susanooHitSound)
            
            if SERVER then
                local dmgInfo = DamageInfo()
                dmgInfo:SetAttacker(player)
                dmgInfo:SetInflictor(self)
                dmgInfo:SetDamage(self.SusanooPrimaryDamage)
                dmgInfo:SetDamageForce(player:GetAimVector() * 5000)
                
                SuppressHostEvents(nil)
                tr.Entity:TakeDamageInfo(dmgInfo)
                SuppressHostEvents(player)
                util.ScreenShake(player:GetPos(), 20, 20, 1, 750)

                local phys = tr.Entity:GetPhysicsObject()
                if IsValid(phys) then
                    phys:SetVelocity(player:GetAimVector() * 15500)
                end

                local effectData = EffectData()
                effectData:SetOrigin(tr.Entity:GetPos())
                util.Effect("Explosion", effectData, true, true)
                
                for k, v in ipairs(ents.FindInSphere(tr.HitPos, 200)) do
                    if IsValid(v) and v ~= player and v ~= tr.Entity and v:IsSolid() then
                        SuppressHostEvents(nil)
                        v:TakeDamage(self.SusanooPrimaryDamage / 2, player, self)
                        SuppressHostEvents(player)

                        local phys = v:GetPhysicsObject()
                        if IsValid(phys) then
                            phys:SetVelocity((v:GetPos() - tr.HitPos) * 2500 / (phys:GetMass() / 3))
                        end
                    end
                end
            end
        elseif tr.HitWorld or tr.HitSky then
            player:SetAnimation(PLAYER_ATTACK1)

            util.ScreenShake(player:GetPos(), 20, 20, 1, 750)

            local effectData = EffectData()
            effectData:SetOrigin(tr.HitPos)
            util.Effect("Explosion", effectData)

            self:EmitSound(susanooHitSound)

            if SERVER then
               for k, v in ipairs(ents.FindInSphere(tr.HitPos, 200)) do
                    if IsValid(v) and v ~= player and v:IsSolid() then
                        SuppressHostEvents(nil)
                        v:TakeDamage(self.SusanooPrimaryDamage / 2, player, self)
                        SuppressHostEvents(player)

                        local phys = v:GetPhysicsObject()
                        if IsValid(phys) then
                            phys:SetVelocity((v:GetPos() - tr.HitPos) * 2500 / phys:GetMass())
                        end
                    end
                end
            end
        elseif not tr.Hit then
            player:SetAnimation(PLAYER_ATTACK1)
        end
        player:LagCompensation(false)
    elseif self.CrowModeActive and CurTime() - self.AmaterasuStart >= self.AmaterasuCD and SERVER  then
        self.AmaterasuStart = CurTime() - self.AmaterasuCD / 2
        self:SetAmaterasuTime(CurTime() - self.AmaterasuCD / 2)

        local player = self:GetOwner()
        player:EmitSound(Sound("npc/crow/alert1.wav"))
    end
end

function SWEP:SecondaryAttack()
    if CurTime() - self.TsukuyomiStart >= self.TsukuyomiCD and not self.IsAttacking and not self.CrowModeActive and not self.SusanooActive and SERVER then
        local player = self:GetOwner()

        player:LagCompensation(true)

        local eyeHit = player:GetEyeTrace().Entity --The entity that player eyes are looking at

        local distance = player:GetPos():Distance(eyeHit:GetPos())
        
        if IsValid(eyeHit) and not eyeHit:IsWorld() and distance <= self.TsukuyomiRange and not amaterasuBlackList[eyeHit:GetClass()] then
            self.TsukuyomiStart = CurTime()
            self:SetTsukuyomiTime(CurTime())

            --Efects and sound
            player:EmitSound(amaterasuSound, 75, 100, 0.75)
            player:ScreenFade(SCREENFADE.IN, Color(255,0,0,200), 0.55, 0)
            util.ScreenShake(Vector(0, 0, 0), 20, 20, 0.5, 5000)
            
            timer.Simple((distance / 2500), function() --Add delay based on distance from player
                self.IsAttacking = false

                Tsukuyomi(eyeHit, player, self.TsukuyomiDamage, tsukuyomiTrappedSound)
            end)
        end
        player:LagCompensation(false)
    elseif CurTime() - self.SusanooSecondaryStart >= self.SusanooSecondaryCD and self.SusanooActive then
        self.SusanooSecondaryStart = CurTime()
        self:SetSusanooSecondaryTime(CurTime())

        local player = self:GetOwner()

        for _, v in ipairs(player:GetChildren()) do
            if v:GetModel() == "models/itachi_susanoo_sword/itachi_susanoo_sword.mdl" then
                v:SetModelScale(0)
            end
        end

        player:SetAnimation(PLAYER_ATTACK1)
        self:EmitSound("WeaponFrag.Throw")

        --TODO make a custom sword entity
        self.SusanooHasSword = false
        if SERVER then
            local sword = ents.Create("itachi_sword_prop")
            sword:SetModelScale(2.75)
            sword:SetPos(player:GetBonePosition(player:LookupBone("ValveBiped.Bip01_R_Hand")) + player:GetForward() * 75 + player:GetUp() * 50 + -player:GetRight() * 85)
            sword:SetAngles(player:EyeAngles())
            sword:SetOwner(player)
            sword:Spawn()

            local phys = sword:GetPhysicsObject()
            if IsValid(phys) then
                phys:EnableGravity(false)
                phys:AddVelocity((player:GetAimVector() * 100000))
            end

            timer.Simple(3, function()
                if IsValid(player) and player:Alive() and self.SusanooActive then
                    for _, v in ipairs(player:GetChildren()) do
                        if v:GetModel() == "models/itachi_susanoo_sword/itachi_susanoo_sword.mdl" then
                            self:EmitSound(susanooGrowSound)
                            v:SetModelScale(2.75, 0.35)
                        end
                    end
                end
            end)
        end
        timer.Simple(3.5, function()
            self.SusanooHasSword = true
        end)
    end
end

function SWEP:Reload()
    if not self.SusanooActive and not self.CrowModeActive and not self:GetOwner():KeyDown(IN_WALK) then
        self:Counter()
    elseif self.SusanooActive then
        self:Fly()
    elseif self:GetOwner():KeyDown(IN_WALK) then
        self:CrowMode()
    end
end

function SWEP:Counter() --Im using a function instead of typing in in SWEP:Reload(), so i can call it on client in singleplayer
    if CurTime() - self.CounterStart >= self.CounterCD and not self.IsInCounter and not self.SusanooActive then
        self.CounterDurationStart = CurTime()
        self:SetCounterDurationTime(CurTime())
        self.IsInCounter = true
        self.IsAttacking = true

        local player = self:GetOwner()

        self:EmitSound(amaterasuSound)
        --Color for countering
        if CLIENT then
            local counterColor = {
                [ "$pp_colour_addr" ] = 1,
                [ "$pp_colour_addg" ] = 0,
                [ "$pp_colour_addb" ] = 0,
                [ "$pp_colour_brightness" ] = 0,
                [ "$pp_colour_contrast" ] = 1,
                [ "$pp_colour_colour" ] = 1,
                [ "$pp_colour_mulr" ] = 0.02,
                [ "$pp_colour_mulg" ] = 0,
                [ "$pp_colour_mulb" ] = 0
            }
            hook.Add("RenderScreenspaceEffects", "ItachiCounterColor " .. player:Nick(), function()
                DrawColorModify(counterColor)
            end)
        end

        timer.Create("Itachi Counter " .. player:Nick(), self.CounterDuration, 1, function()
            if IsValid(player) then
                self.CounterStart = CurTime()
                self:SetCounterTime(CurTime())
                self.IsInCounter = false
                self.IsAttacking = false
                
                hook.Remove("RenderScreenspaceEffects", "ItachiCounterColor " .. player:Nick())
            end
        end)
    end
end

function SWEP:Susanoo()
    if CurTime() - self.SusanooStart >= self.SusanooCD and not self.IsInCounter and not self.CrowModeActive and util.IsValidModel(self.SusanooModel) then
        self.SusanooStart = CurTime()
        local player = self:GetOwner()
        if not self.SusanooActive and self.SusanooModel ~= nil then
            self.SusanooActive = true
            self:SetDefaultModel(player:GetModel())
            self:SetDefaultHealth(player:Health())

            if SERVER then
                player:EmitSound(susanooActivateSound)
            end
            self:EmitSound(susanooGrowSound)
            
            player:SetModel(self.SusanooModel)
            player:MS_SetScale(4, 0.25)
            player:Activate()
            self:SetHoldType("melee")
            player:SetMoveType(MOVETYPE_WALK)

            self.SusanooFlightMode = false

            if SERVER then
                player:SetHealth(self:GetSusanooHealth())
                player:SetArmor(55)
                MS_StopAmaterasu(player)
            end

            if SERVER then
                if util.IsValidModel(Model("models/itachi_susanoo_sword/itachi_susanoo_sword.mdl")) then
                    local sword = ents.Create("prop_dynamic")
                    sword:SetModel(Model("models/itachi_susanoo_sword/itachi_susanoo_sword.mdl"))
                    sword:SetModelScale(2.75)
                    sword:SetPos(player:GetPos() + player:GetForward() * 4 + player:GetRight() * 1.25)
                    sword:SetAngles(player:GetAngles() + Angle(90,0,0))
                    sword:FollowBone(player, player:LookupBone("ValveBiped.Bip01_R_Hand"))
                    sword:Spawn()
                else
                    player:ChatPrint("Susanoo didn't load correctly. Please restart Garry's Mod and reinstall susanoo pack.")
                end

                if util.IsValidModel(Model("models/itachi_susanoo_shield/itachi_susanoo_shield.mdl")) then
                    local shield = ents.Create("prop_dynamic")
                    shield:SetModel("models/itachi_susanoo_shield/itachi_susanoo_shield.mdl")
                    shield:SetModelScale(3)
                    shield:SetPos(player:GetPos()  + player:GetForward() * 0.15 + player:GetRight() * 1.25)
                    shield:SetAngles(player:GetAngles() + Angle(-90,0,0))
                    shield:FollowBone(player, player:LookupBone("ValveBiped.Bip01_L_Hand"))
                    shield:Spawn()
                else
                    player:ChatPrint("Susanoo didn't load correctly. Please restart Garry's Mod and reinstall susanoo pack.")
                end
            end

            if SERVER then
                net.Start("AddHalo")
                net.WriteEntity(player)
                net.WriteColor(Color(255,50,0))
                net.Broadcast()
            end
        elseif self.SusanooActive and util.IsValidModel(self.SusanooModel) then
            self.SusanooActive = false
            self:SetSusanooHealth(player:Health())
            self.SusanooRegenStart = CurTime()

            self:EmitSound(susanooDeactivateSound)

            player:SetModel(self:GetDefaultModel())
            player:MS_SetScale(1)
            player:Activate()
            self:SetHoldType("normal")
            player:SetMoveType(MOVETYPE_WALK)

            self.SusanooFlightMode = false

            if SERVER then
                player:SetHealth(self:GetDefaultHealth())
                player:SetArmor(25)
                MS_StopAmaterasu(player)
            end

            if SERVER then
                net.Start("RemoveHalo")
                net.WriteString(player:GetActiveWeapon():GetClass() .. player:GetName())
                net.Broadcast()
            end

            --Set sharingan eye on model if having the itachi model
            if GetConVar("itachi_eye_change"):GetInt() == 1 then
                if player:GetModel() == "models/player/ita/itachi_uchiha.mdl" then
                    player:SetBodygroup(3, 2)
                end
            end

            if SERVER then
                for k, v in ipairs(player:GetChildren()) do
                    if v:GetClass() == "prop_dynamic" and string.match(v:GetModel(), "susano") then
                        v:Remove()
                    end
                end
            end
        end
    end
end

function SWEP:CrowMode()
    if CurTime() - self.CrowModeStart >= self.CrowModeCD and not self.IsInCounter and not self.SusanooActive then
        self.CrowModeStart = CurTime()
        self:SetCrowModeTime(CurTime())
        
        local player = self:GetOwner()

        if self.CrowModeActive then
            self.CrowModeActive = false

            self.CounterStart = CurTime() - self.CounterCD / 2
            self:SetCounterTime(CurTime() - self.CounterCD / 2)

            player:SetModel(self:GetDefaultModel())
            player:SetMoveType(MOVETYPE_WALK)
        else
            self.CrowModeActive = true

            self:SetDefaultModel(player:GetModel())

            player:SetModel("models/crow.mdl")
            player:SetMoveType(MOVETYPE_FLY)
        end
    end
end

function SWEP:Fly()
    local player = self:GetOwner()
    if CurTime() - self.SusanooFlightStart >= self.SusanooFlightCD then
        self.SusanooFlightStart = CurTime()
        self:SetSusanooFlightTime(CurTime())
        if not self.SusanooFlightMode then
            self.SusanooFlightMode = true

            self:EmitSound(wingsActivateSound)

            player:SetModel(self.SusanooWingsModel)
            player:SetMoveType(MOVETYPE_FLY)
        else
            self.SusanooFlightMode = false

            self:EmitSound(wingsDeactivateSound)

            player:SetModel(self.SusanooModel)
            player:SetMoveType(MOVETYPE_WALK)
        end
    end
end

function SWEP:Quote()
    if CurTime() - self.QuoteStart >= self.QuoteCD and not self.IsInQuote then
        self.IsInQuote = true

        local player = self:GetOwner()

        local randomNum = math.floor(util.SharedRandom("Quote", 1, #quotes, CurTime()) + 0.5)
        local randomQuote = quotes[randomNum]

        if SERVER then
            player:EmitSound(randomQuote)
        end

        timer.Simple(SoundDuration(randomQuote) + 0.25, function()
            if IsValid(self) and IsValid(player) then
                self.IsInQuote = false
                self.QuoteStart = CurTime()
            end
        end)
    end
end

function SWEP:DrawHUD()
    if GetConVar("itachi_disableHud"):GetInt() == 0 then
        local player = LocalPlayer()

        local amaterasuEYE = {
            texture = surface.GetTextureID("huds/itachi"),
            x = ScrW() / 1.045,
            y = ScrH() / 2,
            w = relativeW(64),
            h = relativeH(64)
        }

        local tsukuyomiEYE = {
            texture = surface.GetTextureID("huds/itachi"),
            x = ScrW() / 1.045,
            y = ScrH() / 1.75,
            w = relativeW(64),
            h = relativeH(64)
        }
        local counterEYE = {
            texture = surface.GetTextureID("huds/itachi"),
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
    
        --Amaterasu/Susanoo Slash HUD
        draw.NoTexture()
        surface.SetDrawColor(GetConVar("itachi_r"):GetInt(), GetConVar("itachi_g"):GetInt(), GetConVar("itachi_b"):GetInt(), 255)
        if self.SusanooActive then
            draw.SimpleText("Slash", "NarutoFont", ScrW() / 1.13, ScrH() / 1.92)
            draw.Circle(ScrW() / 1.0273, ScrH() / 1.8875, Lerp((CurTime() - self:GetSusanooSlashTime()) / self.SusanooPrimaryCD, 0, relativeW(31)), 64)
        elseif self.CrowModeActive then
            draw.SimpleText("Caw", "NarutoFont", ScrW() / 1.13, ScrH() / 1.92)
            draw.Circle(ScrW() / 1.0273, ScrH() / 1.8875, Lerp((CurTime() - self:GetAmaterasuTime()) / self.AmaterasuCD, 0, relativeW(31)), 64)
        else
            if player:KeyDown(IN_WALK) and not player:KeyDown(IN_DUCK) then
                draw.SimpleText("Clear Ent", "NarutoFont", ScrW() / 1.13, ScrH() / 1.92)
            elseif not player:KeyDown(IN_WALK) and player:KeyDown(IN_DUCK) then
                draw.SimpleText("Clear Self", "NarutoFont", ScrW() / 1.13, ScrH() / 1.92)
            else
                draw.SimpleText("Amaterasu", "NarutoFont", ScrW() / 1.13, ScrH() / 1.92)
            end
            draw.Circle(ScrW() / 1.0273, ScrH() / 1.8875, Lerp((CurTime() - self:GetAmaterasuTime()) / self.AmaterasuCD, 0, relativeW(31)), 64)
        end
        draw.TexturedQuad(amaterasuEYE)

        --Tsukuyomi/Throw HUD
        draw.NoTexture()
        surface.SetDrawColor(GetConVar("itachi_r"):GetInt(), GetConVar("itachi_g"):GetInt(), GetConVar("itachi_b"):GetInt(), 255)
        if self.SusanooActive then
            draw.SimpleText("Sword Throw", "NarutoFont", ScrW() / 1.13, ScrH() / 1.685)
            draw.Circle(ScrW() / 1.0273, ScrH() / 1.665, Lerp((CurTime() - self:GetSusanooSecondaryTime()) / self.SusanooSecondaryCD, 0, relativeW(31)), 64)
        else
            draw.SimpleText("Tsukuyomi", "NarutoFont", ScrW() / 1.13, ScrH() / 1.685)
            draw.Circle(ScrW() / 1.0273, ScrH() / 1.665, Lerp((CurTime() - self:GetTsukuyomiTime()) / self.TsukuyomiCD, 0, relativeW(31)), 64)
        end
        draw.TexturedQuad(tsukuyomiEYE)

        --Counter HUD
        draw.NoTexture()
        surface.SetDrawColor(GetConVar("itachi_r"):GetInt(), GetConVar("itachi_g"):GetInt(), GetConVar("itachi_b"):GetInt(), 255)
        if self.SusanooActive then
            if self.SusanooFlightMode then
                draw.SimpleText("Normal Mode", "NarutoFont", ScrW() / 1.13, ScrH() / 1.51)
            else
                draw.SimpleText("Fly Mode", "NarutoFont", ScrW() / 1.13, ScrH() / 1.51)
            end
            draw.Circle(ScrW() / 1.0273, ScrH() / 1.492, Lerp((CurTime() - self:GetSusanooFlightTime()) / self.SusanooFlightCD, 0, relativeW(31)), 64)
        elseif self.CrowModeActive then
            draw.SimpleText("Normal Mode", "NarutoFont", ScrW() / 1.13, ScrH() / 1.51)
            
            draw.Circle(ScrW() / 1.0273, ScrH() / 1.492, Lerp((CurTime() - self:GetCrowModeTime()) / self.CrowModeCD, 0, relativeW(31)), 64)
        else
            if player:KeyDown(IN_WALK) then
                draw.SimpleText("Crow Mode", "NarutoFont", ScrW() / 1.13, ScrH() / 1.51)
            else
                draw.SimpleText("Counter", "NarutoFont", ScrW() / 1.13, ScrH() / 1.51)
            end
            if self.IsInCounter then
                draw.Circle(ScrW() / 1.0273, ScrH() / 1.492, Lerp((CurTime() - self:GetCounterDurationTime()) / self.CounterDuration, relativeW(31), 0), 64)
            else
                if player:KeyDown(IN_WALK) then
                    draw.Circle(ScrW() / 1.0273, ScrH() / 1.492, Lerp((CurTime() - self:GetCrowModeTime()) / self.CrowModeCD, 0, relativeW(31)), 64)
                else
                    draw.Circle(ScrW() / 1.0273, ScrH() / 1.492, Lerp((CurTime() - self:GetCounterTime()) / self.CounterCD, 0, relativeW(31)), 64)
                end
            end
        end
        draw.TexturedQuad(counterEYE)

        --Susanoo HUD
        if self.SusanooActive then
            draw.NoTexture()
            draw.SimpleText("Susanoo", "NarutoFont", ScrW() / 1.13, ScrH() / 1.37)
            if self.SusanooFlightMode then
                draw.TexturedQuad(susanoo)
            else
                draw.TexturedQuad(susanooNoWings)
            end
        end
    end
end

hook.Add("EntityTakeDamage", "ItachiTakeDamage", function(entity, dmg)
    if IsValid(entity) and entity:IsPlayer() then
        if entity:MS_UsingItachi() then
            local weapon = entity:GetActiveWeapon()

            --Susanoo Handling
            if weapon.SusanooActive then
                if dmg:IsBulletDamage() then
                    return true
                end
            end

            --Counter Handling
            if weapon.IsInCounter then
                local attacker = dmg:GetAttacker()
                if IsValid(attacker) then
                    local oldPos = entity:GetPos()
                    local oldAngles = entity:GetAngles()
    
                    entity:Freeze(true)
                    MS_StopAmaterasu(entity)
                    entity:SetPos(attacker:GetPos() - attacker:GetForward() * 150)
                    entity:SetEyeAngles(Angle(0, attacker:EyeAngles().yaw, 0))
    
                    if not entity:IsInWorld() then
                        entity:SetPos(oldPos)
                        entity:SetEyeAngles(oldAngles)
                    end
                    --Spawn crows for an illusion effect
                    for i = 1, math.random(3,7) do
                        crow = ents.Create("npc_crow")
                        crow:SetPos(oldPos + Vector(math.random(10,50), math.random(10,50), math.random(10,50)))
                        crow:Spawn()
                    end
    
                    entity:Freeze(false)
                    MS_StopAmaterasu(entity)
    
                    hook.Remove("RenderScreenspaceEffects", "ItachiCounterColor " .. entity:Nick())
                    timer.Remove("Itachi Counter " .. entity:Nick())
                    net.Start("RemoveItachiCounter")
                    net.Send(entity)
    
                    weapon.CounterStart = CurTime()
                    weapon:SetCounterTime(CurTime())
                    weapon.IsInCounter = false
                    weapon.IsAttacking = false
    
                    weapon:EmitSound(counterSound)
                    timer.Simple(0.1, function()
                        if IsValid(entity) then
                            MS_StopAmaterasu(entity)
                        end
                    end)
                    return true
                end
            end

            --Hurt Sound
            if GetConVar("itachi_voice"):GetInt() == 1 and IsValid(weapon) and IsValid(entity) and not weapon.SusanooActive then
                local randomNum = math.floor(util.SharedRandom("RandomHurt", 1, #hurtSounds, CurTime()) + 0.5)
                weapon:EmitSound(hurtSounds[randomNum])
            end
        end
    end
end)

hook.Add("GetFallDamage", "ItachiNoFall", function(player, speed)
    if IsValid(player) and player:MS_UsingMangekyou() then
        local weapon = player:GetActiveWeapon()
        
        if weapon.SusanooActive or weapon.IsInCounter then
            --Susanoo fall
            if weapon.SusanooActive then
                local effectData = EffectData()
                effectData:SetEntity(player)
                effectData:SetOrigin(player:GetPos())
                effectData:SetScale(4 * ((speed / 6) * player:GetModelScale()))
                util.Effect("ThumperDust", effectData, true, true)

                player:EmitSound(susanooFallSound)
                util.ScreenShake(player:GetPos(), 50, 50, 0.45, 500)

                for _, entity in ipairs(ents.FindInSphere(player:GetPos(), 10 * (speed / 40))) do
                    if entity ~= player or entity:GetOwner() == player then
                        SuppressHostEvents(nil)
                        entity:TakeDamage(5 * ((speed / 150) * player:GetModelScale()), player, weapon)
                        SuppressHostEvents(player)

                        local phys = entity:GetPhysicsObject()
                        if IsValid(phys) then
                            phys:SetVelocity((entity:GetPos() - player:GetPos()) * (500 * (speed / 500)) / (phys:GetMass() / 3))
                        end
                    end
                end
            end
            return 0
        end
    end
end)

hook.Add("DoPlayerDeath", "ItachiDeath", function(victim, inflict, attacker)
    if victim:IsPlayer() then

        victim:StopClientSound(themeSound)
        victim:StopClientSound(tsukuyomiTrappedSound)

        if victim:MS_UsingItachi() then
            local weapon = victim:GetActiveWeapon()
    
            if GetConVar("itachi_voice"):GetInt() == 1 then 
                victim:EmitSound(deathSound)
            end
    
            weapon.IsAttacking = false
            weapon.IsInCounter = false

            --Disable susanoo
            victim:MS_SetScale(1)
            victim:SetModel(weapon:GetDefaultModel())

            if SERVER then
                for k, v in ipairs(victim:GetChildren()) do
                    if v:GetClass() == "prop_dynamic" and string.match(v:GetModel(), "susano") then
                        v:Remove()
                    end
                end
            end
            
            net.Start("RemoveHalo")
            net.WriteString(victim:GetActiveWeapon():GetClass() .. victim:GetName())
            net.Broadcast()
        end
    
        victim:Freeze(false)
        hook.Remove("RenderScreenspaceEffects", "ItachiCounterColor " .. victim:Nick())
        timer.Remove("Itachi Counter " .. victim:Nick())

        net.Start("TsukuyomiEffectRemove")
        net.Send(victim)
    
        if SERVER then
            victim:SetLaggedMovementValue(1)
        end

    end
end)

hook.Add("PlayerButtonDown", "itachi_susanoo", function(player, button)
    if IsValid(player) and player:Alive() and not player:IsFrozen() and player:MS_UsingItachi() and button == KEY_B then
        local weapon = player:GetActiveWeapon()
        weapon:Susanoo()
    end
end)

hook.Add("PlayerButtonDown", "itachi_quote", function(player, button)
    if IsValid(player) and player:Alive() and not player:IsFrozen() and player:MS_UsingItachi() and button == KEY_M then
        local weapon = player:GetActiveWeapon()
        weapon:Quote()
    end
end)

hook.Add("PlayerFootstep", "ItachiSusanooStep", function(player, pos, foot, sound, volume)
    if IsValid(player) and player:Alive() and player:MS_UsingItachi() then
        local weapon = player:GetActiveWeapon()

        if weapon.SusanooActive then
            player:EmitSound(susanooStepSound, 75)
            util.ScreenShake(player:GetPos(), 5, 2, 0.05, 300)
            return true
        end
    end
end)