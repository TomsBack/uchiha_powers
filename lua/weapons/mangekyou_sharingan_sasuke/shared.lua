AddCSLuaFile()

SWEP.PrintName = "Sasuke Sharingan"
SWEP.Author = "Tomik"
SWEP.Purpose = "Use the mighty powers of sasukes's mangekyou sharingan"
SWEP.Instructions = "--Normal Mode--\nLMB - Amaterasu\nLMB + ALT - Extinguish target\nLMB + CTRL - Extinguish yourself\nRMB - Kagutsuchi\nR - Counter \nB - Susano'o \n\n--Susano'o Mode--\nLMB - Slash\nRMB - Throw Sword\nR - Wings\nB - Disable Susano'o\nPassive - No damage from bullets\nPassive - Kagutsuchi does not effect susanoo\nPassive - When you land, you deal damage to entities in range"
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
    SWEP.WepSelectIcon = surface.GetTextureID("huds/sasuke_select")
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

SWEP.AmaterasuCD = GetConVar("sasuke_amaterasu_cd"):GetFloat() or 4
SWEP.AmaterasuStart = -SWEP.AmaterasuCD
SWEP.AmaterasuRange = GetConVar("sasuke_amaterasu_range"):GetFloat() or 2000 --How far can amaterasu ignite targets
SWEP.AmaterasuLength = GetConVar("sasuke_amaterasu_length"):GetFloat() or 1000 --How long will the target burn
SWEP.AmaterasuDamage = GetConVar("sasuke_amaterasu_damage"):GetFloat() or 160

SWEP.AmenotejikaraCD = GetConVar("sasuke_amaterasu_cd"):GetFloat() or 4
SWEP.AmenotejikaraStart = -SWEP.AmenotejikaraCD
SWEP.AmenotejikaraRange = GetConVar("sasuke_amaterasu_range"):GetFloat() or 2500
local entity1 = nil
local entity2 = nil

SWEP.KagutsuchiCD = GetConVar("sasuke_kagutsuchi_cd"):GetFloat() or 20
SWEP.KagutsuchiStart = -SWEP.KagutsuchiCD
SWEP.KagutsuchiRange = GetConVar("sasuke_kagutsuchi_range"):GetFloat() or 450 --How far can kagutsuchi go
SWEP.KagutsuchiDamage = GetConVar("sasuke_kagutsuchi_damage"):GetFloat() or 200
SWEP.FlameCloakActive = false

SWEP.ShinraTenseiCD = 5
SWEP.ShinraTenseiStart = -SWEP.ShinraTenseiCD
SWEP.ShinraTenseiRange = GetConVar("sasuke_kagutsuchi_range"):GetFloat() or 350 --How far can shinra tensei go
SWEP.ShinraTenseiDamage = GetConVar("sasuke_kagutsuchi_damage"):GetFloat() or 150

SWEP.CounterCD = GetConVar("sasuke_counter_cd"):GetFloat() or 8
SWEP.CounterStart = -SWEP.CounterCD
SWEP.CounterDuration = GetConVar("sasuke_counter_duration"):GetFloat() or 6
SWEP.CounterDurationStart = 0 --Used for showing how much time left in counter
SWEP.IsInCounter = false

SWEP.SusanooCD = GetConVar("sasuke_susanoo_cd"):GetFloat() or 10
SWEP.SusanooStart = -SWEP.SusanooCD
SWEP.SusanooActive = false
SWEP.SusanooModel = Model("models/player/susanoo_sasuke_closewings/susanoo_sasuke_closewings.mdl") or nil
SWEP.SusanooScale = 4
SWEP.SusanooHealth = GetConVar("sasuke_susanoo_health"):GetFloat() or 5000

SWEP.SusanooFlightCD =  GetConVar("sasuke_susanoo_wings_cd"):GetFloat() or 1
SWEP.SusanooFlightStart = -SWEP.SusanooFlightCD
SWEP.SusanooFlightMode = false
SWEP.SusanooWingsModel = Model("models/player/susanoo_sasuke/susanoo_sasuke.mdl")

SWEP.SusanooPrimaryCD = GetConVar("sasuke_susanoo_primary_cd"):GetFloat() or 0.75
SWEP.SusanooPrimaryStart = -SWEP.SusanooPrimaryCD
SWEP.SusanooPrimaryDamage = GetConVar("sasuke_susanoo_primary_damage"):GetFloat() or 350
SWEP.SusanooPrimaryRange = 850

SWEP.SusanooSecondaryCD = GetConVar("sasuke_susanoo_secondary_cd"):GetFloat() or 5
SWEP.SusanooSecondaryDamage = GetConVar("sasuke_susanoo_secondary_damage"):GetFloat() or 550
SWEP.SusanooSecondaryStart = -SWEP.SusanooSecondaryCD

SWEP.SusanooRegenCD = 5
SWEP.SusanooRegenStart = 0
SWEP.SusanooRegenAmount = 50

SWEP.ChangeModeCD = 1
SWEP.ChangeModeStart = 0
SWEP.RinneganMode = false

SWEP.QuoteCD = 2
SWEP.QuoteStart = 0
SWEP.IsInQuote = false

SWEP.ThemeStart = CurTime()

SWEP.IsAttacking = false
SWEP.SusanooHasSword = true
SWEP.HasRinnegan = false

local amaterasuBlackList = {
    ["ba_stand_rewritten"] = true,
    ["ba_thefool"] = true,
    ["kamui_dimension"] = true,
    ["kamuiwall"] = true
}

--Sounds
local deathSound = Sound("mangekyou_sasuke/death.wav")
local hurtSound = Sound("mangekyou_sasuke/hurt.wav")
local hurtSound2 = Sound("mangekyou_sasuke/hurt2.wav")
local activationShout = Sound("mangekyou_sasuke/activation.wav")
local activationSound = Sound("sharingan/activation.wav")
local deactivationSound = Sound("sharingan/deactivation.wav")
local amaterasuSound = Sound("mangekyou_sasuke/amaterasu.wav")
local amaterasuHitSound = Sound("mangekyou_sasuke/amaterasu_hit.wav")
local amaterasuShoutSound = Sound("mangekyou_sasuke/amaterasu_shout.wav")
local kagutsuchiTrappedSound = Sound("mangekyou_sasuke/kagutsuchi_trapped.wav")
local counterSound = Sound("mangekyou_sasuke/counter.wav")
local susanooActivateSound = Sound("mangekyou_sasuke/susanoo_activate.wav")
local susanooDeactivateSound = Sound("mangekyou_sasuke/susanoo_deactivate.wav")
local wingsActivateSound = Sound("mangekyou_sasuke/susanoo_wings_activate.wav")
local wingsDeactivateSound = Sound("mangekyou_sasuke/susanoo_wings_deactivate.wav")
local susanooAttackSound = Sound("mangekyou_sasuke/susanoo_attack.wav")
local susanooHitSound = Sound("mangekyou_sasuke/susanoo_hit.wav")
local susanooFallSound = Sound("mangekyou_sasuke/susanoo_fall.wav")
local susanooStepSound = Sound("susanoo/susanoo_step.wav")
local susanooGrowSound = Sound("susanoo/susanoo_grow.wav")
local rinneganSound = Sound("mangekyou_sasuke/rinnegan.wav")
local teleportSound = Sound("mangekyou_sasuke/teleport.wav")
local shinraTenseiSound = Sound("mangekyou_sasuke/shinra_tensei.wav")

local themeSound = Sound("mangekyou_sasuke/sasuke_theme.mp3")

local quotes = {
    Sound("mangekyou_sasuke/quotes/quote1.wav"),
    Sound("mangekyou_sasuke/quotes/quote2.wav")
}

local hurtSounds = {
    hurtSound,
    hurtSound2
}

--Adding custom icon when someone is killed by sharingan
if CLIENT then
    killicon.Add("mangekyou_sharingan_sasuke", "huds/sasuke_killicon", Color(255,80,0,255))
end

function SWEP:SetupDataTables()
    self:NetworkVar("Float", 0, "AmaterasuTime")
    self:NetworkVar("Float", 1, "KagutsuchiTime")
    self:NetworkVar("Float", 2, "CounterTime")
    self:NetworkVar("Float", 3, "CounterDurationTime")
    self:NetworkVar("Float", 4, "SusanooSlashTime")
    self:NetworkVar("Float", 5, "SusanooFlightTime")
    self:NetworkVar("Float", 6, "SusanooSecondaryTime")
    self:NetworkVar("Float", 7, "AmenotejikaraTime")
    self:NetworkVar("Float", 8, "ShinraTenseiTime")
    self:NetworkVar("String", 0, "DefaultModel")
    self:NetworkVar("Int", 0, "DefaultHealth")
    self:NetworkVar("Int", 1, "SusanooHealth")

    self:SetSusanooHealth(self.SusanooHealth)
end

function SWEP:Initialize()
    self:SetHoldType(self.HoldType) --Set third person animation

    self:SetAmaterasuTime(-self.AmaterasuCD)
    self:SetAmenotejikaraTime(-self.AmenotejikaraCD)
    self:SetKagutsuchiTime(-self.KagutsuchiCD)
    self:SetShinraTenseiTime(-self.ShinraTenseiCD)
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
        if player:GetInfoNum("sasuke_theme", 0) == 1 then
            player:PlayClientSound(themeSound, 75, 100, 0.1)
            self.ThemeStart = CurTime()
        end
    end
    self:StopSound(deactivationSound)

    if player:GetInfoNum("sasuke_voice", 1) == 1 then
        if SERVER then
            player:EmitSound(activationShout)
        end
    
        timer.Create("Sasuke_Activation " .. player:Nick(), SoundDuration(activationShout), 1, function()
            if IsValid(self) and IsValid(player) then
                if self.RinneganMode then
                    self:EmitSound(rinneganSound)
                else
                    self:EmitSound(activationSound)
                end
    
                --Set sharingan eye on model if having the sasuke model
                if player:GetInfoNum("sasuke_eye_change", 1) == 1 then
                    if player:GetModel() == "models/sasukeall/sasukeall.mdl" then
                        if self.RinneganMode then
                            player:SetBodygroup(4, 0)
                        else
                            player:SetBodygroup(4, 2)
                        end
                        --player:SetBodygroup(5, 2)
                    end
                end
            end
        end)
    else
        self:EmitSound(activationSound)

        --Set sharingan eye on model if having the sasuke model
        if player:GetInfoNum("sasuke_eye_change", 1) == 1 then
            if player:GetModel() == "models/sasukeall/sasukeall.mdl" then
                if self.RinneganMode then
                    player:SetBodygroup(4, 0)
                else
                    player:SetBodygroup(4, 2)
                end
            end
        end
    end
end

function SWEP:Holster()
    if self.IsAttacking or self.IsInCounter or self.SusanooActive or self.FlameCloakActive then
        return false
    else
        local player = self:GetOwner()
        timer.Remove("Sasuke_Activation " .. player:Nick())

        if SERVER then
            player:StopClientSound(themeSound)
        end

        player:StopSound(activationShout)
        if SERVER then
            player:EmitSound(deactivationSound, 75, 100, 0.45)
        end
        if player:GetInfoNum("sasuke_eye_change", 1) == 1 then
            if player:GetModel() == "models/sasukeall/sasukeall.mdl" then
                if self.RinneganMode then
                    player:SetBodygroup(4, 0)
                else
                    player:SetBodygroup(4, 4)
                end
                player:SetBodygroup(5, 0)
            end
        end
        return true
    end
end

function SWEP:Think()
    local player = self:GetOwner()
    --Settting convars
    self.AmaterasuCD = GetConVar("sasuke_amaterasu_cd"):GetFloat() or 7.5
    self.AmaterasuRange = GetConVar("sasuke_amaterasu_range"):GetFloat() or 1250
    self.AmaterasuLength = GetConVar("sasuke_amaterasu_length"):GetFloat() or 1000
    self.AmaterasuDamage = GetConVar("sasuke_amaterasu_damage"):GetFloat() or 75
    self.KagutsuchiCD = GetConVar("sasuke_kagutsuchi_cd"):GetFloat() or 20
    self.KagutsuchiRange = GetConVar("sasuke_kagutsuchi_range"):GetFloat() or 450
    self.KagutsuchiDamage = GetConVar("sasuke_kagutsuchi_damage"):GetFloat() or 200
    self.CounterCD = GetConVar("sasuke_counter_cd"):GetFloat() or 7
    self.CounterDuration = GetConVar("sasuke_counter_duration"):GetFloat() or 5
    self.SusanooCD = GetConVar("sasuke_susanoo_cd"):GetFloat() or 10
    self.SusanooHealth = GetConVar("sasuke_susanoo_health"):GetFloat() or 3500
    self.SusanooFlightCD =  GetConVar("sasuke_susanoo_wings_cd"):GetFloat() or 1
    self.SusanooPrimaryCD = GetConVar("sasuke_susanoo_primary_cd"):GetFloat() or 0.75
    self.SusanooPrimaryDamage = GetConVar("sasuke_susanoo_primary_damage"):GetFloat() or 350
    self.SusanooSecondaryCD = GetConVar("sasuke_susanoo_secondary_cd"):GetFloat() or 5
    self.SusanooSecondaryDamage = GetConVar("sasuke_susanoo_secondary_damage"):GetFloat() or 550

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
        if CurTime() - self.ThemeStart >= 134 and player:GetInfoNum("sasuke_theme", 0) == 1 then
            self.ThemeStart = CurTime()
            player:PlayClientSound(themeSound, 75, 100, 0.1)
        end
    end

    --Flame cloak
    if SERVER then
        if IsValid(player) and self.FlameCloakActive then
            local player = self:GetOwner()
            for _, v in ipairs(ents.FindInSphere(player:GetPos(), 65)) do
                if IsValid(v) and v ~= player and not v:IsWeapon() and v:IsSolid() and not v.IsOnAmaterasu and not amaterasuBlackList[v:GetClass()] then
                    if self.HasRinnegan then
                        v:TakeDamage((self.AmaterasuDamage / 3) * 1.25, player, self)
                    else
                        v:TakeDamage(self.AmaterasuDamage / 3, player, self)
                    end
                    v:Ignite(self.AmaterasuLength)
                    MS_StartAmaterasu(v)
                    --v:EmitSound(amaterasuHitSound)
                end
            end
        end
    end

    --Armor
    if SERVER then
        if not self.SusanooActive then
            if self.HasRinnegan then
                if self:GetOwner():Armor() < 30 then
                    self:GetOwner():SetArmor(30)
                end
            else
                if self:GetOwner():Armor() < 25 then
                    self:GetOwner():SetArmor(25)
                end
            end
        else
            if self:GetOwner():Armor() < 100 then
                self:GetOwner():SetArmor(40)
            end
        end
    end
end

--Amaterasu
function SWEP:PrimaryAttack()
    if CurTime() - self.AmaterasuStart >= self.AmaterasuCD and not self.IsAttacking and not self.SusanooActive and not self.RinneganMode and SERVER then
        local player = self:GetOwner()
        
        player:LagCompensation(true)
        
        local eyeHit = player:GetEyeTrace().Entity --Get the entity player is looking at
        
        local distance = player:GetPos():Distance(eyeHit:GetPos()) --Get the distance on the entity and player
        if IsValid(eyeHit) and not eyeHit:IsWorld() and distance <= self.AmaterasuRange and not player:KeyDown(IN_WALK) and not player:KeyDown(IN_DUCK) and not amaterasuBlackList[eyeHit:GetClass()] then
            self.AmaterasuStart = CurTime()
            self:SetAmaterasuTime(CurTime()) --Set the time for the client, so HUD can show correct times
            
            ---Effects and sound
            if player:GetInfoNum("sasuke_voice", 1) == 1 then
                player:EmitSound(amaterasuShoutSound, 75, 100, 0.85)
            else
                player:EmitSound(amaterasuSound, 75, 100, 0.85)
            end
            player:ScreenFade(SCREENFADE.IN, Color(0,0,0,150), 0.45, 0)
            util.ScreenShake(Vector(0, 0, 0), 5, 5, 0.25, 5000)

            timer.Simple((distance / 2500), function() --Add delay based on distance from player
                if IsValid(eyeHit) and IsValid(self) then
                    self.IsAttacking = false

                    eyeHit.IsOnAmaterasu = true
                    eyeHit:Ignite(self.AmaterasuLength)

                    local damageInfo = DamageInfo()
                    damageInfo:SetDamageType(DMG_PREVENT_PHYSICS_FORCE)
                    damageInfo:SetDamage(self.HasRinnegan and self.AmaterasuDamage * 1.25 or self.AmaterasuDamage)
                    damageInfo:SetAttacker(player or eyeHit)
                    damageInfo:SetInflictor(self or player)
                    eyeHit:TakeDamageInfo(damageInfo)

                    eyeHit:EmitSound(amaterasuHitSound)

                    MS_StartAmaterasu(eyeHit)
                    
                    --AOE Damage. Will Search entities in a small area to ignite them. If convar is enabled
                    if GetConVar("sasuke_amaterasu_aoe"):GetInt() == 1 then
                        for k, v in pairs(ents.FindInSphere(eyeHit:GetPos(), 100)) do
                            if IsValid(v) and v ~= player and v ~= eyeHit and v:IsSolid() and not v:IsWeapon() and not amaterasuBlackList[v:GetClass()] then
                                v.IsOnAmaterasu = true
                                v:Ignite(self.AmaterasuLength)
                                v:TakeDamageInfo(damageInfo)
                                MS_StartAmaterasu(v)
                                eyeHit:EmitSound(amaterasuHitSound, 75, 100, 0.3)
                            end
                        end
                    end
                end
            end)
        elseif IsValid(eyeHit) and not eyeHit:IsWorld() and eyeHit:IsOnFire() and distance <= self.AmaterasuRange and player:KeyDown(IN_WALK) then
            self.AmaterasuStart = CurTime() - (self.AmaterasuCD / 1.5)
            self:SetAmaterasuTime(CurTime() - (self.AmaterasuCD / 1.5)) --Set the time for the client, so HUD can show correct times
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
            self.AmaterasuStart = CurTime() - (self.AmaterasuCD / 1.5)
            self:SetAmaterasuTime(CurTime() - (self.AmaterasuCD / 1.5)) --Set the time for the client, so HUD can show correct times
            
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
    elseif CurTime() - self.AmenotejikaraStart >= self.AmenotejikaraCD and not self.IsAttacking and not self.SusanooActive and self.RinneganMode and SERVER then
        local player = self:GetOwner()
        
        player:LagCompensation(true)
        
        local eyeHit = player:GetEyeTrace().Entity --Get the entity player is looking at

        local distance = player:GetPos():Distance(eyeHit:GetPos()) --Get the distance on the entity and player
        if IsValid(eyeHit) and not eyeHit:IsWorld() and distance <= self.AmenotejikaraRange and not player:KeyDown(IN_WALK) and not amaterasuBlackList[eyeHit:GetClass()] then
            self.AmenotejikaraStart = CurTime()
            self:SetAmenotejikaraTime(CurTime())
            
            ---Effects and sound
            player:EmitSound(rinneganSound)
            util.ScreenShake(player:GetPos(), 10, 10, 0.45, 0)

            timer.Simple((distance / 7000), function() --Add delay based on distance from player
                if IsValid(eyeHit) and IsValid(self) and IsValid(player) then
                    self.IsAttacking = false
                    
                    player:GodEnable()
                    net.Start("AmenotejikaraEffect")
                    net.Send(player)

                    local oldPos = player:GetPos()
                    local targetPhys = eyeHit:GetPhysicsObject()
                    local playerPhys = player:GetPhysicsObject()

                    local oldVelocity = nil
                    local oldPhysPos = nil

                    if IsValid(playerPhys) then
                        oldVelocity = playerPhys:GetVelocity()
                        oldPhysPos = playerPhys:GetPos()
                    end

                    player:SetRenderMode(RENDERMODE_TRANSCOLOR)
                    eyeHit:SetRenderMode(RENDERMODE_TRANSCOLOR)

                    if IsValid(targetPhys) and IsValid(playerPhys) then
                        playerPhys:SetVelocity(targetPhys:GetVelocity())
                        playerPhys:SetPos(targetPhys:GetPos())
                    end
                    player:SetPos(eyeHit:GetPos())

                    timer.Simple(0.05, function()
                        if IsValid(player) then
                            player:SetColor(ColorAlpha(player:GetColor(), 0))

                            timer.Simple(0.01, function()
                                if IsValid(player) then
                                    player:SetColor(ColorAlpha(player:GetColor(), 255))

                                    timer.Simple(0.01, function()
                                        if IsValid(player) then
                                            player:SetColor(ColorAlpha(player:GetColor(), 0))

                                            timer.Simple(0.035, function()
                                                if IsValid(player) then
                                                    player:SetColor(ColorAlpha(player:GetColor(), 255))
                                                end
                                            end)
                                        end
                                    end)
                                end
                            end)
                        end
                    end)

                    if IsValid(targetPhys) and IsValid(playerPhys) then
                        targetPhys:SetVelocity(oldVelocity)
                        targetPhys:SetPos(oldPhysPos)
                    end
                    eyeHit:SetPos(oldPos)

                    timer.Simple(0.05, function()
                        if IsValid(eyeHit) then
                            eyeHit:SetColor(ColorAlpha(eyeHit:GetColor(), 0))

                            timer.Simple(0.01, function()
                                if IsValid(eyeHit) then
                                    eyeHit:SetColor(ColorAlpha(eyeHit:GetColor(), 255))

                                    timer.Simple(0.01, function()
                                        if IsValid(eyeHit) then
                                            eyeHit:SetColor(ColorAlpha(eyeHit:GetColor(), 0))

                                            timer.Simple(0.035, function()
                                                if IsValid(eyeHit) then
                                                    eyeHit:SetColor(ColorAlpha(eyeHit:GetColor(), 255))
                                                end
                                            end)
                                        end
                                    end)
                                end
                            end)
                        end
                    end)

                    timer.Simple(0.25, function()
                        net.Start("AmenotejikaraEffectRemove")
                        net.Send(player)

                        player:ScreenFade(SCREENFADE.IN, Color(255,255,255,175), 0.2, 0)

                        if IsValid(player) then
                            player:EmitSound(teleportSound)
                        end

                        if IsValid(eyeHit) then
                            eyeHit:EmitSound(teleportSound)
                        end

                        player:GodDisable()

                        entity1 = nil
                        entity2 = nil
                    end)
                end
            end)
        elseif IsValid(eyeHit) and not eyeHit:IsWorld() and distance <= self.AmenotejikaraRange and player:KeyDown(IN_WALK) and not amaterasuBlackList[eyeHit:GetClass()] then
            if not IsValid(entity1) then
                entity1 = eyeHit
                player:ChatPrint("Entity1 set")
            elseif IsValid(entity1) and not IsValid(entity2) and eyeHit ~= entity1 then
                entity2 = eyeHit
                player:ChatPrint("Entity2 set")
            end

            if IsValid(entity1) and IsValid(entity2) then
                self.AmenotejikaraStart = CurTime()
                self:SetAmenotejikaraTime(CurTime())

                ---Effects and sound
                player:EmitSound(rinneganSound)
                util.ScreenShake(player:GetPos(), 10, 10, 0.45, 0)

                local oldPos = entity1:GetPos()
                local entity2Phys = entity2:GetPhysicsObject()
                local entity1Phys = entity1:GetPhysicsObject()
                local oldPhysPos = entity1Phys:GetPos()

                entity1:SetRenderMode(RENDERMODE_TRANSCOLOR)
                entity2:SetRenderMode(RENDERMODE_TRANSCOLOR)

                if IsValid(entity2Phys) and IsValid(entity1Phys) then
                    entity1Phys:SetPos(entity2Phys:GetPos())
                end
                entity1:SetPos(entity2:GetPos())

                timer.Simple(0.05, function()
                    if IsValid(entity1) then
                        entity1:SetColor(ColorAlpha(entity1:GetColor(), 0))

                        timer.Simple(0.01, function()
                            if IsValid(entity1) then
                                entity1:SetColor(ColorAlpha(entity1:GetColor(), 255))

                                timer.Simple(0.01, function()
                                    if IsValid(entity1) then
                                        entity1:SetColor(ColorAlpha(entity1:GetColor(), 0))

                                        timer.Simple(0.035, function()
                                            if IsValid(entity1) then
                                                entity1:SetColor(ColorAlpha(entity1:GetColor(), 255))
                                            end
                                        end)
                                    end
                                end)
                            end
                        end)
                    end
                end)

                if IsValid(entity2Phys) and IsValid(entity1Phys) then
                    entity2Phys:SetPos(oldPhysPos)
                end
                entity2:SetPos(oldPos)

                timer.Simple(0.05, function()
                    if IsValid(entity2) then
                        entity2:SetColor(ColorAlpha(entity2:GetColor(), 0))

                        timer.Simple(0.01, function()
                            if IsValid(entity2) then
                                entity2:SetColor(ColorAlpha(entity2:GetColor(), 255))

                                timer.Simple(0.01, function()
                                    if IsValid(entity2) then
                                        entity2:SetColor(ColorAlpha(entity2:GetColor(), 0))

                                        timer.Simple(0.035, function()
                                            if IsValid(entity2) then
                                                entity2:SetColor(ColorAlpha(entity2:GetColor(), 255))
                                            end
                                        end)
                                    end
                                end)
                            end
                        end)
                    end
                end)

                timer.Simple(0.25, function()
                    if IsValid(entity1) then
                        entity1:EmitSound(teleportSound)
                    end

                    if IsValid(entity2) then
                        entity2:EmitSound(teleportSound)
                    end

                    entity1 = nil
                    entity2 = nil
                end)
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
                dmgInfo:SetDamageForce(player:GetAimVector() * 500000)
                
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
    end
end

function SWEP:SecondaryAttack()
    if CurTime() - self.KagutsuchiStart >= self.KagutsuchiCD and not self.IsAttacking and not self.SusanooActive and not self.RinneganMode then
        self.KagutsuchiStart = CurTime()
        self:SetKagutsuchiTime(CurTime())
        self.AmaterasuStart = CurTime()
        self:SetAmaterasuTime(CurTime())

        local player = self:GetOwner()

        if SERVER then
            net.Start("SpawnAmaterasu")
            net.WriteEntity(player)
            net.Broadcast()
        end

        self:EmitSound(amaterasuSound)
        self.FlameCloakActive = true

        timer.Simple(5, function()
            if IsValid(player) then
                self.FlameCloakActive = false

                if SERVER then
                    MS_StopAmaterasu(player)
                end
            end
        end)
    elseif CurTime() - self.ShinraTenseiStart >= self.ShinraTenseiCD and not self.IsAttacking and not self.SusanooActive and self.RinneganMode and SERVER then
        local player = self:GetOwner()
        
        player:LagCompensation(true)
        
        local eyeHit = player:GetEyeTrace().Entity --Get the entity player is looking at
        
        local distance = player:GetPos():Distance(eyeHit:GetPos()) --Get the distance on the entity and player
        if IsValid(eyeHit) and not eyeHit:IsWorld() and distance <= self.ShinraTenseiRange and not player:KeyDown(IN_DUCK) and not player:KeyDown(IN_WALK) and not amaterasuBlackList[eyeHit:GetClass()] then
            self.ShinraTenseiStart = CurTime()
            self:SetShinraTenseiTime(CurTime())

            self:SetHoldType("magic")
            
            --Effects and sound
            player:EmitSound(rinneganSound)

            player:ScreenFade(SCREENFADE.IN, Color(255,255,255,150), 0.45, 0)
            util.ScreenShake(player:GetPos(), 5, 5, 0.25, 5)

            timer.Simple((distance / 15000), function() --Add delay based on distance from player
                if IsValid(eyeHit) and IsValid(self) then
                    self.IsAttacking = false

                    self:EmitSound(shinraTenseiSound)

                    local damageInfo = DamageInfo()
                    damageInfo:SetDamage(self.ShinraTenseiDamage)
                    damageInfo:SetAttacker(player or eyeHit)
                    damageInfo:SetInflictor(self or player)
                    damageInfo:SetDamageForce(player:EyePos())
                    eyeHit:TakeDamageInfo(damageInfo)

                    if eyeHit:IsPlayer() then
                        eyeHit:SetLocalVelocity((eyeHit:GetPos() - player:GetPos()) * 5000 + eyeHit:GetUp() * 750)
                    elseif eyeHit:IsNPC() then
                        eyeHit:SetLocalVelocity((eyeHit:GetPos() - player:GetPos()) * 2000 + eyeHit:GetUp() * 750)

                        if IsValid(eyeHit:GetPhysicsObject()) then
                            local phys = eyeHit:GetPhysicsObject()
                            phys:EnableMotion(true)
                            phys:AddVelocity((eyeHit:GetPos() - player:GetPos()) * 2500)
                        end
                    elseif IsValid(eyeHit:GetPhysicsObject()) then
                        local phys = eyeHit:GetPhysicsObject()
                        phys:EnableMotion(true)
                        phys:AddVelocity((eyeHit:GetPos() - player:GetPos()) * 25000)
                    end

                    for _, v in ipairs(ents.FindInSphere(eyeHit:GetPos(), 150)) do
                        if IsValid(v) and v ~= player and v ~= eyeHit and not amaterasuBlackList[v:GetClass()] then
                            damageInfo:SetDamage(self.ShinraTenseiDamage / 4)
                            v:TakeDamageInfo(damageInfo)
                            if v:IsPlayer() then
                                v:SetLocalVelocity((v:GetPos() - player:GetPos()) * 5000 + v:GetUp() * 750)
                            elseif v:IsNPC() then
                                v:SetLocalVelocity((v:GetPos() - player:GetPos()) * 2000 + v:GetUp() * 750)

                                if IsValid(v:GetPhysicsObject()) then
                                    local phys = v:GetPhysicsObject()
                                    phys:EnableMotion(true)
                                    phys:AddVelocity((v:GetPos() - player:GetPos()) * 2500)
                                end
                            elseif IsValid(v:GetPhysicsObject()) then
                                local phys = v:GetPhysicsObject()
                                phys:EnableMotion(true)
                                phys:AddVelocity((v:GetPos() - player:GetPos()) * 25000)
                            end
                        end
                    end
                end
            end)
        elseif IsValid(player) and player:KeyDown(IN_DUCK) and not player:KeyDown(IN_WALK) then
            self.ShinraTenseiStart = CurTime()
            self:SetShinraTenseiTime(CurTime())

            self:SetHoldType("magic")

            --Effects and sound
            player:EmitSound(rinneganSound)
            player:EmitSound(shinraTenseiSound)

            player:ScreenFade(SCREENFADE.IN, Color(255,255,255,150), 0.45, 0)
            util.ScreenShake(player:GetPos(), 5, 5, 0.25, 5)

            for _, v in ipairs(ents.FindInSphere(player:GetPos(), 200)) do
                if IsValid(v) and v ~= player and not amaterasuBlackList[v:GetClass()] then
                    v:TakeDamage(self.ShinraTenseiDamage / 4, player, self)
                    if v:IsPlayer() then
                        v:SetLocalVelocity((v:GetPos() - player:GetPos()) * 5000 + v:GetUp() * 750)
                    elseif v:IsNPC() then
                        v:SetLocalVelocity((v:GetPos() - player:GetPos()) * 2000 + v:GetUp() * 750)

                        if IsValid(v:GetPhysicsObject()) then
                            local phys = v:GetPhysicsObject()
                            phys:EnableMotion(true)
                            phys:AddVelocity((v:GetPos() - player:GetPos()) * 2500)
                        end
                    elseif IsValid(v:GetPhysicsObject()) then
                        local phys = v:GetPhysicsObject()
                        phys:EnableMotion(true)
                        phys:AddVelocity((v:GetPos() - player:GetPos()) * 25000)
                    end
                end
            end
        elseif IsValid(eyeHit) and not eyeHit:IsWorld() and distance <= (self.ShinraTenseiRange * 3.55) and not player:KeyDown(IN_DUCK) and player:KeyDown(IN_WALK) and not amaterasuBlackList[eyeHit:GetClass()] then
            self.ShinraTenseiStart = CurTime()
            self:SetShinraTenseiTime(CurTime())

            self:SetHoldType("magic")
            
            --Effects and sound
            player:EmitSound(rinneganSound)

            player:ScreenFade(SCREENFADE.IN, Color(255,255,255,150), 0.45, 0)
            util.ScreenShake(player:GetPos(), 5, 5, 0.25, 5)

            timer.Simple((distance / 15000), function() --Add delay based on distance from player
                if IsValid(eyeHit) and IsValid(self) then
                    self.IsAttacking = false

                    self:EmitSound(shinraTenseiSound)

                    eyeHit:TakeDamage(self.ShinraTenseiDamage / 2, player, self)

                    if eyeHit:IsPlayer() then
                        eyeHit:SetLocalVelocity((player:GetPos() - eyeHit:GetPos()) * 750 + Vector(0,0,10))

                        if not eyeHit:MS_UsingMangekyou() then
                            eyeHit:DropWeapon(nil, player:GetPos())
                        end
                    elseif eyeHit:IsNPC() then
                        eyeHit:SetLocalVelocity((player:GetPos() - eyeHit:GetPos()) * 500 + Vector(0,0,25))
                        eyeHit:DropWeapon(nil, player:GetPos())

                        if IsValid(eyeHit:GetPhysicsObject()) then
                            local phys = eyeHit:GetPhysicsObject()
                            phys:EnableMotion(true)
                            phys:AddVelocity((player:GetPos() - eyeHit:GetPos()) * 1.5 + Vector(0,0,10))
                        end
                    elseif IsValid(eyeHit:GetPhysicsObject()) then
                        local phys = eyeHit:GetPhysicsObject()
                        phys:EnableMotion(true)
                        phys:AddVelocity((player:GetPos() - eyeHit:GetPos()) * 1.5 + Vector(0,0,10))
                    end
                end
            end)
        elseif IsValid(player) and player:KeyDown(IN_DUCK) and player:KeyDown(IN_WALK) then
            self.ShinraTenseiStart = CurTime()
            self:SetShinraTenseiTime(CurTime())

            self:SetHoldType("magic")

            --Effects and sound
            player:EmitSound(rinneganSound)
            player:EmitSound(shinraTenseiSound)

            player:ScreenFade(SCREENFADE.IN, Color(255,255,255,150), 0.45, 0)
            util.ScreenShake(player:GetPos(), 5, 5, 0.25, 5)

            for _, v in ipairs(ents.FindInSphere(player:GetPos(), 1000)) do
                if IsValid(v) and v ~= player and not amaterasuBlackList[v:GetClass()] then
                    v:TakeDamage(self.ShinraTenseiDamage / 5, player, self)

                    if v:IsPlayer() then
                        v:SetLocalVelocity((player:GetPos() - v:GetPos()) * 750 + Vector(0,0,10))
                        if not v:MS_UsingMangekyou() then
                            v:DropWeapon(nil, player:GetPos())
                        end
                    elseif v:IsNPC() then
                        v:SetLocalVelocity((player:GetPos() - v:GetPos()) * 500 + Vector(0,0,25))
                        v:DropWeapon(nil, player:GetPos())

                        if IsValid(v:GetPhysicsObject()) then
                            local phys = v:GetPhysicsObject()
                            phys:EnableMotion(true)
                            phys:AddVelocity((player:GetPos() - v:GetPos()) * 1.5 + Vector(0,0,10))
                        end
                    elseif IsValid(v:GetPhysicsObject()) then
                        local phys = v:GetPhysicsObject()
                        phys:EnableMotion(true)
                        phys:AddVelocity((player:GetPos() - v:GetPos()) * 1.5 + Vector(0,0,10))
                    end
                end
            end
        end
        timer.Simple(0.85, function()
            if IsValid(self) then
                self:SetHoldType("normal")
            end
        end)
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
    if not self.SusanooActive then
        if game.SinglePlayer() then
            self:CallOnClient("Counter")
            self:Counter()
        else
            self:Counter()
        end
    elseif self.SusanooActive then
        self:Fly()
    end
end

function SWEP:Counter() --Im using a function instead of typing in in SWEP:Reload(), so i can call it on client in singleplayer
    if CurTime() - self.CounterStart >= self.CounterCD and not self.IsInCounter and not self.SusanooActive and not self.FlameCloakActive then
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
                [ "$pp_colour_contrast" ] = 0.15,
                [ "$pp_colour_colour" ] = 0,
                [ "$pp_colour_mulr" ] = 0.0,
                [ "$pp_colour_mulg" ] = 0,
                [ "$pp_colour_mulb" ] = 0
            }
            hook.Add("RenderScreenspaceEffects", "SasukeCounterColor " .. player:Nick(), function()
                DrawColorModify(counterColor)
            end)
        end

        timer.Create("Sasuke Counter " .. player:Nick(), self.CounterDuration, 1, function()
            if IsValid(player) then
                self.CounterStart = CurTime()
                self:SetCounterTime(CurTime())
                self.IsInCounter = false
                self.IsAttacking = false
                
                hook.Remove("RenderScreenspaceEffects", "SasukeCounterColor " .. player:Nick())
            end
        end)
    end
end

function SWEP:Susanoo()
    if CurTime() - self.SusanooStart >= self.SusanooCD and not self.IsInCounter and util.IsValidModel(self.SusanooModel) then
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
            if self.HasRinnegan then
                player:MS_SetScale(6.25, 0.25)
            else
                player:MS_SetScale(5.5, 0.25)
            end
            self:SetHoldType("melee")
            player:SetMoveType(MOVETYPE_WALK)

            self.SusanooFlightMode = false

            if SERVER then
                player:SetHealth(self:GetSusanooHealth())
                player:SetArmor(40)
                MS_StopAmaterasu(player)
            end

            if SERVER then
                if util.IsValidModel(Model("models/sasuke_sword/madara_sword.mdl")) then
                    local sword = ents.Create("prop_dynamic")
                    sword:SetModel(Model("models/sasuke_sword/madara_sword.mdl"))
                    if self.HasRinnegan then
                        sword:SetModelScale(5.75)
                    else
                        sword:SetModelScale(5)
                    end
                    sword:SetPos(player:GetPos() + player:GetForward() * 3.25 + player:GetRight() * 1.25 + -player:GetUp() * 2)
                    sword:SetAngles(player:GetAngles() + Angle(90,0,0))
                    sword:FollowBone(player, player:LookupBone("ValveBiped.Bip01_R_Hand"))
                    sword:Spawn()
                else
                    player:ChatPrint("Susanoo didn't load correctly. Please restart Garry's Mod and reinstall susanoo pack.")
                end
            end

            if SERVER then
                net.Start("AddHalo")
                net.WriteEntity(player)
                net.WriteColor(Color(255,0,255))
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

            --Set sharingan eye on model if having the sasuke model
            if GetConVar("sasuke_eye_change"):GetInt() == 1 then
                if player:GetModel() == "models/sasukeall/sasukeall.mdl" then
                    if self.RinneganMode then
                        player:SetBodygroup(4, 0)
                    else
                        player:SetBodygroup(4, 2)
                    end
                    player:SetBodygroup(5, 2)
                end
            end

            if SERVER then
                for k, v in ipairs(player:GetChildren()) do
                    if v:GetClass() == "prop_dynamic" and string.match(v:GetModel(), "sword") then
                        v:Remove()
                    end
                end
            end
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
    if GetConVar("sasuke_disableHud"):GetInt() == 0 then
        local player = LocalPlayer()

        local amaterasuEYE = {
            texture = surface.GetTextureID("huds/sasuke"),
            x = ScrW() / 1.045,
            y = ScrH() / 2,
            w = relativeW(64),
            h = relativeH(64)
        }

        local kagutsuchiEYE = {
            texture = surface.GetTextureID("huds/sasuke"),
            x = ScrW() / 1.045,
            y = ScrH() / 1.75,
            w = relativeW(64),
            h = relativeH(64)
        }
        local counterEYE = {
            texture = surface.GetTextureID("huds/sasuke"),
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

        local rinneganEYE = {
            texture = surface.GetTextureID("huds/sasuke_rinnegan"),
            x = ScrW() / 1.045,
            y = ScrH() / 2,
            w = relativeW(64),
            h = relativeH(64)
        }

        local rinnegan2EYE = {
            texture = surface.GetTextureID("huds/sasuke_rinnegan"),
            x = ScrW() / 1.045,
            y = ScrH() / 1.75,
            w = relativeW(64),
            h = relativeH(64)
        }
    
        --Amaterasu/Susanoo Slash HUD
        draw.NoTexture()
        surface.SetDrawColor(GetConVar("sasuke_r"):GetInt(), GetConVar("sasuke_g"):GetInt(), GetConVar("sasuke_b"):GetInt(), 255)
        if self.SusanooActive then
            draw.SimpleText("Slash", "NarutoFont", ScrW() / 1.13, ScrH() / 1.92)
            draw.Circle(ScrW() / 1.0273, ScrH() / 1.8875, Lerp((CurTime() - self:GetSusanooSlashTime()) / self.SusanooPrimaryCD, 0, relativeW(31)), 64)
        elseif self.RinneganMode then
            if player:KeyDown(IN_WALK) then
                draw.SimpleText("Switch Ent", "NarutoFont", ScrW() / 1.13, ScrH() / 1.92)
            else
                draw.SimpleText("Switch Self", "NarutoFont", ScrW() / 1.13, ScrH() / 1.92)
            end
            draw.Circle(ScrW() / 1.0273, ScrH() / 1.8875, Lerp((CurTime() - self:GetAmenotejikaraTime()) / self.AmenotejikaraCD, 0, relativeW(31)), 64)
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
        if self.RinneganMode then
            draw.TexturedQuad(rinneganEYE)
        else
            draw.TexturedQuad(amaterasuEYE)
        end

        --Kagutsuchi/Throw HUD
        draw.NoTexture()
        surface.SetDrawColor(GetConVar("sasuke_r"):GetInt(), GetConVar("sasuke_g"):GetInt(), GetConVar("sasuke_b"):GetInt(), 255)
        if self.SusanooActive then
            draw.SimpleText("Sword Throw", "NarutoFont", ScrW() / 1.13, ScrH() / 1.685)
            draw.Circle(ScrW() / 1.0273, ScrH() / 1.665, Lerp((CurTime() - self:GetSusanooSecondaryTime()) / self.SusanooSecondaryCD, 0, relativeW(31)), 64)
        elseif self.RinneganMode then
            if player:KeyDown(IN_DUCK) and not player:KeyDown(IN_WALK) then
                draw.SimpleText("Shinra AOE", "NarutoFont", ScrW() / 1.13, ScrH() / 1.685)
            elseif player:KeyDown(IN_WALK) and not player:KeyDown(IN_DUCK) then
                draw.SimpleText("Bansho Tenin", "NarutoFont", ScrW() / 1.13, ScrH() / 1.685)
            elseif player:KeyDown(IN_WALK) and player:KeyDown(IN_DUCK) then
                draw.SimpleText("Bansho AOE", "NarutoFont", ScrW() / 1.13, ScrH() / 1.685)
            else
                draw.SimpleText("Shinra Tensei", "NarutoFont", ScrW() / 1.13, ScrH() / 1.685)
            end
            draw.Circle(ScrW() / 1.0273, ScrH() / 1.665, Lerp((CurTime() - self:GetShinraTenseiTime()) / self.ShinraTenseiCD, 0, relativeW(31)), 64)
        else
            draw.SimpleText("Kagutsuchi", "NarutoFont", ScrW() / 1.13, ScrH() / 1.685)
            draw.Circle(ScrW() / 1.0273, ScrH() / 1.665, Lerp((CurTime() - self:GetKagutsuchiTime()) / self.KagutsuchiCD, 0, relativeW(31)), 64)
        end
        if self.RinneganMode then
            draw.TexturedQuad(rinnegan2EYE)
        else
            draw.TexturedQuad(kagutsuchiEYE)
        end

        --Counter HUD
        draw.NoTexture()
        surface.SetDrawColor(GetConVar("sasuke_r"):GetInt(), GetConVar("sasuke_g"):GetInt(), GetConVar("sasuke_b"):GetInt(), 255)
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
                surface.SetDrawColor(GetConVar("sasuke_r"):GetInt(), GetConVar("sasuke_g"):GetInt(), GetConVar("sasuke_b"):GetInt(), 255)
                draw.TexturedQuad(susanoo)
            else
                surface.SetDrawColor(GetConVar("sasuke_r"):GetInt(), GetConVar("sasuke_g"):GetInt(), GetConVar("sasuke_b"):GetInt(), 255)
                draw.TexturedQuad(susanooNoWings)
            end
        end
    end
end

hook.Add("EntityTakeDamage", "SasukeTakeDamage", function(entity, dmg)
    if IsValid(entity) and entity:IsPlayer() then
        if entity:MS_UsingSasuke() then
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
    
                    entity:Freeze(false)
                    attacker:Ignite(weapon.AmaterasuLength)
                    weapon:EmitSound(amaterasuSound)
                    attacker:EmitSound(amaterasuHitSound)
                    MS_StartAmaterasu(attacker)
                    MS_StopAmaterasu(entity)
    
                    hook.Remove("RenderScreenspaceEffects", "SasukeCounterColor " .. entity:Nick())
                    timer.Remove("Sasuke Counter " .. entity:Nick())
                    net.Start("RemoveSasukeCounter")
                    net.Send(entity)
    
                    weapon.CounterStart = CurTime()
                    weapon:SetCounterTime(CurTime())
                    weapon.IsInCounter = false
                    weapon.IsAttacking = false
    
                    timer.Simple(0.1, function()
                        if IsValid(entity) then
                            MS_StopAmaterasu(entity)
                        end
                    end)
                    return true
                end
            end

            --Hurt Sound
            if GetConVar("sasuke_voice"):GetInt() == 1 and IsValid(weapon) and IsValid(entity) and not weapon.SusanooActive then
                local randomNum = math.floor(util.SharedRandom("RandomHurt", 1, #hurtSounds, CurTime()) + 0.5)
                weapon:EmitSound(hurtSounds[randomNum])
            end
        end
    end
end)

hook.Add("GetFallDamage", "SasukeNoFall", function(player, speed)
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

hook.Add("DoPlayerDeath", "SasukeDeath", function(victim, inflict, attacker)
    if victim:IsPlayer() then

        victim:StopClientSound(themeSound)
        victim:StopClientSound(kagutsuchiTrappedSound)

        if victim:MS_UsingSasuke() then
            local weapon = victim:GetActiveWeapon()
    
            if GetConVar("sasuke_voice"):GetInt() == 1 then 
                victim:EmitSound(deathSound)
            end
    
            weapon.IsAttacking = false
            weapon.IsInCounter = false
            weapon.FlameCloakActive = false
            victim.IsOnAmaterasu = false

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
        hook.Remove("RenderScreenspaceEffects", "SasukeCounterColor " .. victim:Nick())
        timer.Remove("Sasuke Counter " .. victim:Nick())
    
        if SERVER then
            victim:SetLaggedMovementValue(1)
        end
    end
end)

hook.Add("PlayerButtonDown", "sasuke_susanoo", function(player, button)
    if IsValid(player) and player:Alive() and not player:IsFrozen() and player:MS_UsingSasuke() and button == KEY_B then
        local weapon = player:GetActiveWeapon()
        weapon:Susanoo()
    end
end)

hook.Add("PlayerButtonDown", "sasuke_rinnegan_mode", function(player, button)
    if IsValid(player) and player:Alive() and not player:IsFrozen() and player:MS_UsingSasuke() and button == KEY_G then
        local weapon = player:GetActiveWeapon()
        if weapon.HasRinnegan and CurTime() - weapon.ChangeModeStart >= weapon.ChangeModeCD then
            weapon.ChangeModeStart = CurTime()

            weapon.RinneganMode = not weapon.RinneganMode
    
            if weapon.RinneganMode then
                weapon:EmitSound(rinneganSound)
                player:SetBodygroup(4, 0)
            else
                weapon:EmitSound(activationSound)
                player:SetBodygroup(4, 2)
            end
        end
    end
end)

hook.Add("PlayerButtonDown", "sasuke_quote", function(player, button)
    if IsValid(player) and player:Alive() and not player:IsFrozen() and player:MS_UsingSasuke() and button == KEY_M then
        local weapon = player:GetActiveWeapon()
        weapon:Quote()
    end
end)

hook.Add("PlayerFootstep", "SasukeSusanooStep", function(player, pos, foot, sound, volume)
    if IsValid(player) and player:Alive() and player:MS_UsingSasuke() then
        local weapon = player:GetActiveWeapon()

        if weapon.SusanooActive then
            player:EmitSound(susanooStepSound, 75)
            util.ScreenShake(player:GetPos(), 5, 2, 0.05, 300)
            return true
        end
    end
end)