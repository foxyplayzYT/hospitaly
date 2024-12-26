fedfrom = GetStringParam("fed-from", "panel-ckt")
speed = GetIntParam("motor-speed", 10)
onSound = LoadSound("clickup.ogg")
offSound = LoadSound("clickdown.ogg")
local On = false

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
    plug = FindShape("plug")
    rec = FindShape("rec")

    if power then
        switchOn()
    else
        switchPower()
    end
end

function tick()
    local broken = IsShapeBroken(switch)
    if broken then
        switchBroken()
    end

    plugged = IsShapeTouching(plug, rec)
    power1 = GetBool(fedfrom)
    local power = power1 and plugged

    if power and not broken and not On then
        switchOn()
        On = true
    elseif not power and On then
        switchPower()
        On = false
    end
end

function switchOn()

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