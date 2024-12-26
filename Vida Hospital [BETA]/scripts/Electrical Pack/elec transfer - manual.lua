fedfromA = GetStringParam("fed-from-A", "panel-ckt")
fedfromB = GetStringParam("fed-from-B", "panel-ckt")
start = GetBoolParam("toggle-A/B", true)
name = GetStringParam("panel-name", "")
onSound = LoadSound("clickup.ogg")
offSound = LoadSound("clickdown.ogg")

function init()
    panel = FindShape("panel")
    bkrm = FindShape("bkrm")
    lightA = FindLight("lightA")
    lightB = FindLight("lightB")

    powerIA = GetBool(fedfromA)
    powerIB = GetBool(fedfromB)

    if start and powerIA then
        onM = true
        SetBool(name, true)
        SetTag(bkrm,"interact","turn to source B")
    end
    if start and not powerIA then
        onM = true
        SetBool(name, false)
        SetTag(bkrm,"interact","no power, turn to source B")
    end
    if not start and powerIB then
        onM = false
        SetBool(name, true)
        SetTag(bkrm,"interact","turn to source A")
    end
    if not start and not powerIB then
        onM = false
        SetBool(name, false)
        SetTag(bkrm,"interact","no power, turn to source A")
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

    --This watches the main breaker
    if GetPlayerInteractShape() == bkrm and InputPressed("interact") and not broken then
        if onM then
            onM = false
            PlaySound(offSound)
        else
            onM = true
            PlaySound(onSound)
        end
    end

    if onM and powerA then
        SetBool(name, true)
        SetTag(bkrm,"interact","turn to source B")
    end

    if onM and not powerA then
        SetBool(name, false)
        SetTag(bkrm,"interact","no power turn to source B")
    end

    if not onM and powerB then
        SetBool(name, true)
        SetTag(bkrm,"interact","turn to source A")
    end

    if not onM and not powerB then
        SetBool(name, false)
        SetTag(bkrm,"interact","no power turn to source A")
    end
end





function panelbroken()
    SetBool(name, false)
    SetTag(bkrm,"interact", "broken")
end
