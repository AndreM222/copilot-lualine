local colors = {};

colors.name_to_hex = function (name)
	local lookup = {
		["red"] = "#FF0000",        ["lightred"] = "#FFBBBB",      ["darkred"] = "#8B0000",
		["green"] = "#00FF00",      ["lightgreen"] = "#90EE90",    ["darkgreen"] = "#006400",    ["seagreen"] = "#2E8B57",
		["blue"] = "#0000FF",       ["lightblue"] = "#ADD8E6",     ["darkblue"] = "#00008B",     ["slateblue"] = "#6A5ACD",
		["cyan"] = "#00FFFF",       ["lightcyan"] = "#E0FFFF",     ["darkcyan"] = "#008B8B",
		["magenta"] = "#FF00FF",    ["lightmagenta"] = "#FFBBFF",  ["darkmagenta"] = "#8B008B",
		["yellow"] = "#FFFF00",     ["lightyellow"] = "#FFFFE0",   ["darkyellow"] = "#BBBB00",   ["brown"] = "#A52A2A",
		["grey"] = "#808080",       ["lightgrey"] = "#D3D3D3",     ["darkgrey"] = "#A9A9A9",
		["gray"] = "#808080",       ["lightgray"] = "#D3D3D3",     ["darkgray"] = "#A9A9A9",
		["black"] = "#000000",      ["white"] = "#FFFFFF",
		["orange"] = "#FFA500",     ["purple"] = "#800080",        ["violet"] = "#EE82EE"
	};

	local lookup_nvim = {
		["nvimdarkblue"] = "#004C73",    ["nvimlightblue"] = "#A6DBFF",
		["nvimdarkcyan"] = "#007373",    ["nvimlightcyan"] = "#8CF8F7",
		["nvimdarkgray1"] = "#07080D",   ["nvimlightgray1"] = "#EEF1F8",
		["nvimdarkgray2"] = "#14161B",   ["nvimlightgray2"] = "#E0E2EA",
		["nvimdarkgray3"] = "#2C2E33",   ["nvimlightgray3"] = "#C4C6CD",
		["nvimdarkgray4"] = "#4F5258",   ["nvimlightgray4"] = "#9B9EA4",
		["nvimdarkgrey1"] = "#07080D",   ["nvimlightgrey1"] = "#EEF1F8",
		["nvimdarkgrey2"] = "#14161B",   ["nvimlightgrey2"] = "#E0E2EA",
		["nvimdarkgrey3"] = "#2C2E33",   ["nvimlightgrey3"] = "#C4C6CD",
		["nvimdarkgrey4"] = "#4F5258",   ["nvimlightgrey4"] = "#9B9EA4",
		["nvimdarkgreen"] = "#005523",   ["nvimlightgreen"] = "#B3F6C0",
		["nvimdarkmagenta"] = "#470045", ["nvimlightmagenta"] = "#FFCAFF",
		["nvimdarkred"] = "#590008",     ["nvimlightred"] = "#FFC0B9",
		["nvimdarkyellow"] = "#6B5300",  ["nvimlightyellow"] = "#FCE094",
	};

	return lookup[string.lower(name)] or lookup_nvim[string.lower(name)];
end

colors.num_to_hex = function (num)
	if not num then
		return;
	end

	if num == 0 then
		return "#000000";
	elseif num ~= nil then
		return string.format("#%06X", num);
	end
end

colors.get_hl_value = function (ns_id, hl_group, value)
	if vim.fn.hlexists(hl_group) == 0 then
		return;
	end

	local hl = vim.api.nvim_get_hl(ns_id, { name = hl_group, link = false, create = false });

	if value == "fg" then
		if type(hl.fg) == "string" and hl.fg:match("^[#]?(%x+)$") then
			return colors.name_to_hex(hl.fg)
		else
			return colors.num_to_hex(hl.fg)
		end
	elseif value == "bg" then
		if type(hl.bg) == "string" and hl.bg:match("^[#]?(%x+)$") then
			return colors.name_to_hex(hl.bg)
		else
			return colors.num_to_hex(hl.bg)
		end
	elseif value == "sp" then
		if type(hl.sp) == "string" and hl.sp:match("^[#]?(%x+)$") then
			return colors.name_to_hex(hl.sp)
		else
			return colors.num_to_hex(hl.sp)
		end
	else
		return hl[value];
	end
end

return colors
