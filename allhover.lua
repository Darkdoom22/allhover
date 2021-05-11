_addon.name = "allhover"
_addon.author = "uwu/darkdoom"
_addon.version = "1.0"

require('tables')
require('coroutine')
local packets = require('packets')


local finishCategories = T{
	1, 3, 4, 6, 14, 15,
}

local function injectAnim()

	local player = windower.ffxi.get_player()
	local hoverAnim = packets.new('incoming', 0x038)

	hoverAnim["Mob"] = player.id
	hoverAnim["Mob Index"] = player.index
	hoverAnim["_dupeMob"] = player.id
	hoverAnim["_dupeMob Index"] = player.index
	hoverAnim["Type"] = "hov1"

	packets.inject(hoverAnim)

end

windower.register_event('incoming chunk', function(id, original, _, _)

	if(id == 0x028)then

		local actionPacket = packets.parse('incoming', original)

		if(finishCategories:contains(actionPacket["Category"]))then

			coroutine.schedule(injectAnim, 1)

		end

	end

end)

