--!strict

local TableUtil = {}

function TableUtil.shallowCopy<T>(source: { [any]: T }): { [any]: T }
	local copy = {}
	for key, value in pairs(source) do
		copy[key] = value
	end
	return copy
end

function TableUtil.freeze<T>(source: T): T
	return table.freeze(source)
end

return TableUtil
