fedfrom = GetStringParam("fed-from", "panel-ckt")
start = GetBoolParam("start-on", true)
speed = GetIntParam("motor-speed", 10)
onSound = LoadSound("clickup.ogg")
offSound = LoadSound("clickdown.ogg")

function init()
    Nlights = FindLights("N")
    NElights = FindLights("NE")
    Elights = FindLights("E")
    Nscreens = FindScreens("N")
    NEscreens = FindScreens("NE")
    Escreens = FindScreens("E")
    Nfans = FindJoints("N")
    NEfans = FindJoints("NE")
    Efans = FindJoints("E")
    switch = FindShape("switch")

    if start and power then
        switchOn()
        on = true
        previousOnState = true
    else
        if power then
            switchOff()
            on = false
            previousOnState = false
        else
            switchPower()
            on = true
            previousOnState = true
        end
    end
end

function tick()
    local broken = IsShapeBroken(switch)
    if broken then
        switchBroken()
    end

    -- Update power status dynamically
    local previousPower = power
    power = GetBool(fedfrom)

    -- If power is lost
    if not power and previousPower then
        previousOnState = on  -- Save the current 'on' state before power loss
        switchPower()
    end

     --If power is restored
    if power and not previousPower then
        on = previousOnState  -- Restore the 'on' state to what it was before power loss
        if on then
            switchOn()
        else
            switchOff()
        end
    end


    if GetPlayerInteractShape() == switch and InputPressed("interact") and power and not broken then
        if on then
            on = false
            PlaySound(offSound)
            switchOff()
        else
            on = true
            PlaySound(onSound)
            switchOn()
        end
    end
end

function switchOn()
    SetTag(switch, "interact", "Turn Off")

    for i=1, #Nlights do
        SetLightEnabled(Nlights[i], true)
    end
    for i=1, #NElights do
        SetLightEnabled(NElights[i], true)
    end
    for i=1, #Elights do
        SetLightEnabled(Elights[i], false)
    end
    for i=1, #Nscreens do
        SetScreenEnabled(Nscreens[i], true)
    end
    for i=1, #NEscreens do
        SetScreenEnabled(NEscreens[i], true)
    end
    for i=1, #Escreens do
        SetScreenEnabled(Escreens[i], false)
    end
    for i=1, #Nfans do
        SetJointMotor(Nfans[i], speed)
    end
    for i=1, #NEfans do
        SetJointMotor(NEfans[i], speed)
    end
    for i=1, #Efans do
        SetJointMotor(Efans[i], 0)
    end
end

function switchOff()
    SetTag(switch, "interact", "Turn On")

    for i=1, #Nlights do
        SetLightEnabled(Nlights[i], false)
    end
    for i=1, #NElights do
        SetLightEnabled(NElights[i], false)
    end
    for i=1, #Elights do
        SetLightEnabled(Elights[i], false)
    end
    for i=1, #Nscreens do
        SetScreenEnabled(Nscreens[i], false)
    end
    for i=1, #NEscreens do
        SetScreenEnabled(NEscreens[i], false)
    end
    for i=1, #Escreens do
        SetScreenEnabled(Escreens[i], false)
    end
    for i=1, #Nfans do
        SetJointMotor(Nfans[i], 0)
    end
    for i=1, #NEfans do
        SetJointMotor(NEfans[i], 0)
    end
    for i=1, #Efans do
        SetJointMotor(Efans[i], 0)
    end
end

function switchBroken()
    SetTag(switch, "interact", "broken")

    for i=1, #Nlights do
        SetLightEnabled(Nlights[i], false)
    end
    for i=1, #NElights do
        SetLightEnabled(NElights[i], true)
    end
    for i=1, #Elights do
        SetLightEnabled(Elights[i], true)
    end
    for i=1, #Nscreens do
        SetScreenEnabled(Nscreens[i], false)
    end
    for i=1, #NEscreens do
        SetScreenEnabled(NEscreens[i], true)
    end
    for i=1, #Escreens do
        SetScreenEnabled(Escreens[i], true)
    end
    for i=1, #Nfans do
        SetJointMotor(Nfans[i], 0)
    end
    for i=1, #NEfans do
        SetJointMotor(NEfans[i], speed)
    end
    for i=1, #Efans do
        SetJointMotor(Efans[i], speed)
    end
end

function switchPower()
    SetTag(switch, "interact", "no power")

    for i=1, #Nlights do
        SetLightEnabled(Nlights[i], false)
    end
    for i=1, #NElights do
        SetLightEnabled(NElights[i], true)
    end
    for i=1, #Elights do
        SetLightEnabled(Elights[i], true)
    end
    for i=1, #Nscreens do
        SetScreenEnabled(Nscreens[i], false)
    end
    for i=1, #NEscreens do
        SetScreenEnabled(NEscreens[i], true)
    end
    for i=1, #Escreens do
        SetScreenEnabled(Escreens[i], true)
    end
    for i=1, #Nfans do
        SetJointMotor(Nfans[i], 0)
    end
    for i=1, #NEfans do
        SetJointMotor(NEfans[i], speed)
    end
    for i=1, #Efans do
        SetJointMotor(Efans[i], speed)
    end
end