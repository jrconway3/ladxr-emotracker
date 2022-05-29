function bval(cond)
	if cond then
		return 1
	else
		return 0
	end
end

function has(item, amount)
	local count = Tracker:ProviderCountForCode(item)
	amount = tonumber(amount)
	if not amount then
		return count > 0
	else
		return count == amount
	end
end

function hasAny(items)
	for _, item in ipairs(items) do
		if(has(item)) then
			return true
		end
	end
	return false
end

function hasAll(items)
	for _, item in ipairs(items) do
		if(not has(item)) then
			return false
		end
	end
	return true
end

function can_break_grass()
	return bval(
		hasAny({"sword", "lift1", "rod", "boomerang"}) or
		(has("setting_NormalLogic") and hasAny({"powder", "bombs"}))
	)
end

function can_attack()
	return bval(
		hasAny({"sword", "hookshot", "rod", "boomerang", "bow"}) or
		(has("setting_GoodBoy_on") and has("chomp")) or
		(has("setting_NormalLogic") and has("bombs"))
	)
end

function can_break_swamp_flowers()
	return bval(
		hasAny({"rod", "hookshot", "chomp", "sword2", "boomerang"})
	)
end


function exactly_five_shells()
	return bval(has("shells", 5))
end

function exactly_ten_shells()
	return bval(has("shells", 10))
end

-- function can_leave_mabe()
--   if has("lift1")
--   and has("flippers")
--   or
--   has("lift1")
--   and has("boots")
--   and has("setting_connectormods_off")
--   or
--   has("lift1")
--   and has("hookshot")
--   or
--   has("lift1")
--   and has("setting_connectormods_on")
--   or
--   can_break_grass() > 0
--   and has("feather")
--   and has("hookshot")
--   and has("flippers")
--   or
--   has("boots")
--   and has("feather")
--   and has("flippers")
--   or
--   has("boots")
--   and has("feather")
--   and has("setting_connectormods_off")
--   or
--   has("boots")
--   and has("feather")
--   and has("hookshot")
--   then
--     return 1
--   else
--     return 0
--   end
-- end

-- LET THIS FOREVER BE A REMINDER TO ALWAYS THINK THROUGH YOUR LOGIC

-- function ladxr_can_leave_mabe()
--   if has("lift1")
--   and has("flippers")
--   or
--   has("lift1")
--   and has("boots")
--   or
--   has("lift1")
--   and has("boots")
--   and has("feather")
--   and has("flippers")
--   or
--   has("lift1")
--   and has("hookshot")
--   then
--     return 1
--   else
--     return 0
--   end
-- end

function cross_river()
	return bval(
		has("lift1") and hasAny({"boots", "hookshot", "flippers"})
	)
end

-- ONLY USE THE ABOVE FUNCTION FOR YARNA LOGIC AND D6 ENTRANCE

function glitched_river()
	return bval(
		has("setting_GlitchedLogic") and
		has("lift1") and hasAny({"boots", "hookshot", "feather"})
	)
end

function west_tal()
	return bval(
		hasAll({"lift1", "hookshot"}) and can_break_grass()>0 and
		(has("setting_overworldmods_on") or hasAll({"flippers", "boots"}))
	)
end

function ladxr_west_tal()
	return bval(
		has("lift1") and
		(has("sword1") or (has("setting_GoodBoy_on") and has("chomp"))) and
		(hasAny({"boots", "rooster"}) or has("setting_GlitchedLogic")) and
		(hasAll({"flippers", "hookshot"}) or has("rooster"))
	)
end

function east_tal()
	return bval(
		(can_break_grass()>0 or hasAll({"shield", "boots"})) and has("lift1") and hasAny({"flippers", "rooster"}) and (
			(has("setting_overworldmods_on") and hasAny({"hookshot", "angler"})) or
			(has("setting_GlitchedLogic") or hasAny("boots", "rooster"))
		)
	)
end

function kill_wizz()
	return bval(
		hasAny({"bow", "bombs", "rod"}) or hasAll({"hookshot", "lift1"})
	)
end

function kill_vire()
	return bval(
		hasAny({"powder", "rod", "sword2"}) or
		(has("setting_GoodBoy_on") and has("chomp"))
	)
end

function left_D8()
	return bval(
		(kill_vire() and (hasAny({"sword1", "rod", "bombs", "hookshot"}) or (has("setting_GoodBoy_on") and has("chomp")))) or
		(has("feather") and ((has("D8SK", 1) and has("bombs")) or has("rod")))
	)
end

function fire_source()
	return bval(hasAny({"powder", "rod"}))
end

function has_slime_key()
	return bval(has("slimekey"))
end

function not_slime_key()
	return bval(not has("slimekey"))
end


function view_connector_logic()
	return bval(has("setting_ER_advanced"))
end


function count_instruments()
	return
		bval(has("cello")) + bval(has("conch")) + bval(has("bell")) + bval(has("harp")) +
		bval(has("marimba")) + bval(has("triangle")) + bval(has("organ")) + bval(has("drum"))
end

function one_instrument()
	return bval(count_instruments() >= 1)
end

function open_egg()
	return bval(
		(has("setting_numInst8") and count_instruments() >= 8) or
		(has("setting_numInst7") and count_instruments() >= 7) or
		(has("setting_numInst6") and count_instruments() >= 6) or
		(has("setting_numInst5") and count_instruments() >= 5) or
		(has("setting_numInst4") and count_instruments() >= 4) or
		(has("setting_numInst3") and count_instruments() >= 3) or
		(has("setting_numInst2") and count_instruments() >= 2) or
		(has("setting_numInst1") and count_instruments() >= 1) or
		has("setting_numInst0")
	)
end

function any_boomerang()
	return bval(hasAny({"boomerang", "shovelboomerang", "featherboomerang", "bootsboomerang", "hookshotboomerang", "rodboomerang"}))
end

function final_boss_fight()
	return bval(
		has("powder") and (swordless_projectile_damage() or (
			has("setting_Swordless_off") and hasAll({"sword1", "powder"}) and (has("bow") or any_boomerang()>0)
		))
	)
end

function swordless_moldorm()
	return bval(has("setting_Swordless") and hasAny({"bombs", "bow", "hookshot", "rod"}))
end

function swordless_projectile_damage()
	return bval(has("setting_Swordless") and (hasAny({"bow", "hookshot", "rod"}) or any_boomerang()>0))
end

function swordless_damage()
	return bval(has("setting_Swordless") and hasAny({"bow", "hookshot", "rod", "bombs"}))
end

function master_stalfos_1()
	return bval(
		(has("setting_Swordless_off") and hasAll({"sword1", "bombs"})) or
		(has("setting_Swordless") and hasAny({"bombs", "rod"}))
	)
end

function wake_turtle_rock()
	return bval(
		(has("setting_Swordless_off") and hasAll({"ocarina", "soul", "sword1"})) or
		(has("setting_Swordless") and hasAll({"ocarina", "soul"}) and swordless_projectile_damage()>0)
	)
end

function gohma()
	return bval(hasAny({"hookshot", "bow", "boomerang", "sword2"}))
end

function not_shell_goal()
	return bval(
		has("setting_numInst8") or has("setting_numInst7") or has("setting_numInst6") or has("setting_numInst5") or
		has("setting_numInst4") or has("setting_numInst3") or has("setting_numInst2") or has("setting_numInst1") or
		has("setting_numInst0") or has("setting_numInstOpen")
	)
end
