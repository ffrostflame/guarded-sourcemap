local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local currentSourcemap = nil

if RunService:IsClient() then
	currentSourcemap = HttpService:JSONDecode(ReplicatedStorage:WaitForChild("sourcemap").Value)
end

return {
	_setSourcemap = function(newSourcemap)
		currentSourcemap = newSourcemap
	end,
	getSourcemap = function()
		return currentSourcemap
	end,
}
