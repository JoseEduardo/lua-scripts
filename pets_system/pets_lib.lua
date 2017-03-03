---- based on Jordanhenry pet system version 1.77 (changelog)
---- edited by hellboy

-- config
PETS = {
	PREFIX = "PET_",
	CHANNELID = 10,
--	SOULPERLVL = 10,

	CONFIG = {
		introduction = "You may catch pets using command '!petcatch'. If your pet dies, you have to revive it in order to summon it again. Some pets have a special requirement in order to catch them, some cannot be catched at all and can only be gotten by evolution. Type 'commands' for a list of available commands.",
		sameSpeed = true,

		healOnLevelUp = true,
		standardHpAdd = 5,
		expMultipler = 1,
		maxLevel = 10,

--		healSoulCost = 0.1,
--		healSoulBase = 25,

		reviveSoulBaseCost = 50,
		reviveSoulLevelCost = 0.2
	},
	IDENTIFICATION = {
		[1] = {
			name = "Cat",
			health = 100,
			evolve = {
				to = 3,
				at = 10
			},
			check = true
		},
		[2] = {
			name = "Dog",
			health = 100,
			evolve = {
				to = 4,
				at = 10
			},
			check = true
		},
		[3] = {
			name = "Tiger",
			health = 300,
			check = false,
			info = "Evolves from Cat."
		},
		[4] = {
			name = "Lion",
			health = 300,
			mountId = 40,
			check = false,
			info = "Evolves from Dog."
		},
		[5] = {
			name = "Husky",
			health = 150,
			check = function(player) return player:getPremiumDays() > 0 end,
			info = "Requires a premium account."
		},
		[6] = {
			name = "Wolf",
			health = 200,
			evolve = {
				to = 7,
				at = 4
			},
			check = function(player) return player:getLevel() >= 10 end,
			info = "Requires level 10."
		},
		[7] = {
			name = "War Wolf",
			health = 500,
			evolve = {
				to = 8,
				at = 55
			},
			check = false,
			info = "Evolves from Wolf."
		},
		[8] = {
			name = "Werewolf",
			health = 1000,
			check = false,
			info = "Evolves from War Wolf."
		},
		[9] = {
			name = "Bear",
			health = 300,
			mountId = 3,
			check = function(player) return player:isDruid() and player:getLevel() >= 10 end,
			info = "Only available to druids above level 10."
		},
		[10] = {
			name = "Panda",
			health = 300,
			mountId = 19,
			check = function(player) return player:isDruid() and player:getLevel() >= 10 end,
			info = "Only available to druids above level 10."
		},
		[11] = {
			name = "Chicken",
			health = 50,
			check = true
		},
		[12] = {
			name = "Sheep",
			health = 50,
			check = true
		},
		[13] = {
			name = "Seagull",
			health = 100,
			check = function(player) return player:getPremiumDays() > 0 end,
			info = "Requires a premium account."
		},
		[14] = {
			name = "Parrot",
			health = 100,
			check = function(player) return player:getPremiumDays() > 0 end,
			info = "Requires a premium account."
		},
		[15] = {
			name = "Penguin",
			health = 100,
			check = function(player) return player:getPremiumDays() > 0 end,
			info = "Requires a premium account."
		},
		[16] = {
			name = "Elephant",
			health = 300,
			check = function(player) return player:getPremiumDays() > 0 and player:getLevel() >= 10 end,
			contain = 5,
			info = "Only available to Premium accounts above level 10."
		},
		[17] = {
			name = "Dragon Hatchling",
			health = 300,
			evolve = {
				to = 18,
				at = 20
			},
			check = function(player) return player:getPremiumDays() > 0 and player:getLevel() >= 25 and player:isSorcerer() end,
			info = "Only available to Premium Sorcerers above level 25."
		},
		[18] = {
			name = "Dragon",
			health = 1000,
			check = false,
			info = "Evolves from Dragon Hatchling."
		}
	},

	STORAGE = {
		TYPE = 10000,
		UID = 10001,
		LOSTHEALTH = 10002,
		MAXHEALTH = 10003,
		EXPERIENCE = 10004,
		LEVEL = 10005
	},

	SYSTEM = {
		EVOLUTION = true
	}
}

--/ config
function Player.petSystemMessage(self, txt, talkType)
	local playerId = self:getId()
	talkType = (talkType == nil) and TALKTYPE_CHANNEL_O or talkType

	local function eventMessage(playerId, text, talkType)
		local player = Player(playerId)
		if not player then
			return false
		end
		player:sendChannelMessage('[PET-SYSTEM]', txt, talkType)
	end
	addEvent(eventMessage, 150, playerId, text, talkType)

	--self:sendChannelMessage('[PET-SYSTEM]', txt, ((talkType == nil) and TALKTYPE_CHANNEL_O or talkType), PETS.CHANNELID)
	--self:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, '[PET-SYSTEM] '..txt)
	return true
end

-- get
function Player.getPetExperience(self)
	return self:getStorageValue(PETS.STORAGE.EXPERIENCE)
end

function Player.getPetLevel(self)
	return self:getStorageValue(PETS.STORAGE.LEVEL)
end

function Player.getPetType(self)
	return self:getStorageValue(PETS.STORAGE.TYPE)
end

function Player.getPetUid(self)
	return self:getStorageValue(PETS.STORAGE.UID)
end

function Player.getPetMaxHealth(self)
	return self:getStorageValue(PETS.STORAGE.MAXHEALTH)
end

function Player.getPetLostHealth(self)
	return self:getStorageValue(PETS.STORAGE.LOSTHEALTH)
end

-- set
function Player.setPetExperience(self, experience)
	return self:setStorageValue(PETS.STORAGE.EXPERIENCE, experience)
end

function Player.setPetLevel(self, petLevel)
	return self:setStorageValue(PETS.STORAGE.LEVEL, petLevel)
end

function Player.setPetType(self, petType)
	return self:setStorageValue(PETS.STORAGE.TYPE, petType)
end

function Player.setPetUid(self, petUid)
	return self:setStorageValue(PETS.STORAGE.UID, petUid)
end

function Player.setPetMaxHealth(self, health)
	return self:setStorageValue(PETS.STORAGE.MAXHEALTH, health)
end

function Player.setPetLostHealth(self, health)
	return self:setStorageValue(PETS.STORAGE.LOSTHEALTH, health)
end

function Player.doAddPet(self, petType)
	local pet = Creature(self:getStorageValue(PETS.STORAGE.UID))
	if pet then
		return false
	end

	self:setPetUid(0)
	self:setPetExperience(0)
	self:setPetLevel(1)
	self:setPetType(petType)

	self:setPetMaxHealth(PETS.IDENTIFICATION[petType].health)
	self:setPetLostHealth(0)
	return true
end

function Player.doResetPet(self)
	for _, i in pairs(PETS.STORAGE) do
		self:setStorageValue(i, -1)
	end
	return true
end

function Player.doRemovePet(self)
	local petUid = self:getPetUid()
	local pet = Creature(petUid)

	if not pet or not pet:isCreature() then
		return true
	end
	local maxHealth = pet:getMaxHealth()

	self:setPetMaxHealth(maxHealth)
	self:setPetLostHealth(maxHealth - pet:getHealth() )
	self:setPetUid(0)

	pet:remove()
	return true
end

function Player.summonPet(self, position)
	local petUid = self:getPetUid()
	local pet = Creature(petUid)
	if pet and pet:isCreature() then
		return false
	end

	local pet = Game.createMonster(PETS.PREFIX .. (PETS.IDENTIFICATION[self:getPetType()].name), position)
	if pet then
		position:sendMagicEffect(CONST_ME_TELEPORT)
		pet:setMaster(self)
		local maxHealth = self:getPetMaxHealth()
		pet:setMaxHealth(maxHealth)
		pet:addHealth(maxHealth - pet:getHealth() - self:getPetLostHealth() )
		self:setPetUid( pet:getId() )
		pet:setSkull(SKULL_GREEN)
		pet:changeSpeed(PETS.CONFIG.sameSpeed and (self:getBaseSpeed() - pet:getBaseSpeed()) or 0)

		for _, eventName in pairs({"PetDeath", "PetKill"}) do
			pet:registerEvent(eventName)
		end
		return pet
	end
	return false
end

function getExpNeeded(level)
	return ( (50 *level^3) -(150 *level^2) +(400 *level) )/3 *PETS.CONFIG.expMultipler
end

function Player.addPetExp(self, amount)
	if self:getPetLevel() >= PETS.CONFIG.maxLevel then
		return false
	end

	local totalExp = self:getPetExperience() + amount
	self:setPetExperience(totalExp)
	local petLevel, petType, petUid = self:getPetLevel(), self:getPetType(), self:getPetUid()

	if totalExp >= getExpNeeded(petLevel + 1) then
		local pet = Creature(petUid)
		pet:setMaxHealth(pet:getMaxHealth() + (PETS.IDENTIFICATION[petType].hpAdd or PETS.CONFIG.standardHpAdd))
		self:setPetLevel(petLevel +1)
		self:petSystemMessage("Your "..PETS.IDENTIFICATION[petType].name.." has leveled up to level "..(petLevel +1)..".")

		if PETS.CONFIG.healOnLevelUp then
			pet:addHealth( pet:getMaxHealth() )
		end

		if PETS.SYSTEM.EVOLUTION and (PETS.IDENTIFICATION[petType]).evolve and ((PETS.IDENTIFICATION[petType]).evolve.at <= (petLevel +1)) then
			local position = pet:getPosition()
			self:doRemovePet()
			self:setPetType( (PETS.IDENTIFICATION[petType]).evolve.to)
			self:setPetMaxHealth( (PETS.IDENTIFICATION[(PETS.IDENTIFICATION[petType]).evolve.to]).health )
			self:setPetLostHealth(0)
			self:petSystemMessage("Yours "..(PETS.IDENTIFICATION[petType]).name.." evolvet to "..((PETS.IDENTIFICATION[(PETS.IDENTIFICATION[petType]).evolve.to]).name)..".")
			self:summonPet(position)
		end
	end

	return true
end

function Player.canGetPet(self, petId)
	if self:getGroup():getId() >= 3 then
		return true
	end

	if type(PETS.IDENTIFICATION[petId].check) == "function" then
		return PETS.IDENTIFICATION[petId].check(self)
	end
	return PETS.IDENTIFICATION[petId].check
end
