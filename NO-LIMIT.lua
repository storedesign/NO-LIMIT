-- Made by AdityaDwiNugroho
-- If you want to support me follow: https://github.com/AdityaDwiNugroho
-- Its recommended that u dont have esp enabled while autofarming, it will impact the speed of the autofarm
-- The obfuscated part of code at the bottom is for keeping track of how many times this script has been executed
-- it is obfuscated because i dont want people spamming my webhook
-- If u dont trust me, u can remove it.
if game.PlaceId == 7215881810 then
    local plr = game.Players.LocalPlayer.Character.HumanoidRootPart
    local auto = false
    local esp = false
    local espsize = 1
    local noclip = false
    local autopet = false
    local delay = 0.7
    local hitbox = false
    local size = 25
    local autofarming = Instance.new("BoolValue")
    autofarming.Value = false
	local world_number = game.Players.LocalPlayer.leaderstats.WORLD.value
	local esp_color = Color3.fromRGB(0,0,0)
	local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
	local Window = Library.CreateLib("Strongest Punch Simulator", "Synapse")
	local MainTab = Window:NewTab("Main")
	local VisualsTab = Window:NewTab("Visuals")
	local InfoTab = Window:NewTab("Keybinds")
	local CreditsTab = Window:NewTab("Credits")
	local CreditsSection = CreditsTab:NewSection("Credits")
	local KeybindSection = InfoTab:NewSection("Keybinds")
	local VisualSection = VisualsTab:NewSection("Visual")
	local FarmSection = MainTab:NewSection("Farm")
	local PlayerSection = MainTab:NewSection("Player")
	FarmSection:NewToggle("Auto Pet Upgrade", "Automatically upgrades your pet if you have enought orbs", function(state)
	   if state then
	       autopet = true
	       while autopet do
	           local args = {
	               [1] = {
	                   [1] = "UpgradeCurrentPet"
	               }
	           }
	           game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
	           wait()
	       end
	   else
	       autopet = false
	   end
	end)
	FarmSection:NewSlider("Farm Delay(ms)", "Delay between teleports in miliseconds", 1500, 400, function(s)
        delay = tonumber("0."..tostring(s))
    end)
	FarmSection:NewToggle("Undetectable AutoFarm", "Collects Orbs Without teleporting you", function(state)
		autofarming.Value = state
	end)
	FarmSection:NewToggle("AutoWorld by Cyberpunk2666r", "Automatically switch worlds", function(state)
        if state then
            autoworld = true
            while autoworld do
               local args = {
                   [1] = {
                       [1] = "WarpPlrToOtherMap",
                       [2] = "Next"
                   }
               }
               game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
               wait(2)
            end
        else
            autoworld = false
        end
    end)
	PlayerSection:NewLabel("Noclip can cause crashes if u autofarm and noclip")
	PlayerSection:NewToggle("Noclip", "Lets you walk through walls", function(state)
	    noclip = state
	end)
	PlayerSection:NewSlider("Walkspeed", "Changes your walking speed", 1000, 16, function(s)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
	end)
	VisualSection:NewColorPicker("ESP Color", "Pick the color of the esp", Color3.fromRGB(0,0,0), function(color)
		esp_color = color
	end)
    VisualSection:NewSlider("ESP Size", "changes the size of the esp", 4, 1, function(s)
        espsize = s
    end)
	VisualSection:NewToggle("Orb ESP", "You can see all orbs through any wall", function(state)
        if state then
            esp = true
            while esp do
                for i,Thing in pairs(game.Workspace.Map.Stages.Boosts[world_number]:GetChildren()) do
                    if Thing then
                        local a = Thing:FindFirstChild("BillboardGui")
                        if a then
                            a:Destroy()
                        end
                        local x = Instance.new('BillboardGui',Thing)
                        x.AlwaysOnTop = true
                        x.Size = UDim2.new(espsize,0,espsize,0)
                        local b = Instance.new('Frame',x)
                        b.Size = UDim2.new(espsize,0,espsize,0)
                        x.Adornee = Thing
                        b.BackgroundColor3 = esp_color
                    end
                end
                wait(0.2)
            end
        else
            esp = false
            for i,Thing in pairs(game.Workspace.Map.Stages.Boosts[world_number]:GetChildren()) do
                if Thing then
                    local a = Thing:FindFirstChild("BillboardGui")
                    if a then
                        a:Destroy()
                    end
                end
            end
        end
    end)
    KeybindSection:NewKeybind("open/close gui", "Closes or opens this gui", Enum.KeyCode.F, function()
	    Library:ToggleUI()
    end)
    CreditsSection:NewLabel("UI Library: AdityaDwiNugroho")
    CreditsSection:NewLabel("Scripts: AdityaDwiNugroho")
    local vu = game:GetService("VirtualUser")
	game:GetService("Players").LocalPlayer.Idled:connect(function()
		vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		wait(1)
		vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
	end)
	print("Succesfully Loaded GUI!")
	game:GetService('RunService').Stepped:connect(function()
        if noclip then
            game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
        end
	end)
    game.Players.LocalPlayer.leaderstats.WORLD.Changed:Connect(function()
        world_number = game.Players.LocalPlayer.leaderstats.WORLD.value
        if auto then
            auto = false
            wait(5)
            auto = true
        end
    end)
    autofarming.Changed:Connect(function(NewValue)
        if autofarming.Value then
            local timespent = 0
			while autofarming.Value do
				local orbs = game.Workspace.Map.Stages.Boosts[world_number]:GetChildren()
				if #orbs > 0 then
				for i,v in ipairs(orbs) do
					if autofarming.Value then
					    local touchinterest
					    local b
					    for a, b in pairs(v:GetChildren()) do
					        if not touchinterest then
					            touchinterest = b:FindFirstChild("TouchInterest")
					        end
						local args = { [1] = { [1] = "Activate_Punch" } }
						game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
					        if touchinterest then
					            firetouchinterest(plr, b, 0)
						        firetouchinterest(plr, b, 1)
					        end
					    end
					    wait(delay)
					end
				end
				else
					wait(30)
				end
			end
        end
    end)
end
