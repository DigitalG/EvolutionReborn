function OnIntervalThink(keys)
	local caster = keys.caster
	local ability = keys.ability

	local enemy_modifier = "ghost_shroud_enemy"
	local damage = ability:GetSpecialValueFor("damage")
	local duration = ability:GetSpecialValueFor("duration")
	local target_teams = ability:GetAbilityTargetTeam()
	local target_types = ability:GetAbilityTargetType()
	local target_flags = ability:GetAbilityTargetFlags()
	local target_location = caster:GetAbsOrigin()
	local area_of_effect = 24

	local found_units = {}
	found_units = FindUnitsInRadius(caster:GetTeamNumber(), target_location, nil, area_of_effect, target_teams, target_types, target_flags, FIND_CLOSEST, false)

	local damage_table = {}
	damage_table.attacker = caster
	damage_table.ability = ability
	damage_table.damage_type = ability:GetAbilityDamageType() 
	damage_table.damage = damage

	if found_units ~= nil then
		for _,hero in pairs(found_targets) do
			if hero:HasModifier(enemy_modifier) ~= true then
				ApplyDataDrivenModifier(caster, hero, enemy_modifier, {duration = duration})
				damage_table.victim = hero
				ApplyDamage(damage_table)
			end
		end
	end
end