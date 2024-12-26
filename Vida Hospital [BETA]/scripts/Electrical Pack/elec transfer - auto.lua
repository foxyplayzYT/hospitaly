fedfromA = GetStringParam("fed-from-A", "panel-ckt")
fedfromB = GetStringParam("fed-from-B", "panel-ckt")
name = GetStringParam("panel-name", "")
onSound = LoadSound("clickup.ogg")
offSound = LoadSound("clickdown.ogg")

function init()
    panel = FindShape("panel")
    bkrm = FindShape("bkrm")
    lightA = FindLight("lightA")
    lightB = FindLight("lightB")

    if power then
        setupOn()
    else
        panelPower()
    end
end

function tick()
    --This detects if the panel is broken
    local brokenA = IsShapeBroken(panel)
    local brokenB = IsShapeBroken(bkrm)
    local broken = brokenA or brokenB
    if broken then
        panelbroken()
    end
    
    -- Update power status dynamically
    powerA = GetBool(fedfromA)
    powerB = GetBool(fedfromB)
    power = powerA or powerB

    if powerA then
        SetLightEnabled(lightA, true)
    else
        SetLightEnabled(lightA, false)
    end
    if powerB then
        SetLightEnabled(lightB, true)
    else
        SetLightEnabled(lightB, false)
    end

    -- If power is lost
    if power then
        panelOn()
    else
        panelPower()
    end
end





function panelbroken()
    SetBool(name, false)
    SetTag(bkrm,"interact", "broken")
end

function panelPower()
    SetBool(name, false)
    SetTag(bkrm,"interact", "no power")
end

function panelOn()
    SetBool(name, true)
    SetTag(bkrm,"interact", "")
end

function setupOn()
    SetBool(name, true)
    SetTag(bkrm,"interact", "")
end
