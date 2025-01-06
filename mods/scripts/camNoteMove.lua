-- Original script by TPOSEJANK, changed a ton by 💜 Rodney, An Imaginative Person 💙! lol
local moviesOffset = {40, 30} -- x and y movement force
local ifCamLocked = {oppo = {false, 0, 0}, play = {false, 0, 0}} -- cool cam lock stuff
local velocity = {false, 1, 2.5, hasStarted = false, updateDefCamSpeed = false} -- sonic.exe lol
local whosActive = {oppo = true, play = true} -- who has de cool movesment

-- DON'T TOUCH ANYTHING BELOW THIS POINT
local xy = {{-moviesOffset[1], 0}, {0, moviesOffset[2]}, {0, -moviesOffset[2]}, {moviesOffset[1], 0}} -- table which has the applied movement force

---@param variable any
---@param ifNull any
---@return any
local function checkIfNull(variable, ifNull)
	if variable == nil then
		return (ifNull ~= nil and ifNull or nil)
	else
		return variable
	end
end

function onSongStart()
	velocity[2] = checkIfNull(getProperty('cameraSpeed'), 1)
	velocity[3] = velocity[2] + velocity[3]
	velocity.hasStarted = true
end

function onUpdate()
	if velocity.updateDefCamSpeed then velocity[2] = checkIfNull(getProperty('cameraSpeed'), 1) end
	-- debugPrint(velocity[2], ' ', velocity.updateDefCamSpeed, ' ', getProperty('cameraSpeed'))
end

function Split(s, delimiter)
	-- Breaks when using callScript sadly.
	local result = {}
	for match in (s..delimiter):gmatch('(.-)'..delimiter) do
		table.insert(result, stringTrim(tostring(match)))
	end
	return result
end

local focusThingy
function onMoveCamera(focus)
	focusThingy = focus
	if getProperty('isCameraOnForcedPos') == false then
		if ifCamLocked.oppo[1] and mustHitSection == false then
			setProperty('camFollow.x', ifCamLocked.oppo[2])
			setProperty('camFollow.y', ifCamLocked.oppo[3])
		elseif ifCamLocked.play[1] and mustHitSection then
			setProperty('camFollow.x', ifCamLocked.play[2])
			setProperty('camFollow.y', ifCamLocked.play[3])
		end
	end
	if velocity[1] and velocity.hasStarted then setProperty('cameraSpeed', velocity[2]) end
	velocity.updateDefCamSpeed = true
end

function goodNoteHit(membersIndex, noteData, noteType, isSustainNote)
	if whosActive.play and mustHitSection then
		moveCamNoteDir(true, noteData, noteType)
	end
end
function opponentNoteHit(membersIndex, noteData, noteType, isSustainNote)
	if whosActive.oppo and mustHitSection == false then
		moveCamNoteDir(false, noteData, noteType)
	end
end
function noteMiss(membersIndex, noteData, noteType, isSustainNote)
	if velocity[1] and mustHitSection then setProperty('cameraSpeed', velocity[2]) end
	velocity.updateDefCamSpeed = true
end
function noteMissPress(direction)
	if velocity[1] and mustHitSection then setProperty('cameraSpeed', velocity[2]) end
	velocity.updateDefCamSpeed = true
end

local camManagement = {focusThingy, '', 'Scripted Char Sing'}
function onEvent(name, value1, value2)
	if name == 'Camera Set Target' then
		local valueContents = {v1 = {}, v2 = {}}
		valueContents.v1 = Split(value1, ',')
		valueContents.v2 = Split(value2, ',')
		setToCharCamPosition(valueContents.v1[1], {valueContents.v2[1], valueContents.v2[2]})
	end

	if name == 'Set Property' and value1 == 'cameraSpeed' then
		velocity[2] = checkIfNull(value2, getProperty('cameraSpeed'))
	end

	if name == 'Manage Cam Dir Movement' then
		camManagement = Split(value2, ',')
		camManagement[3] = tostring(value1)
	end
	
	if name == 'Manage Cam Dir Properties' then
		local valueContents = {v1 = {}, v2 = {}}
		valueContents.v1 = Split(value1, ',')
		valueContents.v2 = Split(value2, ',')
		
		moviesOffset[1] = checkIfNull(tonumber(valueContents.v1[1]), moviesOffset[1])
		moviesOffset[2] = checkIfNull(tonumber(valueContents.v1[2]), moviesOffset[2])
		if valueContents.v1[3] == 'player' then
			whosActive.oppo = false
			whosActive.play = true
		elseif valueContents.v1[3] == 'opponent' then
			whosActive.oppo = true
			whosActive.play = false
		elseif valueContents.v1[3] == 'both' then
			whosActive.oppo = true
			whosActive.play = true
		elseif valueContents.v1[3] == 'none' then
			whosActive.oppo = false
			whosActive.play = false
		else
			if valueContents.v1[3] ~= nil then
				debugPrint('Please put "player", "opponent", "both" or "none".')
				debugPrint('Action "' .. valueContents.v1[3] .. '" is not a selectable thing.')
			end
		end
		
		-- velocity[1] = (valueContents.v2[1] ~= nil and (valueContents.v2[1] == 'true' and true or false) or velocity[1])
		velocity[1] = checkIfNull(valueContents.v2[1] == 'true' and true or false, velocity[1])
		velocity[3] = checkIfNull(tonumber(valueContents.v2[2]), velocity[3])
	end
	
	if name == 'Manage Cam Dir Position Lock' then
		local valueContents = {v1 = {}, v2 = {}}
		valueContents.v1 = Split(value1, ',')
		valueContents.v2 = Split(value2, ',')

		if stringTrim(value1) ~= '' then
			ifCamLocked.oppo[1] = true
			ifCamLocked.oppo[2] = checkIfNull(tonumber(valueContents.v1[1]), ifCamLocked.oppo[2])
			ifCamLocked.oppo[3] = checkIfNull(tonumber(valueContents.v1[2]), ifCamLocked.oppo[3])
		elseif value1 == 'previous' then
			ifCamLocked.oppo[1] = true
		else
			ifCamLocked.oppo[1] = false
		end
		
		if stringTrim(value2) ~= '' then
			ifCamLocked.play[1] = true
			ifCamLocked.play[2] = checkIfNull(tonumber(valueContents.v2[1]), ifCamLocked.play[2])
			ifCamLocked.play[3] = checkIfNull(tonumber(valueContents.v2[2]), ifCamLocked.play[3])
		elseif value2 == 'previous' then
			ifCamLocked.play[1] = true
		else
			ifCamLocked.play[1] = false
		end

		if getProperty('isCameraOnForcedPos') == false then
			if (ifCamLocked.oppo[1] and mustHitSection == false) and stringTrim(value1) ~= '' then
				setProperty('camFollow.x', ifCamLocked.oppo[2])
				setProperty('camFollow.y', ifCamLocked.oppo[3])
			elseif (ifCamLocked.play[1] and mustHitSection) and stringTrim(value2) ~= '' then
				setProperty('camFollow.x', ifCamLocked.play[2])
				setProperty('camFollow.y', ifCamLocked.play[3])
			end
		end
	end
end

---@param noteType string
local function moveCameraSection(noteType)
	runHaxeCode('game.moveCameraSection();')
	if noteType == camManagement[3] then
		setToCharCamPosition(camManagement[1], {camManagement[2]})
	end
end

---@param noteData number
---@param maniaVar number
---@return noteData
local function noteDataEKConverter(noteData, maniaVar)
	if maniaVar == 1 then
		if noteData == 0 then return 2 end

	elseif maniaVar == 2 then
		if noteData == 0 then return 1 end
		if noteData == 1 then return 2 end

	elseif maniaVar == 3 then
		if noteData == 0 then return 0 end
		if noteData == 1 then return 2 end
		if noteData == 2 then return 3 end

	elseif maniaVar == 4 then
		-- if noteData == 0 then return 0 end
		-- if noteData == 1 then return 1 end
		-- if noteData == 2 then return 2 end
		-- if noteData == 3 then return 3 end
		return noteData

	elseif maniaVar == 5 then
		if noteData == 0 then return 0 end
		if noteData == 1 then return 1 end
		if noteData == 2 then return 2 end
		if noteData == 3 then return 2 end
		if noteData == 4 then return 3 end

	elseif maniaVar == 6 then
		if noteData == 0 then return 0 end
		if noteData == 1 then return 2 end
		if noteData == 2 then return 3 end
		if noteData == 3 then return 0 end
		if noteData == 4 then return 1 end
		if noteData == 5 then return 3 end

	elseif maniaVar == 7 then
		if noteData == 0 then return 0 end
		if noteData == 1 then return 2 end
		if noteData == 2 then return 3 end
		if noteData == 3 then return 2 end
		if noteData == 4 then return 0 end
		if noteData == 5 then return 1 end
		if noteData == 6 then return 3 end

	elseif maniaVar == 8 then
		if noteData == 0 then return 0 end
		if noteData == 1 then return 1 end
		if noteData == 2 then return 2 end
		if noteData == 3 then return 3 end
		if noteData == 4 then return 0 end
		if noteData == 5 then return 1 end
		if noteData == 6 then return 2 end
		if noteData == 7 then return 3 end

	elseif maniaVar == 9 then
		if noteData == 0 then return 0 end
		if noteData == 1 then return 1 end
		if noteData == 2 then return 2 end
		if noteData == 3 then return 3 end
		if noteData == 4 then return 2 end
		if noteData == 5 then return 0 end
		if noteData == 6 then return 1 end
		if noteData == 7 then return 2 end
		if noteData == 8 then return 3 end
		
	else
		return noteData
	end
end

---@param mustPress boolean
---@param noteData number
---@param noteType string
function moveCamNoteDir(mustPress, noteData, noteType) -- noteType is here to do cool stuff with setToCharCamPosition()!
	noteData = noteDataEKConverter(noteData, checkIfNull(keyCount, 4))
	if getProperty('isCameraOnForcedPos') == false then
		moveCameraSection(noteType)
		if ifCamLocked.oppo[1] and mustPress == false then
			setProperty('camFollow.x', ifCamLocked.oppo[2])
			setProperty('camFollow.y', ifCamLocked.oppo[3])
		elseif ifCamLocked.play[1] and mustPress then
			setProperty('camFollow.x', ifCamLocked.play[2])
			setProperty('camFollow.y', ifCamLocked.play[3])
		end
		
		-- Add your own thing if you want if you have custom options for instance.
		-- if condition then
			velocity.updateDefCamSpeed = false
			if velocity[1] and velocity.hasStarted then setProperty('cameraSpeed', velocity[2] + velocity[3]) end
			setProperty('camFollow.x', getProperty('camFollow.x') + xy[noteData+1][1])
			setProperty('camFollow.y', getProperty('camFollow.y') + xy[noteData+1][2])
		-- end
	end
end

---@param character string
---@param offset table.string
function setToCharCamPosition(character, offset)
	---@param one number
	---@param operator string
	---@param two number
	---@return number
	local function doMathStupid(one, operator, two)
		-- Fuck math, why does bf do - while dad and gf do + on x like WTF?!?!!
		one, two = one == nil and 0 or tonumber(one), two == nil and 0 or tonumber(two)
		if operator == '+' then -- Addition
			return one + two
		elseif operator == '-' then -- Subtraction
			return one - two
		elseif operator == '*' then -- Multiplication
			return one * two
		elseif operator == '/' then -- Division
			return one / two
		end
	end
	
	-- makes sure these are strings
	character = tostring(character)
	offset[1] = tostring(checkIfNull(offset[1]) ~= nil and (focusThingy == 'boyfriend' and 'bf' or focusThingy))
	offset[2] = tostring(offset[2] == 'original' and (offset[1] == 'dad' and 'opponent' or offset[1] == 'gf' and 'girlfriend' or offset[1] == 'bf' and 'boyfriend'))
	
	-- set camera to then characters camera position
	setProperty('camFollow.x', getMidpointX(character) + (offset[1] == 'dad' and 150 or offset[1] == 'gf' and 0 or offset[1] == 'bf' and -100))
	setProperty('camFollow.y', getMidpointY(character) + (offset[1] == 'dad' and -100 or offset[1] == 'gf' and 0 or offset[1] == 'bf' and -100))
	setProperty('camFollow.x', doMathStupid(getProperty('camFollow.x'), offset[1] == 'bf' and '-' or '+', getProperty(character .. '.cameraPosition[0]')))
	setProperty('camFollow.y', getProperty('camFollow.y') + getProperty(character .. '.cameraPosition[1]'))
		
	if (character == 'dad' or character == 'gf' or character == 'boyfriend') and offset[2] == 'original' then
		setProperty('camFollow.x', doMathStupid(getProperty('camFollow.x'), character == 'boyfriend' and '-' or '+', getProperty(offset[2] .. 'CameraOffset[0]')))
		setProperty('camFollow.y', getProperty('camFollow.y') + getProperty(offset[2] .. 'CameraOffset[1]'))
	end
	callOnLuas('onMoveCamera', {focusThingy, character, offset[2]}, true, true, {scriptName})
	
	-- from source on setting character camera position for reference
	--[[camFollow.set(dad.getMidpoint().x + 150, dad.getMidpoint().y - 100);
	camFollow.x += dad.cameraPosition[0] + opponentCameraOffset[0];
	camFollow.y += dad.cameraPosition[1] + opponentCameraOffset[1];
	
	camFollow.set(gf.getMidpoint().x, gf.getMidpoint().y);
	camFollow.x += gf.cameraPosition[0] + girlfriendCameraOffset[0];
	camFollow.y += gf.cameraPosition[1] + girlfriendCameraOffset[1];

	camFollow.set(boyfriend.getMidpoint().x - 100, boyfriend.getMidpoint().y - 100);
	camFollow.x -= boyfriend.cameraPosition[0] - boyfriendCameraOffset[0];
	camFollow.y += boyfriend.cameraPosition[1] + boyfriendCameraOffset[1];]]
end