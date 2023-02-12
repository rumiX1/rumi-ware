local Players = game:GetService("Players")
local lp = Players.LocalPlayer

local _C = {
    autoTap = false,
    autoRebirth = false,
    autoEgg = false,
    autoBestEquip = false,
    currentEgg = "Starter",
    rebirthSetting = 1,
}

getgenv().SecureMode = true
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

local W  = Rayfield:CreateWindow({
    Name = "Rumi-Ware",
    LoadingTitle = "Tapping Simulator",
    LoadingSubtitle = "by Rumi-Ware",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = nil,
        FileName = "RumiConfig",
    },
    Discord = {
        Enabled = true,
        Invite = "zvZZQpNN",
        RememberJoins = true,
    },
    KeySystem = true,
    KeySettings = {
        Title = "Rumi-Ware, Tapping Simulator",
        Subtitle = "Key System",
        Note = "Join the discord! (discord.gg/invite/zvZZQpNN)",
        FileName = "RWKey",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = "zvZZQpNN"
    }
})

local T = W:CreateTab("Tapping Simulator")

local S1 = T:CreateSection("Auto Clicking")

local ToggleAutoClick = T:CreateToggle({
    Name = "Auto Tap",
    CurrentValue = false,
    Flag = "ToggleAutoClick",
    Callback = function(Value)
        Rayfield:Notify({
            Title = "Execution Notification",
            Content = "Auto Click has been toggled on/off.",
            Duration = 2
        })
        _C.autoTap = Value;
        autoClick()
    end,
})

local S2 = T:CreateSection("Auto Equpping & Removing")

local ToggleAutoBestEquip = T:CreateToggle({
    Name = "Auto Best Equip",
    CurrentValue = false,
    Flag = "ToggleAutoBestEquip",
    Callback = function(Value)
        Rayfield:Notify({
            Title = "Execution Notification",
            Content = "Auto Best Equip has been toggled on/off.",
            Duration = 2
        })
        _C.autoBestEquip = Value;
        autoBestEquip()
    end,
})

local S3 = T:CreateSection("Auto Rebirths")

local ToggleAutoRebirth = T:CreateToggle({
    Name = "Auto Rebirth",
    CurrentValue = false,
    Flag = "ToggleAutoRebirth",
    Callback = function(Value)
        Rayfield:Notify({
            Title = "Execution Notification",
            Content = "Auto Rebirth has been toggled on/off.",
            Duration = 2
        })
        _C.autoRebirth = Value;
        autoRebirth()
    end,
})

local AutoRebirthSlider = T:CreateInput({
    Name = "Rebirth Amount",
    PlaceholderText = "Insert the Rebirths.",
    RemoveTextAfterFocusLost = false,
    Flag = "AutoRebirthSlider",
    Callback = function(Text)
        _C.rebirthSetting = Text;
    end,
})

local S3 = T:CreateSection("Auto Eggs")

local ToggleAutoEgg = T:CreateToggle({
    Name = "Auto Egg",
    CurrentValue = false,
    Flag = "ToggleAutoEgg",
    Callback = function(Value)
        Rayfield:Notify({
            Title = "Execution Notification",
            Content = "Auto Egg has been toggled on/off.",
            Duration = 2,
        })
        _C.autoEgg = Value;
        autoEgg()
    end,
})

local AutoOpenEggDropDown = T:CreateDropdown({
    Name = "Auto-Egg Configurations",
    Options = {"Starter", "Wood Egg", "Jungle Egg", "Forest Egg", "Bee Egg", "Swamp Egg", "Snow Egg"},
    CurrentOption = "Starter",
    Flag = "AutoOpenEggDropDown",
    Callback = function(Option)
        _C.currentEgg = tostring(Option);
        print(Option)
    end,
})

local S4 = T:CreateSection("Danger Zone")

local DestroyRumiWare = T:CreateButton({
    Name = "Destroy UI",
    Callback = function()
        Rayfield:Destroy()
    end,
})


Rayfield:LoadConfiguration() 

function autoClick()
    while _C.autoTap == true do
        local args = {
			[1] = "Main"
		}
		game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Tap"):FireServer(unpack(args))
		wait()
    end
end

function autoRebirth()
    while _C.autoRebirth == true do
        local args = {
            [1] = tonumber(_C.rebirthSetting)
        }

        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Rebirth"):FireServer(unpack(args))
        wait()
    end
end

function autoEgg()
    while _C.autoEgg == true do
        local args = {
            [1] = {},
            [2] = tostring(_C.currentEgg),
            [3] = 1
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("HatchEgg"):InvokeServer(unpack(args))
        wait()
    end
end

function autoBestEquip()
    while _C.autoBestEquip == true do
        for _, C in pairs(getconnections(game:GetService("Players").LocalPlayer:FindFirstChildOfClass("PlayerGui").UI.Inventory.Equip.Activated)) do
            C:Fire() 
        end
        wait(1)
    end
end
