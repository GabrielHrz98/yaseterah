-- 🧩 Rayfield UI Setup
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Fungsi aman untuk mendapatkan Humanoid
local function getHumanoid()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    return character:WaitForChild("Humanoid")
end

-- 📦 Jendela Utama
local Window = Rayfield:CreateWindow({
   Name = "HRZTEAM•YATERSERAH",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "HRZTEAM",
      FileName = "VIP HRZTEAM"
   }
})

-- 🔒 HWID Whitelist
local hwid = game:GetService("RbxAnalyticsService"):GetClientId()
local hwidListURL = "https://raw.githubusercontent.com/GabrielHrz98/yaseterah/refs/heads/main/vip.txt"
local isVerified = false

local success, response = pcall(function()
    return game:HttpGet(hwidListURL)
end)

if success and response then
    for hwidLine in string.gmatch(response, "([^\r\n]+)") do
        if hwidLine == hwid then
            isVerified = true
            break
        end
    end
end

-- 🔔 Notifikasi Verifikasi
if isVerified then
    Rayfield:Notify({Title = "Akses Diberikan", Content = "HWID terverifikasi. Fitur aktif.", Duration = 4})
else
    Rayfield:Notify({Title = "Akses Ditolak", Content = "Perangkat kamu tidak terdaftar di whitelist.", Duration = 6})
end

-- 📋 Tab HWID Info
local HWIDTab = Window:CreateTab("📋 HWID Info")
HWIDTab:CreateButton({
    Name = "Salin HWID ke Clipboard",
    Callback = function()
        setclipboard(hwid)
        Rayfield:Notify({Title = "HWID Disalin", Content = "Kirim ke admin HRZTEAM untuk whitelist.", Duration = 4})
    end
})

-- 🏃 Tab Movement
local TabMovement = Window:CreateTab("Movement", 4483362458)

-- 🎚️ Speed Hack
TabMovement:CreateSlider({
   Name = "Speed Hack",
   Range = {16, 200},
   Increment = 1,
   Default = 16,
   Callback = function(Value)
      getHumanoid().WalkSpeed = Value
   end
})

-- 🎚️ Jump Hack
TabMovement:CreateSlider({
   Name = "Jump Hack",
   Range = {50, 500},
   Increment = 10,
   Default = 50,
   Callback = function(Value)
      getHumanoid().JumpPower = Value
   end
})

-- 🚀 Infinite Jump
local InfiniteJumpEnabled = false
TabMovement:CreateToggle({
   Name = "Infinite Jump",
   CurrentValue = false,
   Callback = function(Value)
      InfiniteJumpEnabled = Value
   end
})

UserInputService.JumpRequest:Connect(function()
   if InfiniteJumpEnabled then
      local humanoid = getHumanoid()
      if humanoid then
         humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
      end
   end
end)

-- 📍 Tab Teleport
local TabTeleport = Window:CreateTab("Teleport", 4483362458)

local teleportLocations = {
   {name="Lokasi 1", pos=Vector3.new(8, 10, 7)},
   {name="Lokasi 2", pos=Vector3.new(-267, 79, -68)},
   {name="Lokasi 3", pos=Vector3.new(-477, 13, 44)},
   {name="Lokasi 4", pos=Vector3.new(-238, 46, 222)},
   {name="Lokasi 5", pos=Vector3.new(79, 124, 145)},
   {name="Lokasi 6", pos=Vector3.new(-239, 305, -279)},
   {name="Lokasi 7", pos=Vector3.new(-607, 402, -204)},
   {name="Lokasi 8", pos=Vector3.new(-408, 430, -86)},
   {name="Lokasi 9", pos=Vector3.new(7, 584, 713)},
   {name="Lokasi 10", pos=Vector3.new(254, 599, 742)},
   {name="Lokasi 11", pos=Vector3.new(561, 791, 604)},
   {name="Lokasi 12", pos=Vector3.new(735, 777, 184)},
   {name="Lokasi 13", pos=Vector3.new(705, 949, -286)},
   {name="Lokasi 14", pos=Vector3.new(376, 938, -415)},
   {name="Lokasi 15", pos=Vector3.new(-137, 1077, -782)}
}

-- 🔘 Buat tombol untuk setiap lokasi
for _, loc in ipairs(teleportLocations) do
   TabTeleport:CreateButton({
      Name = loc.name,
      Callback = function()
         local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
         local rootPart = character:WaitForChild("HumanoidRootPart", 5)
         if rootPart then
            rootPart.CFrame = CFrame.new(loc.pos)
         end
      end
   })
end