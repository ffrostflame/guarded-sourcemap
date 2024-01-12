local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local sourcemap = require(script.Parent.Parent.sourcemap)

local function deepCopy(original)
	local copy = {}
	for k, v in pairs(original) do
		if type(v) == "table" then
			v = deepCopy(v)
		end
		copy[k] = v
	end
	return copy
end

local replicatedSourcemap = deepCopy(sourcemap)

for index, value in replicatedSourcemap.children do
	if value.className == "ServerScriptService" or value.className == "ServerStorage" then
		table.remove(replicatedSourcemap.children, index)
	end
end

require(script.Parent)._setSourcemap(sourcemap)

local packagesFolder = ReplicatedStorage:FindFirstChild("Packages")
local indexFolder = packagesFolder:FindFirstChild("_Index")

for _, package in indexFolder:GetChildren() do
	if string.sub(package.Name, 1, 21) == "ffrostflame_sourcemap" then
		package:Destroy()
	end
end

local replicatedSourcemapValue = Instance.new("StringValue")
replicatedSourcemapValue.Value = HttpService:JSONEncode(replicatedSourcemap)
replicatedSourcemapValue.Parent = ReplicatedStorage
