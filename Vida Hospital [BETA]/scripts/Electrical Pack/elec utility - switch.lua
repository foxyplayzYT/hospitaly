name = GetStringParam("panel-name", "")
start = GetBoolParam("start-on", true)
onSound = LoadSound("clickup.ogg")
offSound = LoadSound("clickdown.ogg")

function init()
    panel = FindShape("panel")
    bkr = FindShape("bkr")

    if start then
        SetTag(bkr,"interact", "Turn Off")
        on = true
        SetBool(name, true)
    else
        SetTag(bkr,"interact", "Turn On")
        on = false
        SetBool(name, false)
    end
end

function tick()
    --This detects if the panel is broken
    local brokenA = IsShapeBroken(panel)
    local brokenB = IsShapeBroken(bkr)
    local broken = brokenA or brokenB
    if broken then
        panelbroken()
    end

    --This watches the main breaker
    if GetPlayerInteractShape() == bkr and InputPressed("interact") and not broken then
        if on then
            on = false
            PlaySound(offSound)
            SetBool(name, false)
            SetTag(bkr,"interact", "Turn On")
        else
            on = true
            PlaySound(onSound)
            SetBool(name, true)
            SetTag(bkr,"interact", "Turn Off")
        end
    end

    
end

function panelbroken()
    SetBool(name, false)
    SetTag(bkr,"interact", "broken")
end