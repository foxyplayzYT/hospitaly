fedfrom = GetStringParam("fed-from", "panel-ckt")
start = GetBoolParam("start-on", true)
name = GetStringParam("panel-name", "")
onSound = LoadSound("clickup.ogg")
offSound = LoadSound("clickdown.ogg")

function init()
    panel = FindShape("panel")
    bkrm = FindShape("bkrm")

    powerI = GetBool(fedfrom)

    if start and powerI then
        setupOn()
        onM = true
        previousOnState = true
    end
    if powerI and not start then
        setupOff()
        onM = false
        previousOnState = false
    end
    if start and not powerI then
        panelPower()
        onM = true
        previousOnState = true
    end
    if not powerI and not start then
        panelPower()
        onM = false
        previousOnState = false
    end

end

function tick()
    --This detects if the panel is broken
    local broken = IsShapeBroken(panel)
    if broken then
        panelbroken()
    end
    
    -- Update power status dynamically
    local previousPower = power
    power = GetBool(fedfrom)

    -- If power is lost
    if not power and previousPower then
        previousOnState = onM  -- Save the current 'on' state before power loss
        panelPower()
    end

    -- If power is restored
    if power and not previousPower then
        onM = previousOnState  -- Restore the 'on' state to what it was before power loss
        if onM then
            panelOn()
        else
            panelOff()
        end
    end

    --This watches the main breaker
    if GetPlayerInteractShape() == bkrm and InputPressed("interact") and power and not broken then
        if onM then
            onM = false
            PlaySound(offSound)
            panelOff()
        else
            onM = true
            PlaySound(onSound)
            panelOn()
        end
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

function panelOff()
    SetBool(name, false)

    SetTag(bkrm,"interact", "Turn On")
end

function panelOn()
    SetTag(bkrm,"interact", "Turn Off")
    
    SetBool(name, true)
end

function setupOn()
    SetTag(bkrm,"interact", "Turn Off")
    
    SetBool(name, true)
end

function setupOff()
    SetTag(bkrm,"interact", "Turn On")
    
    SetBool(name, false)
end
