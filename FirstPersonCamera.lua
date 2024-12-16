local ViewAccessories = false
local ViewModels = true

Plr = game.Players.LocalPlayer
Char = Plr.Character or Plr.CharacterAdded:wait()
Human = Char:WaitForChild("Humanoid")
Cam = game.Workspace.CurrentCamera

Plr.CameraMaxZoomDistance = 0 
Plr.CameraMinZoomDistance = 0
Cam.FieldOfView = 75
Human.CameraOffset = Vector3.new(0,-0.42, -1.42)

local function Lock (part)
	if part and part:IsA("BasePart") and part.Name ~= "Head" then
		part.LocalTransparencyModifier = part.Transparency
		part.Changed:connect(function (property)
			part.LocalTransparencyModifier = part.Transparency
		end)
	end
end

for i, v in pairs (Char:GetChildren()) do
	if v:IsA("BasePart") then
		Lock(v)
	elseif v:IsA("Accessory") and ViewAccessories then
		if v:FindFirstChild("Handle") then
			Lock(v.Handle)
		end
	elseif v:IsA("Model") and ViewModels then
		for index, descendant in pairs (v:GetDescendants()) do
			if descendant:IsA("BasePart") then
				Lock(descendant)
			end
		end
	end
end

Char.ChildAdded:connect(Lock)

Cam.Changed:connect(function (property)
	if property == "CameraSubject" then
		if Cam.CameraSubject and Cam.CameraSubject:IsA("VehicleSeat") and Human then
			Cam.CameraSubject = Human;
		end
	end
end)