--ConVars
--ITACHI
if CLIENT then
    CreateClientConVar("itachi_disableHud", 0, true)
    CreateClientConVar("itachi_voice", 1, true, true)
    CreateClientConVar("itachi_eye_change", 1, true, true)
    --Colors
    CreateClientConVar("itachi_r", 185, true)
    CreateClientConVar("itachi_g", 0, true)
    CreateClientConVar("itachi_b", 0, true)
    --Themes
    CreateConVar("itachi_theme", 1, {FCVAR_USERINFO, FCVAR_ARCHIVE})
end
--Amaterasu Settings
CreateConVar("itachi_amaterasu_cd", 7.5, {FCVAR_REPLICATED, FCVAR_ARCHIVE})
CreateConVar("itachi_amaterasu_range", 1250, {FCVAR_REPLICATED, FCVAR_ARCHIVE})
CreateConVar("itachi_amaterasu_length", 1000, {FCVAR_REPLICATED, FCVAR_ARCHIVE})
CreateConVar("itachi_amaterasu_damage", 75, {FCVAR_REPLICATED, FCVAR_ARCHIVE})
CreateConVar("itachi_amaterasu_aoe", 1, {FCVAR_REPLICATED, FCVAR_ARCHIVE})
--Tsukuyomi Settings
CreateConVar("itachi_tsukuyomi_cd", 20, {FCVAR_REPLICATED, FCVAR_ARCHIVE})
CreateConVar("itachi_tsukuyomi_range", 450, {FCVAR_REPLICATED, FCVAR_ARCHIVE})
CreateConVar("itachi_tsukuyomi_damage", 200, {FCVAR_REPLICATED, FCVAR_ARCHIVE})
--Itachi Counter
CreateConVar("itachi_counter_cd", 7, {FCVAR_REPLICATED, FCVAR_ARCHIVE})
CreateConVar("itachi_counter_duration", 5, {FCVAR_REPLICATED, FCVAR_ARCHIVE})
--Itachi Susanoo
CreateConVar("itachi_susanoo_cd", 10, {FCVAR_REPLICATED, FCVAR_ARCHIVE})
CreateConVar("itachi_susanoo_health", 3500, {FCVAR_REPLICATED, FCVAR_ARCHIVE})
CreateConVar("itachi_susanoo_primary_cd", 0.75, {FCVAR_REPLICATED, FCVAR_ARCHIVE})
CreateConVar("itachi_susanoo_primary_damage", 350, {FCVAR_REPLICATED, FCVAR_ARCHIVE})
CreateConVar("itachi_susanoo_secondary_cd", 5, {FCVAR_REPLICATED, FCVAR_ARCHIVE})
CreateConVar("itachi_susanoo_secondary_damage", 550, {FCVAR_REPLICATED, FCVAR_ARCHIVE})
CreateConVar("itachi_susanoo_wings_cd", 1, {FCVAR_REPLICATED, FCVAR_ARCHIVE})

--SASUKE
if CLIENT then
    CreateClientConVar("sasuke_disableHud", 0, true)
    CreateClientConVar("sasuke_voice", 1, true, true)
    CreateClientConVar("sasuke_eye_change", 1, true, true)
    --Colors
    CreateClientConVar("sasuke_r", 185, true)
    CreateClientConVar("sasuke_g", 0, true)
    CreateClientConVar("sasuke_b", 0, true)
    --Themes
    CreateConVar("sasuke_theme", 1, {FCVAR_USERINFO, FCVAR_ARCHIVE})
end
--Amaterasu Settings
CreateConVar("sasuke_amaterasu_cd", 4, {FCVAR_REPLICATED, FCVAR_ARCHIVE})
CreateConVar("sasuke_amaterasu_range", 2500, {FCVAR_REPLICATED, FCVAR_ARCHIVE})
CreateConVar("sasuke_amaterasu_length", 1000, {FCVAR_REPLICATED, FCVAR_ARCHIVE})
CreateConVar("sasuke_amaterasu_damage", 160, {FCVAR_REPLICATED, FCVAR_ARCHIVE})
CreateConVar("sasuke_amaterasu_aoe", 1, {FCVAR_REPLICATED, FCVAR_ARCHIVE})
--Tsukuyomi Settings
CreateConVar("sasuke_kagutsuchi_cd", 20, {FCVAR_REPLICATED, FCVAR_ARCHIVE})
CreateConVar("sasuke_kagutsuchi_range", 450, {FCVAR_REPLICATED, FCVAR_ARCHIVE})
CreateConVar("sasuke_kagutsuchi_damage", 200, {FCVAR_REPLICATED, FCVAR_ARCHIVE})
--Itachi Counter
CreateConVar("sasuke_counter_cd", 8, {FCVAR_REPLICATED, FCVAR_ARCHIVE})
CreateConVar("sasuke_counter_duration", 6, {FCVAR_REPLICATED, FCVAR_ARCHIVE})
--Itachi Susanoo
CreateConVar("sasuke_susanoo_cd", 10, {FCVAR_REPLICATED, FCVAR_ARCHIVE})
CreateConVar("sasuke_susanoo_health", 5000, {FCVAR_REPLICATED, FCVAR_ARCHIVE})
CreateConVar("sasuke_susanoo_primary_cd", 0.75, {FCVAR_REPLICATED, FCVAR_ARCHIVE})
CreateConVar("sasuke_susanoo_primary_damage", 350, {FCVAR_REPLICATED, FCVAR_ARCHIVE})
CreateConVar("sasuke_susanoo_secondary_cd", 5, {FCVAR_REPLICATED, FCVAR_ARCHIVE})
CreateConVar("sasuke_susanoo_secondary_damage", 550, {FCVAR_REPLICATED, FCVAR_ARCHIVE})
CreateConVar("sasuke_susanoo_wings_cd", 1, {FCVAR_REPLICATED, FCVAR_ARCHIVE})

--OBITO
if CLIENT then
    CreateClientConVar("obito_disableHud", 0, true)
    CreateClientConVar("obito_voice", 1, true, true)
    CreateClientConVar("obito_eye_change", 1, true, true)
    --Colors
    CreateClientConVar("obito_r", 185, true)
    CreateClientConVar("obito_g", 0, true)
    CreateClientConVar("obito_b", 0, true)
    --Themes
    CreateConVar("obito_theme", 1, {FCVAR_USERINFO, FCVAR_ARCHIVE})
end
--Amaterasu Settings
CreateConVar("obito_amaterasu_cd", 4, {FCVAR_REPLICATED, FCVAR_ARCHIVE})
CreateConVar("obito_amaterasu_range", 2500, {FCVAR_REPLICATED, FCVAR_ARCHIVE})
CreateConVar("obito_amaterasu_length", 1000, {FCVAR_REPLICATED, FCVAR_ARCHIVE})
CreateConVar("obito_amaterasu_damage", 160, {FCVAR_REPLICATED, FCVAR_ARCHIVE})
CreateConVar("obito_amaterasu_aoe", 1, {FCVAR_REPLICATED, FCVAR_ARCHIVE})
--Tsukuyomi Settings
CreateConVar("obito_kagutsuchi_cd", 5, {FCVAR_REPLICATED, FCVAR_ARCHIVE})
CreateConVar("obito_kagutsuchi_range", 450, {FCVAR_REPLICATED, FCVAR_ARCHIVE})
CreateConVar("obito_kagutsuchi_damage", 200, {FCVAR_REPLICATED, FCVAR_ARCHIVE})
--Itachi Counter
CreateConVar("obito_counter_cd", 8, {FCVAR_REPLICATED, FCVAR_ARCHIVE})
CreateConVar("obito_counter_duration", 6, {FCVAR_REPLICATED, FCVAR_ARCHIVE})
--Itachi Susanoo
CreateConVar("obito_susanoo_cd", 10, {FCVAR_REPLICATED, FCVAR_ARCHIVE})
CreateConVar("obito_susanoo_health", 5000, {FCVAR_REPLICATED, FCVAR_ARCHIVE})
CreateConVar("obito_susanoo_primary_cd", 0.75, {FCVAR_REPLICATED, FCVAR_ARCHIVE})
CreateConVar("obito_susanoo_primary_damage", 350, {FCVAR_REPLICATED, FCVAR_ARCHIVE})
CreateConVar("obito_susanoo_secondary_cd", 5, {FCVAR_REPLICATED, FCVAR_ARCHIVE})
CreateConVar("obito_susanoo_secondary_damage", 550, {FCVAR_REPLICATED, FCVAR_ARCHIVE})
CreateConVar("obito_susanoo_wings_cd", 1, {FCVAR_REPLICATED, FCVAR_ARCHIVE})

--Configs
if CLIENT then
    hook.Add("AddToolMenuCategories", "CreateSharinganTab", function()
        spawnmenu.AddToolCategory("Options", "Sharingan", "#Sharingan")
    end)

    hook.Add("PopulateToolMenu", "CreateSharinganConfig", function()
        spawnmenu.AddToolMenuOption("Options", "Sharingan", "Itachi Sharingan", "Itachi Sharingan", "", "", function(panel)
            if LocalPlayer():IsAdmin() then
                panel:Help("Change Itachi's abilities.")
                panel:NumSlider("Amaterasu Cooldown:", "itachi_amaterasu_cd", 1, 100)
                panel:ControlHelp("Default: 7.5 seconds")
                panel:NumSlider("Amaterasu Range:", "itachi_amaterasu_range", 50, 10000)
                panel:ControlHelp("Default: 1250")
                panel:NumSlider("Amaterasu Length:", "itachi_amaterasu_length", 5, 10000)
                panel:ControlHelp("Default: 1000")
                panel:NumSlider("Amaterasu Damage:", "itachi_amaterasu_damage", 0, 1000)
                panel:ControlHelp("Default: 75")
                panel:CheckBox("Amaterasu AOE:", "itachi_amaterasu_aoe")
                panel:ControlHelp("If amaterasu will ignite more entities at once.\nDefault: true")
                panel:NumSlider("Tsukuyomi Cooldown:", "itachi_tsukuyomi_cd", 1, 100)
                panel:ControlHelp("Default: 20.0 seconds")
                panel:NumSlider("Tsukuyomi Range:", "itachi_tsukuyomi_range", 50, 10000)
                panel:ControlHelp("Default: 450")
                panel:NumSlider("Tsukuyomi Damage:", "itachi_tsukuyomi_damage", 0, 1000)
                panel:ControlHelp("Default: 200")
                panel:NumSlider("Counter Cooldown:", "itachi_counter_cd", 1, 100)
                panel:ControlHelp("Default: 7.0 seconds")
                panel:NumSlider("Counter Duration:", "itachi_counter_duration", 1, 100)
                panel:ControlHelp("Default: 5.0 seconds")
                panel:NumSlider("Susanoo Cooldown:", "itachi_susanoo_cd", 1, 100)
                panel:ControlHelp("Default: 10.0 seconds")
                panel:NumSlider("Susanoo Health:", "itachi_susanoo_health", 500, 10000)
                panel:ControlHelp("Default: 3500")
                panel:NumSlider("Susanoo Wings Cooldown:", "itachi_susanoo_wings_cd", 1, 100)
                panel:ControlHelp("Default: 1.0 seconds")
                panel:NumSlider("Susanoo Slash Cooldown:", "itachi_susanoo_primary_cd", 0.5, 10)
                panel:ControlHelp("Default: 0.75 seconds")
                panel:NumSlider("Susanoo Slash Damage:", "itachi_susanoo_primary_damage", 100, 1000)
                panel:ControlHelp("Default: 350")
                panel:NumSlider("Susanoo Throw Cooldown:", "itachi_susanoo_secondary_cd", 4, 100)
                panel:ControlHelp("Default: 5 seconds")
                panel:NumSlider("Susanoo Throw Damage:", "itachi_susanoo_secondary_damage", 100, 1000)
                panel:ControlHelp("Default: 550")
            end
            panel:CheckBox("Disable HUD", "itachi_disableHud")
            panel:ControlHelp("Default: false")
            panel:CheckBox("Enable Eye Change", "itachi_eye_change")
            panel:ControlHelp("If you have the itachi playermodel, then having this enabled will change player's eyes to sharingan.\nDefault: true")
            panel:CheckBox("Enable Voice Lines", "itachi_voice")
            panel:ControlHelp("Enables itachi's voice lines\nDefault: true")
            panel:CheckBox("Enable Theme", "itachi_theme")
            panel:ControlHelp("Enables itachi's theme\nDefault: true")

            --Color Mixer
            panel:Help("Change the color of GUI")
            local clrMixer = vgui.Create("DColorMixer")
            clrMixer:SetPalette(true)  		--Show/hide the palette			DEF:true
            clrMixer:SetAlphaBar(false) 		--Show/hide the alpha bar		DEF:true
            clrMixer:SetWangs(true)	 		--Show/hide the R G B A indicators 	DEF:true
            clrMixer:SetColor(Color(GetConVarNumber("itachi_r"), GetConVarNumber("itachi_g"), GetConVarNumber("itachi_b")) )	--Set the default color
            clrMixer.ValueChanged = function(self,col)
                RunConsoleCommand("itachi_r", col.r)
                RunConsoleCommand("itachi_g", col.g)
                RunConsoleCommand("itachi_b", col.b)
            end
            panel:AddItem(clrMixer)
        end)
        spawnmenu.AddToolMenuOption("Options", "Sharingan", "Sasuke Sharingan", "Sasuke Sharingan", "", "", function(panel)
            if LocalPlayer():IsAdmin() then
                panel:Help("Change Sasukes's abilities.")
                panel:NumSlider("Amaterasu Cooldown:", "sasuke_amaterasu_cd", 1, 100)
                panel:ControlHelp("Default: 4 seconds")
                panel:NumSlider("Amaterasu Range:", "sasuke_amaterasu_range", 50, 10000)
                panel:ControlHelp("Default: 2500")
                panel:NumSlider("Amaterasu Length:", "sasuke_amaterasu_length", 5, 10000)
                panel:ControlHelp("Default: 1000")
                panel:NumSlider("Amaterasu Damage:", "sasuke_amaterasu_damage", 0, 1000)
                panel:ControlHelp("Default: 150")
                panel:CheckBox("Amaterasu AOE:", "sasuke_amaterasu_aoe")
                panel:ControlHelp("If amaterasu will ignite more entities at once.\nDefault: true")
                panel:NumSlider("Tsukuyomi Cooldown:", "sasuke_kagutsuchi_cd", 1, 100)
                panel:ControlHelp("Default: 20.0 seconds")
                panel:NumSlider("Tsukuyomi Range:", "sasuke_kagutsuchi_range", 50, 10000)
                panel:ControlHelp("Default: 450")
                panel:NumSlider("Tsukuyomi Damage:", "sasuke_kagutsuchi_damage", 0, 1000)
                panel:ControlHelp("Default: 200")
                panel:NumSlider("Counter Cooldown:", "sasuke_counter_cd", 1, 100)
                panel:ControlHelp("Default: 7.0 seconds")
                panel:NumSlider("Counter Duration:", "sasuke_counter_duration", 1, 100)
                panel:ControlHelp("Default: 5.0 seconds")
                panel:NumSlider("Susanoo Cooldown:", "sasuke_susanoo_cd", 1, 100)
                panel:ControlHelp("Default: 10.0 seconds")
                panel:NumSlider("Susanoo Health:", "sasuke_susanoo_health", 500, 10000)
                panel:ControlHelp("Default: 3500")
                panel:NumSlider("Susanoo Wings Cooldown:", "sasuke_susanoo_wings_cd", 1, 100)
                panel:ControlHelp("Default: 1.0 seconds")
                panel:NumSlider("Susanoo Slash Cooldown:", "sasuke_susanoo_primary_cd", 0.5, 10)
                panel:ControlHelp("Default: 0.75 seconds")
                panel:NumSlider("Susanoo Slash Damage:", "sasuke_susanoo_primary_damage", 100, 1000)
                panel:ControlHelp("Default: 350")
                panel:NumSlider("Susanoo Throw Cooldown:", "sasuke_susanoo_secondary_cd", 4, 100)
                panel:ControlHelp("Default: 5 seconds")
                panel:NumSlider("Susanoo Throw Damage:", "sasuke_susanoo_secondary_damage", 100, 1000)
                panel:ControlHelp("Default: 550")
            end
            panel:CheckBox("Disable HUD", "sasuke_disableHud")
            panel:ControlHelp("Default: false")
            panel:CheckBox("Enable Eye Change", "sasuke_eye_change")
            panel:ControlHelp("If you have the itachi playermodel, then having this enabled will change player's eyes to sharingan.\nDefault: true")
            panel:CheckBox("Enable Voice Lines", "sasuke_voice")
            panel:ControlHelp("Enables itachi's voice lines\nDefault: true")
            panel:CheckBox("Enable Theme", "sasuke_theme")
            panel:ControlHelp("Enables itachi's theme\nDefault: true")

            --Color Mixer
            panel:Help("Change the color of GUI")
            local clrMixer = vgui.Create("DColorMixer")
            clrMixer:SetPalette(true)  		--Show/hide the palette			DEF:true
            clrMixer:SetAlphaBar(false) 		--Show/hide the alpha bar		DEF:true
            clrMixer:SetWangs(true)	 		--Show/hide the R G B A indicators 	DEF:true
            clrMixer:SetColor(Color(GetConVarNumber("sasuke_r"), GetConVarNumber("sasuke_g"), GetConVarNumber("sasuke_b")) )	--Set the default color
            clrMixer.ValueChanged = function(self,col)
                RunConsoleCommand("sasuke_r", col.r)
                RunConsoleCommand("sasuke_g", col.g)
                RunConsoleCommand("sasuke_b", col.b)
            end
            panel:AddItem(clrMixer)
        end)
    end)
end