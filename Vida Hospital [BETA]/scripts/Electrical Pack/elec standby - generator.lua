sensefrom = GetStringParam("sense-from", "panel-ckt")
name = GetStringParam("panel-name", "")
auto = GetBoolParam("auto-sense-on", true)
start = GetBoolParam("start-on(if-autosense=false)", false)
time = GetIntParam("ramp-up-time", 5)
igSound = LoadSound("vehicle/tractor-ignition.ogg")
dvSound = LoadLoop("vehicle/tractor-drive.ogg")
local smokeFrequency = 0.05 -- Time between each smoke particle
local lastSmokeTime = 0     -- Keep track of last smoke emission time
local genOnStartTime = nil  -- Global variable to track the time when genOn was called
local isStarting = false  -- Flag to track startup progress

function init()
    gen = FindShape("generator")
    swA = FindShape("swA")
    swS = FindShape("swS")
    fan = FindJoint("fan")
    light = FindLight("light")
    light2 = FindLight("light2")
    exhaust = FindLocation("exhaust")
    loc = GetLocationTransform(exhaust).pos

    powerI = GetBool(sensefrom)

    if auto and powerI then
        onA = true
        SetTag(swA, "interact", "turn to manual mode")
        onS = false
        SetTag(swS, "interact", " ")
        genOff()
    end

    if auto and not powerI then
        onA = true
        SetTag(swA, "interact", "turn to manual mode")
        onS = true
        SetTag(swS, "interact", " ")
        genOn()
    end

    if start and not auto then
        onA = false
        SetTag(swA, "interact", "turn to auto mode")
        onS = false
        SetTag(swS, "interact", "off")
        genOn()
    end

    if not start and not auto then
        onA = false
        SetTag(swA, "interact", "turn to auto mode")
        onS = true
        SetTag(swS, "interact", "on")
        genOff()
    end 
end

function tick()
    --This detects if the generator is broken
    local broken = IsShapeBroken(gen)
    if broken then
        genbroken()
    end

    power = GetBool(sensefrom)

    --This watches the auto/manual switch
    if GetPlayerInteractShape() == swA and InputPressed("interact") and not broken then
        if onA then
            onA = false
            SetTag(swA, "interact", "turn to auto mode")
        else
            onA = true
            SetTag(swA, "interact", "turn to manual mode")
        end
    end

    -- Handle auto mode
    if onA and power and not broken then
        genOff()
        SetTag(swS, "interact", " ")
    elseif onA and not power and not broken then
        genOn(false)  -- Auto mode logic
        SetTag(swS, "interact", " ")
    end

    -- Handle manual mode
    if not onA and not broken then
        manual()
    end

    -- Handle generator startup process (auto or manual)
    if isStarting and not broken then
        local elapsedTime = GetTime() - genOnStartTime
        if elapsedTime >= time then
            SetBool(name, true)
            SetLightEnabled(light2, true)
            isStarting = false  -- Startup complete
        end
    end

    -- Check generator status for smoke and sound emission
    if isStarting and not broken or GetBool(name) and not broken then
        local currentTime = GetTime()
        if currentTime - lastSmokeTime >= smokeFrequency then
            emitSmoke(loc)
            lastSmokeTime = currentTime
        end
        PlayLoop(dvSound, loc)
    end
end

-- Function to emit smoke from the exhaust
function emitSmoke(position)
    -- Customize the smoke appearance
    local smokeSize = 1.0
    local smokeVelocity = Vec(0, 4, 0) -- Rising smoke
    local smokeColor = Vec(0.5, 0.5, 0.5) -- Grayish smoke

    -- Spawn the smoke particle
    SpawnParticle("smoke", position, smokeVelocity, smokeSize, 2.0, smokeColor)
end

function genbroken()
    SetBool(name, false)
    SetTag(swA, "interact", "Broken")
    SetTag(swS, "interact", "Broken")
    SetJointMotor(fan, 0)
    SetLightEnabled(light, false)
    SetLightEnabled(light2, false)
end

function genOn(isManual)
    SetJointMotor(fan, 10)
    SetLightEnabled(light, true)

    -- Track startup timing, whether in manual or auto mode
    if not isStarting and not broken then
        genOnStartTime = GetTime()
        isStarting = true
    end
end

function genOff()
    SetBool(name, false)
    SetJointMotor(fan, 0)
    SetLightEnabled(light, false)
    SetLightEnabled(light2, false)
    isStarting = false
    genOnStartTime = nil
end

function manual()
    --This watches the override switch
    if GetPlayerInteractShape() == swS and InputPressed("interact") and not onA and not broken then
        if onS then
            onS = false
            SetTag(swS, "interact", "off")
            genOn(true)
        else
            onS = true
            SetTag(swS, "interact", "on")
            genOff()
        end
    end
end