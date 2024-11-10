--[[
     _
    / \  ___________
   / Λ \ \  _____  /
  / / \ \ \ \   / /
 / /___\ \ \ \ / /
/_________\ \ V /
             \_/

TDL LiftControl V1.1
Made by Diamond
]]--

RunSpeed = 2
InspectionSpeed = 0.5
AccelTime = 1
MinApproachSpeed = 0.3 --Speed at which the car should stop in the landing

LevelTolerance = 0.02 --Accepted deviation from floor level when stopping
OpenTolerance = 0.3 --Accepted deviation from floor level when opening doors

PreOpen = true --Open doors before fully stopping
PreOpenDistance = 0.1 --0.05 equals 0.5vox

DoorSpeed = 0.5
DoorStrength = 300
DoorOpenTime = 10 --seconds
DoorReopenTime = 3 --seconds
DoorSideWidth = 0.7 --0.05 equals 0.5vox
DoorsOnOneSide = 2

RecallLanding = 1

VoiceAnnouncements = false
DoorCloseAnnouncements = false
VoiceVolume = 0.2
DoorCloseAnnOffset = 1 --seconds
FloorAnnouncements  =  {LoadSound("MOD/elevator/sound/voice/GroundFloor.ogg"),
						LoadSound("MOD/elevator/sound/voice/1stFloor.ogg"),
						LoadSound("MOD/elevator/sound/voice/2ndFloor.ogg"),
						LoadSound("MOD/elevator/sound/voice/3rdFloor.ogg"),
						LoadSound("MOD/elevator/sound/voice/4thFloor.ogg"),
						LoadSound("MOD/elevator/sound/voice/5thFloor.ogg"),
						LoadSound("MOD/elevator/sound/voice/6thFloor.ogg"),
						LoadSound("MOD/elevator/sound/voice/7thFloor.ogg"),
						LoadSound("MOD/elevator/sound/voice/8thFloor.ogg"),
						LoadSound("MOD/elevator/sound/voice/9thFloor.ogg"),
						LoadSound("MOD/elevator/sound/voice/10thFloor.ogg"),
						LoadSound("MOD/elevator/sound/voice/11thFloor.ogg"),
						LoadSound("MOD/elevator/sound/voice/12thFloor.ogg"),
						LoadSound("MOD/elevator/sound/voice/13thFloor.ogg"),
						LoadSound("MOD/elevator/sound/voice/14thFloor.ogg"),
						LoadSound("MOD/elevator/sound/voice/15thFloor.ogg"),
						LoadSound("MOD/elevator/sound/voice/16thFloor.ogg"),
						LoadSound("MOD/elevator/sound/voice/17thFloor.ogg"),
						LoadSound("MOD/elevator/sound/voice/18thFloor.ogg"),
						LoadSound("MOD/elevator/sound/voice/19thFloor.ogg"),
						LoadSound("MOD/elevator/sound/voice/20thFloor.ogg"),
						LoadSound("MOD/elevator/sound/voice/21stFloor.ogg"),
						LoadSound("MOD/elevator/sound/voice/22ndFloor.ogg"),
						LoadSound("MOD/elevator/sound/voice/23rdFloor.ogg"),
						LoadSound("MOD/elevator/sound/voice/24thFloor.ogg"),
						LoadSound("MOD/elevator/sound/voice/25thFloor.ogg"),
						LoadSound("MOD/elevator/sound/voice/26thFloor.ogg"),
						LoadSound("MOD/elevator/sound/voice/27thFloor.ogg"),
						LoadSound("MOD/elevator/sound/voice/28thFloor.ogg"),
						LoadSound("MOD/elevator/sound/voice/29thFloor.ogg"),
						LoadSound("MOD/elevator/sound/voice/30thFloor.ogg"),
					   }

FloorLabels = {"G","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30",}

DebugMode = false

function init()
	currentSpeed = 0
	dir = 1
	accelExec = false
	decelExec = false
	running = false
	stopDistance = nil
	callsAboveCar = false
	callsBelowCar = false
	nextStopDecided = false
	preOpenBypass = false
	floor = 1
	destFloor = 1
	safety = true
	inspection = false
	inspDir = 0
	emgStop = false
	hasStoppedFinals = false
	doorTimer = DoorOpenTime
	doorReopenTimer = 0
	doorOpening = false
	doorClosing = false
	doorState = "CLS"
	safetyBypass = false
	chimed = false
	accelTimer = 0
	playedDO = false
	playedDC = true
	stoppedPosition = nil
	fireRecall = false
	isOn=true

	clickUp = LoadSound("clickup.ogg")
	clickDown = LoadSound("clickdown.ogg")
	chime = LoadSound("MOD/elevator/sound/chime.ogg")
	if RunSpeed > 4 then
		motorSound = LoadLoop("MOD/elevator/sound/motor_fast.ogg")
	else
		motorSound = LoadLoop("MOD/elevator/sound/motor.ogg")
	end

	annGoingUp = LoadSound("MOD/elevator/sound/voice/GoingUp.ogg")
	annGoingDown = LoadSound("MOD/elevator/sound/voice/GoingDown.ogg")
	annDoorsOpening = LoadSound("MOD/elevator/sound/voice/DoorsOpening.ogg")
	annDoorsClosing = LoadSound("MOD/elevator/sound/voice/DoorsClosing.ogg")
	annOutOfService = LoadSound("MOD/elevator/sound/voice/OutOfService.ogg")
	annFireRecall = LoadSound("MOD/elevator/sound/voice/FireControl.ogg")

	EVInspDnBtn = FindShape("EVInspDn")
	EVInspUpBtn = FindShape("EVInspUp")
	EVInspSwitch = FindShape("EVInspSwitch")
	EVStopBtn = FindShape("EVStopBtn")
	EVSafetyBypass = FindShape("EVSafetyBypass")
	EVFireRecall = FindShape("EVFireRecall")
	SetTag(EVStopBtn, "interact", "Stop")
	SetTag(EVInspSwitch, "interact", "Inspection Mode")
	SetTag(EVInspUpBtn, "interact", "Up")
	SetTag(EVInspDnBtn, "interact", "Down")
	SetTag(EVSafetyBypass, "interact", "Enable Safety Bypass")
	SetTag(EVFireRecall, "interact", "Fire Recall")

	floorPos = {}
	getFloors()

	landingDoors = FindShapes("EVLandingDoor")
	table.sort(landingDoors, sortShapeByPos)
	carDoors = FindShapes("EVCarDoor")
	for i=1, #carDoors do
		local min, max = GetJointLimits(GetShapeJoints(carDoors[i])[1])
		SetJointMotorTarget(GetShapeJoints(carDoors[i])[1], min, DoorSpeed, DoorStrength)
	end
	for i=1, #landingDoors do
		local min, max = GetJointLimits(GetShapeJoints(landingDoors[i])[1])
		SetJointMotorTarget(GetShapeJoints(landingDoors[i])[1], min, DoorSpeed, DoorStrength)
	end

	callButtons = FindShapes("EVLandingCall")
	table.sort(callButtons, sortShapeByPos)
	for i=1, #callButtons do
		SetTag(callButtons[i], "interact", "Call")
	end

	motor = FindJoint("EVCarMotor")
	SetJointMotor(motor, 0)
	cwMotor = FindJoint("EVCWMotor")
	SetJointMotor(cwMotor, 0)

	car = GetShapeBody(FindShape("EVCar"))
	carS = FindShape("EVCar")
	carID = GetTagValue(carS, "CarID")

	EVCarPanel = FindShape("EVCarPanel")
	SetTag(EVCarPanel, "interact", " ")

	activeCalls = {}
	initCalls()	

	getFloor()

	SetBool("level.EV"..carID.."DCReq", false)
	SetBool("level.EV"..carID.."DOReq", false)
	SetBool("level.EV"..carID.."INS", false)
	SetBool("level.EV"..carID.."RecallReq", false)
	SetBool("level.EV"..carID.."IsOn", true)
end

function getFloors()
	landingLocations = FindLocations("EVFPos")
	for i=1, #landingLocations do
		floorPos[i] = GetLocationTransform(landingLocations[i]).pos[2]
	end
	table.sort(floorPos)
end
function initCalls()
	for i=1, #floorPos do
		SetBool("level.EV"..carID.."call"..i, false)
		activeCalls[i] = false
		SetShapeEmissiveScale(callButtons[i], 0)
	end
end

function run()
	if getCarPosition() <= floorPos[destFloor]+LevelTolerance and getCarPosition() >= floorPos[destFloor]-LevelTolerance and running and decelExec == true and not inspection then --Conditions for stopping at landing
			preOpenBypass = false
			SetJointMotor(motor, 0)
			SetJointMotor(cwMotor, 0)
			stoppedPosition = GetJointMovement(motor)
			SetValue("accelTimer", 0, "linear", 0.001)
			currentSpeed = 0
			activeCalls[floor] = false
			SetBool("level.EV"..carID.."call"..floor, false)
			SetShapeEmissiveScale(callButtons[floor], 0)
			if not fireRecall or floor == RecallLanding then
				doorRun("OPN")
			end
			accelExec = false
			decelExec = false
			running = false
			chimed = false
			if fireRecall and floor ~= RecallLanding then
				initCalls()
				activeCalls[RecallLanding] = true
			end
	elseif not safety and not preOpenBypass and not safetyBypass then --Stop the car from running if the doors are open
		SetJointMotor(motor, 0)
		SetJointMotor(cwMotor, 0)
		stoppedPosition = GetJointMovement(motor)
		SetValue("accelTimer", 0, "linear", 0.001)
		currentSpeed = 0
		accelExec = false
		decelExec = false
		running = false	
	elseif not inspection then
	if not accelExec then --Initialize the destination when starting and accelerate
		if VoiceAnnouncements and (not fireRecall or floor==RecallLanding) then
			if dir == 1 then
				PlaySound(annGoingUp, TransformToParentPoint(GetBodyTransform(GetShapeBody(carS)), GetShapeLocalTransform(carS).pos), VoiceVolume)
			elseif dir == -1 then
				PlaySound(annGoingDown, TransformToParentPoint(GetBodyTransform(GetShapeBody(carS)), GetShapeLocalTransform(carS).pos), VoiceVolume)
			end
		end
		SetValue("accelTimer", RunSpeed, "linear", AccelTime)
		if dir == 1 then
			destFloor = #floorPos
		elseif dir == -1 then
			destFloor = 1
		end
		accelExec = true
	elseif currentSpeed < RunSpeed and decelExec == false then
		currentSpeed = accelTimer
	end
	if getCarPosition() <= floorPos[destFloor]+PreOpenDistance and getCarPosition() >= floorPos[destFloor]-PreOpenDistance and PreOpen and running and decelExec == true and not fireRecall then --Open doors before stopping if PreOpen is enabled
		preOpenBypass = true
		doorRun("OPN")
	end
	if dir == 1 then --Run in the up direction
		SetJointMotor(motor, currentSpeed)
		SetJointMotor(cwMotor, -currentSpeed)
		PlayLoop(motorSound, TransformToParentPoint(GetBodyTransform(GetShapeBody(carS)), GetShapeLocalTransform(carS).pos), (currentSpeed / RunSpeed / 2) + 0.5)
		if currentSpeed ~= 0 then
		for i=#activeCalls, floor, -1  do --Check for calls that can be picked up on the way
			if activeCalls[i]==true and floorPos[i] - getCarPosition() > currentSpeed+MinApproachSpeed and i<destFloor then
				destFloor = i
			end
		end
		if floorPos[destFloor] - getCarPosition() < currentSpeed+MinApproachSpeed then --Slow down into landing
			decelExec = true	
			SetValue("accelTimer", 0, "linear", 0.001)
			if currentSpeed > MinApproachSpeed then
			currentSpeed = floorPos[destFloor] - getCarPosition()+MinApproachSpeed
			end
		end
		end
	elseif dir == -1 then --Run in the down direction
		SetJointMotor(motor, -currentSpeed)
		SetJointMotor(cwMotor, currentSpeed)
		PlayLoop(motorSound, TransformToParentPoint(GetBodyTransform(GetShapeBody(carS)), GetShapeLocalTransform(carS).pos), (currentSpeed / RunSpeed / 2) + 0.5)
		if currentSpeed ~= 0 then
		for i=0, floor do --Check for calls that can be picked up on the way
			if activeCalls[i]==true and getCarPosition() - floorPos[i] > currentSpeed+MinApproachSpeed and i>destFloor then
				destFloor = i
			end
		end
		if getCarPosition() - floorPos[destFloor] < currentSpeed+MinApproachSpeed then --Slow down into landing
			decelExec = true
			SetValue("accelTimer", 0, "linear", 0.001)
			if currentSpeed > MinApproachSpeed then
			currentSpeed = getCarPosition() - floorPos[destFloor]+MinApproachSpeed
			end
		end
		end
	end
	floor = getFloor()
	else
	if inspDir == 1 then --Run up on inspection
		SetJointMotor(motor, InspectionSpeed) 
		SetJointMotor(cwMotor, -InspectionSpeed)
		PlayLoop(motorSound, TransformToParentPoint(GetBodyTransform(GetShapeBody(carS)), GetShapeLocalTransform(carS).pos), (InspectionSpeed / RunSpeed / 2) + 0.5)
	elseif inspDir == -1 then --Run down on inspection
		SetJointMotor(motor, -InspectionSpeed) 
		SetJointMotor(cwMotor, InspectionSpeed)
		PlayLoop(motorSound, TransformToParentPoint(GetBodyTransform(GetShapeBody(carS)), GetShapeLocalTransform(carS).pos), (InspectionSpeed / RunSpeed / 2) + 0.5)
	end
	floor = getFloor() --Check car position
	end
end
function prepStart()
	if not running and not inspection then --Check for active calls
		callsAboveCar = false
		callsBelowCar = false
		for i=1, #activeCalls do
			if activeCalls[i]==true then
				if i > floor then
					callsAboveCar = true
				elseif i < floor then
					callsBelowCar = true
				else --If a call is entered on the floor the car is on, reopen doors
					SetJointMotor(motor, 0)
					SetJointMotor(cwMotor, 0)
					stoppedPosition = GetJointMovement(motor)
					SetValue("accelTimer", 0, "linear", 0.001)
					if getCarPosition() <= floorPos[floor]+OpenTolerance and getCarPosition() >= floorPos[floor]-OpenTolerance then
						doorRun("OPN")
					end
					SetShapeEmissiveScale(callButtons[floor], 0)
					activeCalls[floor] = false
					SetBool("level.EV"..carID.."call"..floor, false)
					accelExec = false
					decelExec = false
					running = false
					currentSpeed = 0
				end
			end
		end
		if dir == 1 then --If lift is already running in the up direction, keep collecting calls above if they exist
			if callsAboveCar then --Start in the up direction
				dir = 1
				SetInt("level.EV"..carID.."dir", dir)
				currentSpeed = 0
				if VoiceAnnouncements and doorTimer >= DoorOpenTime-DoorCloseAnnOffset and doorState == "FULLOPN" and DoorCloseAnnouncements then
					if not playedDC then
						PlaySound(annDoorsClosing, TransformToParentPoint(GetBodyTransform(GetShapeBody(carS)), GetShapeLocalTransform(carS).pos), VoiceVolume)
						playedDC=true
					end
				end
				if doorTimer == DoorOpenTime then
					running = true
					doorRun("CLS")
					run()
				end
			elseif callsBelowCar then --Start in the down direction
				dir = -1
				SetInt("level.EV"..carID.."dir", dir)
				currentSpeed = 0
				if VoiceAnnouncements and doorTimer >= DoorOpenTime-DoorCloseAnnOffset and doorState == "FULLOPN" and DoorCloseAnnouncements then
					if not playedDC then
						PlaySound(annDoorsClosing, TransformToParentPoint(GetBodyTransform(GetShapeBody(carS)), GetShapeLocalTransform(carS).pos), VoiceVolume)
						playedDC=true
					end
				end
				if doorTimer == DoorOpenTime then
					running = true
					doorRun("CLS")
					run()
				end
			end
		else
			if callsBelowCar then --Start in the down direction
				dir = -1
				SetInt("level.EV"..carID.."dir", dir)
				currentSpeed = 0
				if VoiceAnnouncements and doorTimer >= DoorOpenTime-DoorCloseAnnOffset and doorState == "FULLOPN" and DoorCloseAnnouncements then
					if not playedDC then
						PlaySound(annDoorsClosing, TransformToParentPoint(GetBodyTransform(GetShapeBody(carS)), GetShapeLocalTransform(carS).pos), VoiceVolume)
						playedDC=true
					end
				end
				if doorTimer == DoorOpenTime then
					running = true
					doorRun("CLS")
					run()
				end
			elseif callsAboveCar then --Start in the up direction
				dir = 1
				SetInt("level.EV"..carID.."dir", dir)
				currentSpeed = 0
				if VoiceAnnouncements and doorTimer >= DoorOpenTime-DoorCloseAnnOffset and doorState == "FULLOPN" and DoorCloseAnnouncements then
					if not playedDC then
						PlaySound(annDoorsClosing, TransformToParentPoint(GetBodyTransform(GetShapeBody(carS)), GetShapeLocalTransform(carS).pos), VoiceVolume)
						playedDC=true
					end
				end
				if doorTimer == DoorOpenTime then
					running = true
					doorRun("CLS")
					run()
				end
			end
		end
		if not callsAboveCar and not callsBelowCar then --There are no calls, if the door is open close it after the doorTimer expires
			dir = 0
			SetInt("level.EV"..carID.."dir", dir)
			if VoiceAnnouncements and doorTimer >= DoorOpenTime-DoorCloseAnnOffset and doorState == "FULLOPN" and DoorCloseAnnouncements then
				if not playedDC then
					PlaySound(annDoorsClosing, TransformToParentPoint(GetBodyTransform(GetShapeBody(carS)), GetShapeLocalTransform(carS).pos), VoiceVolume)
					playedDC=true
				end
			end
			if doorTimer >= DoorOpenTime and not fireRecall then
				doorRun("CLS")
			end
		end
	else
		run()
	end
end

function doorRun(cmd)
	if cmd == "CLS" then --Close car and landing doors according to the car's position
		doorOpening = false
		doorClosing = true
		playedDO = false
		for i=1, #carDoors do
			if GetTagValue(carDoors[i], "speed") == "1" then
				SetJointMotor(GetShapeJoints(carDoors[i])[1], DoorSpeed*2, DoorStrength)
			else
				SetJointMotor(GetShapeJoints(carDoors[i])[1], DoorSpeed, DoorStrength)
			end
		end
		for i=floor*#carDoors, (floor*#carDoors)-#carDoors+1, -1 do
			if GetTagValue(landingDoors[i], "speed") == "1" then
				SetJointMotor(GetShapeJoints(landingDoors[i])[1], DoorSpeed*2, DoorStrength)
			else
				SetJointMotor(GetShapeJoints(landingDoors[i])[1], DoorSpeed, DoorStrength)
			end
		end
	elseif cmd == "OPN" then --Open car doors, landing doors only if the car is in the door zone
		doorClosing = false
		doorOpening = true
		doorTimer = 0
		doorReopenTimer = 0
		playedDC = false
		SetValue("doorTimer", DoorOpenTime, "linear", DoorOpenTime)
		SetValue("doorReopenTimer", DoorReopenTime+DoorOpenTime, "linear", DoorReopenTime+DoorOpenTime+0.5)
		for i=1, #carDoors do
			if GetTagValue(carDoors[i], "speed") == "1" then
				SetJointMotor(GetShapeJoints(carDoors[i])[1], -DoorSpeed*2, DoorStrength)
			else
				SetJointMotor(GetShapeJoints(carDoors[i])[1], -DoorSpeed, DoorStrength)
			end
		end
		if getCarPosition() > floorPos[floor]-0.5 and getCarPosition() < floorPos[floor]+0.5 then
			for i=floor*#carDoors, (floor*#carDoors)-#carDoors+1, -1 do
				if GetTagValue(landingDoors[i], "speed") == "1" then
					SetJointMotor(GetShapeJoints(landingDoors[i])[1], -DoorSpeed*2, DoorStrength)
				else
					SetJointMotor(GetShapeJoints(landingDoors[i])[1], -DoorSpeed, DoorStrength)
				end
			end
		end
		if VoiceAnnouncements and not playedDO then
			PlaySound(annDoorsOpening, TransformToParentPoint(GetBodyTransform(GetShapeBody(carS)), GetShapeLocalTransform(carS).pos), VoiceVolume)
			playedDO=true
		end
	end
end

function getCarPosition()
	local min, max = GetBodyBounds(car)
	return min[2]
end
function getFloor()
	local i = 1
	while i < #floorPos and getCarPosition() > (floorPos[i] + floorPos[i+1]) / 2 do
		i = i + 1
	end
	if i==destFloor and not chimed and currentSpeed > 0 and not fireRecall then
		PlaySound(chime, TransformToParentPoint(GetBodyTransform(GetShapeBody(carS)), GetShapeLocalTransform(carS).pos))
		if VoiceAnnouncements then
			PlaySound(FloorAnnouncements[i], TransformToParentPoint(GetBodyTransform(GetShapeBody(carS)), GetShapeLocalTransform(carS).pos), VoiceVolume)
		end
		chimed = true
	end
	SetString("level.EV"..carID.."flr", FloorLabels[i])
	return i
end

function FireRecall(x)
	if not inspection then
	if x == true and not fireRecall then
		if VoiceAnnouncements then
			if floor==RecallLanding then
				playedDO = true
			end
			PlaySound(annFireRecall, TransformToParentPoint(GetBodyTransform(GetShapeBody(carS)), GetShapeLocalTransform(carS).pos), VoiceVolume)
		end
		fireRecall = true
		SetBool("level.EV"..carID.."FIRE", true)
		if running then
			for i=1, #floorPos do
				activeCalls[i] = true
			end
		else
			initCalls()
			activeCalls[RecallLanding] = true
		end
	elseif x == false then
		initCalls()
		fireRecall = false
		SetBool("level.EV"..carID.."FIRE", false)
	end
	end
end

function tick(timeDelta)
	if isOn then
	prepStart()
	if not running and not inspection then
		SetJointMotorTarget(motor, stoppedPosition)
	end
	safety=true
	for i=1, #carDoors do --Check car safety circuit
		if GetJointMovement(GetShapeJoints(carDoors[i])[1]) > 0.1 and not safetyBypass then
			safety = false
		end
	end
	if safety == false and not inspection then 
		if doorReopenTimer >= DoorReopenTime+DoorOpenTime then --If the reopen timer expires while the doors aren't closed, reopen the doors
			doorReopenTimer = 0
			if not inspection and not running and getCarPosition() > floorPos[floor]-OpenTolerance and getCarPosition() < floorPos[floor]+OpenTolerance then
				doorRun("OPN")
			end
		end	
	else --Doors are closed, reset timer
		doorReopenTimer = 0
	end
	for i=1, #landingDoors do --Check landing safety circuit
		if GetJointMovement(GetShapeJoints(landingDoors[i])[1]) > 0.1 and not safetyBypass then
			safety = false
		end
	end
	if emgStop == true then --Stop car from moving if emergency stop is pressed
		safety = false
	end
	if safety == true then --Check door state
		doorClosing = false
		doorState = "CLS"
		doorReopenTimer = 0
	elseif GetJointMovement(GetShapeJoints(carDoors[1])[1])>DoorSideWidth-0.1 and GetJointMovement(GetShapeJoints(carDoors[2])[1])>DoorSideWidth-0.1 then
		doorState = "FULLOPN"
	else
		doorState = "OPN"
	end
	if doorOpening and not doorClosing then --If the door open command is given, run doors until they are fully open
		for i=1, #carDoors do
			if GetTagValue(carDoors[i], "speed") == "1" then
				SetJointMotor(GetShapeJoints(carDoors[i])[1], -DoorSpeed*2, DoorStrength)
			else
				SetJointMotor(GetShapeJoints(carDoors[i])[1], -DoorSpeed, DoorStrength)
			end
		end
		if getCarPosition() > floorPos[floor]-0.5 and getCarPosition() < floorPos[floor]+0.5 then
			for i=floor*#carDoors, (floor*#carDoors)-#carDoors+1, -1 do
				if GetTagValue(landingDoors[i], "speed") == "1" then
					SetJointMotor(GetShapeJoints(landingDoors[i])[1], -DoorSpeed*2, DoorStrength)
				else
					SetJointMotor(GetShapeJoints(landingDoors[i])[1], -DoorSpeed, DoorStrength)
				end
			end
		end
		if doorState == "FULLOPN" then
			doorOpening = false
		end
	end
	if getCarPosition() < floorPos[1]-0.5 or getCarPosition() > floorPos[#floorPos]+0.5 then --Check that the car hasn't overrun the top/bottom landing
		if hasStoppedFinals == false then
			hasStoppedFinals = true
			inspDir = 0	
			currentSpeed = 0
			SetJointMotor(motor, 0) --Stop car
			SetJointMotor(cwMotor, 0)
			stoppedPosition = GetJointMovement(motor)
		end
	else
		hasStoppedFinals = false
	end
	if InputPressed("interact") then
			for i=1, #callButtons do --Check all call buttons
				if GetPlayerInteractShape() == callButtons[i] and not inspection and not fireRecall then --If a call button is pressed
					SetShapeEmissiveScale(callButtons[i], 32)
					PlaySound(clickDown, TransformToParentPoint(GetBodyTransform(GetShapeBody(callButtons[i])), GetShapeLocalTransform(callButtons[i]).pos))
					activeCalls[i]=true --Enter call when call button is pressed
					SetBool("level.EV"..carID.."call"..i, true)
				end
			end
			if GetPlayerInteractShape() == EVInspUpBtn then
				PlaySound(clickDown, TransformToParentPoint(GetBodyTransform(GetShapeBody(EVInspUpBtn)), GetShapeLocalTransform(EVInspUpBtn).pos))
				if inspection and (safety or safetyBypass) and getCarPosition() < floorPos[#floorPos]+0.5 then
					inspDir = 1
				else
					inspDir = 0	
				end
			end
			if GetPlayerInteractShape() == EVInspDnBtn then
				PlaySound(clickDown, TransformToParentPoint(GetBodyTransform(GetShapeBody(EVInspDnBtn)), GetShapeLocalTransform(EVInspDnBtn).pos))
				if inspection and (safety or safetyBypass) and getCarPosition() > floorPos[1]-0.5 then
					inspDir = -1
				else
					inspDir = 0
				end
			end
		if GetPlayerInteractShape() == EVInspSwitch then --If inspection switch is pressed
			if inspection == false then --Toggling inspection on
				inspection = true
				PlaySound(clickDown, TransformToParentPoint(GetBodyTransform(GetShapeBody(EVInspSwitch)), GetShapeLocalTransform(EVInspSwitch).pos))
				SetBool("level.EV"..carID.."INS", true)
				inspDir = 0	
				accelExec = false
				decelExec = false
				running = false
				doorRun("CLS")
				initCalls() --Cancel all calls
				currentSpeed = 0
				SetValue("accelTimer", 0, "linear", 0.001)
				SetJointMotor(motor, 0) --Stop car
				SetJointMotor(cwMotor, 0)
				stoppedPosition = GetJointMovement(motor)
				SetTag(EVInspSwitch, "interact", "Normal Mode")
				fireRecall = false
				SetBool("level.EV"..carID.."FIRE", false)
				if VoiceAnnouncements then
					PlaySound(annOutOfService, TransformToParentPoint(GetBodyTransform(GetShapeBody(carS)), GetShapeLocalTransform(carS).pos), VoiceVolume)
				end
			else -- Toggling inspection off
				inspection = false
				PlaySound(clickUp, TransformToParentPoint(GetBodyTransform(GetShapeBody(EVInspSwitch)), GetShapeLocalTransform(EVInspSwitch).pos))
				SetBool("level.EV"..carID.."INS", false)
				inspDir = 0	
				accelExec = false
				decelExec = false
				running = false
				initCalls() --Cancel all calls
				currentSpeed = 0
				SetJointMotor(motor, 0) --Stop car
				SetJointMotor(cwMotor, 0)
				stoppedPosition = GetJointMovement(motor)
				SetTag(EVInspSwitch, "interact", "Inspection Mode")
			end
		end
		if GetPlayerInteractShape() == EVStopBtn then --If emergency stop is pressed
			if emgStop == false then 
				PlaySound(clickDown, TransformToParentPoint(GetBodyTransform(GetShapeBody(EVStopBtn)), GetShapeLocalTransform(EVStopBtn).pos))
				emgStop = true
				inspDir = 0	
				currentSpeed = 0
				SetJointMotor(motor, 0) --Stop car
				SetJointMotor(cwMotor, 0)
				stoppedPosition = GetJointMovement(motor)
				SetTag(EVStopBtn, "interact", "Run")
			else
				PlaySound(clickUp, TransformToParentPoint(GetBodyTransform(GetShapeBody(EVStopBtn)), GetShapeLocalTransform(EVStopBtn).pos))
				emgStop = false
				SetTag(EVStopBtn, "interact", "Stop")
			end
		end
		if GetPlayerInteractShape() == EVSafetyBypass and EVSafetyBypass ~= 0  then --If safety bypass is pressed
			if safetyBypass == false then 
				PlaySound(clickDown, TransformToParentPoint(GetBodyTransform(GetShapeBody(EVStopBtn)), GetShapeLocalTransform(EVStopBtn).pos))
				safetyBypass = true
				SetTag(EVSafetyBypass, "interact", "Disable Safety Bypass")
			else
				PlaySound(clickUp, TransformToParentPoint(GetBodyTransform(GetShapeBody(EVStopBtn)), GetShapeLocalTransform(EVStopBtn).pos))
				safetyBypass = false
				SetTag(EVSafetyBypass, "interact", "Enable Safety Bypass")
			end
		end
		if GetPlayerInteractShape() == EVFireRecall and EVFireRecall ~= 0 then --If fire recall is pressed
			if fireRecall == false then 
				PlaySound(clickDown, TransformToParentPoint(GetBodyTransform(GetShapeBody(EVFireRecall)), GetShapeLocalTransform(EVFireRecall).pos))
				FireRecall(true)
				SetTag(EVFireRecall, "interact", "Normal Operation")
			else
				PlaySound(clickUp, TransformToParentPoint(GetBodyTransform(GetShapeBody(EVFireRecall)), GetShapeLocalTransform(EVFireRecall).pos))
				FireRecall(false)
				SetTag(EVFireRecall, "interact", "Fire Recall")
			end
		end
		if GetPlayerInteractShape() == EVCarPanel then
			SetPlayerScreen(FindScreen("EVCarPanel"))
		end
	end
	for i=1, #floorPos do --Check car panel commands
		if not inspection and not fireRecall and GetBool("level.EV"..carID.."call"..i) == true then
			activeCalls[i]=true --Enter call from car panel
		end
	end
	if GetBool("level.EV"..carID.."DCReq") == true and not inspection and not running then --Door close request from car panel
		SetValue("doorTimer", DoorOpenTime, "linear", 0.05)
		SetValue("doorReopenTimer", DoorOpenTime+DoorReopenTime, "linear", DoorOpenTime-DoorReopenTime)
		doorRun("CLS")
		SetBool("level.EV"..carID.."DCReq", false)
		playedDC=true
	end
	if GetBool("level.EV"..carID.."DOReq") == true and not inspection and not running and getCarPosition() > floorPos[floor]-OpenTolerance and getCarPosition() < floorPos[floor]+OpenTolerance then --Door open request from car panel
		doorRun("OPN")
		SetBool("level.EV"..carID.."DOReq", false)
	end
	if GetBool("level.EV"..carID.."RecallReq") == true and not inspection then --Fire recall request
		FireRecall(true)
	end
	if GetPlayerScreen() ~= FindScreen("EVCarPanel") and currentSpeed == 0 and not inspection and not fireRecall then
		SetTag(EVCarPanel, "interact", " ")
	elseif GetPlayerScreen() == FindScreen("EVCarPanel") and currentSpeed ~= 0 then
		SetPlayerScreen(0)
		RemoveTag(EVCarPanel, "interact")
	else
		RemoveTag(EVCarPanel, "interact")
	end
	if GetBool("level.EV"..carID.."IsOn") == false then
		isOn=false
	end
else
	inspDir = 0	
	accelExec = false
	decelExec = false
	running = false
	initCalls() --Cancel all calls
	currentSpeed = 0
	SetValue("accelTimer", 0, "linear", 0.001)
	SetJointMotor(motor, 0) --Stop car
	SetJointMotor(cwMotor, 0)
	stoppedPosition = GetJointMovement(motor)
	fireRecall = false
	inspection = false
	SetBool("level.EV"..carID.."FIRE", false)
	SetBool("level.EV"..carID.."INS", false)
	if GetBool("level.EV"..carID.."IsOn") == true then
		isOn=true
	end
end
	if DebugMode then
		DebugWatch("speed",currentSpeed)
		DebugWatch("accelTimer",accelTimer)
		DebugWatch("doorTimer",doorTimer)
		DebugWatch("doorReopenTimer",doorReopenTimer)
		DebugWatch("doorState",doorState)
		DebugWatch("doorOpening",doorOpening)
		DebugWatch("floor",floor)
		DebugWatch("nextStop",destFloor)
	end
end