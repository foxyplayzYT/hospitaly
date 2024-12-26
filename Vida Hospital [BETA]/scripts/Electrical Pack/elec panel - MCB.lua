fedfrom = GetStringParam("fed-from", "panel-ckt")
start = GetBoolParam("start-on", true)
name = GetStringParam("panel-name", "")
onSound = LoadSound("clickup.ogg")
offSound = LoadSound("clickdown.ogg")

function init()
    panel = FindShape("panel")
    bkrm = FindShape("bkrm")
    bkr1 = FindShape("bkr1")
    bkr2 = FindShape("bkr2")
    bkr3 = FindShape("bkr3")
    bkr4 = FindShape("bkr4")
    bkr5 = FindShape("bkr5")
    bkr6 = FindShape("bkr6")
    bkr7 = FindShape("bkr7")
    bkr8 = FindShape("bkr8")
    bkr9 = FindShape("bkr9")
    bkr10 = FindShape("bkr10")
    bkr11 = FindShape("bkr11")
    bkr12 = FindShape("bkr12")

    on1 = true
    on2 = true
    on3 = true
    on4 = true
    on5 = true
    on6 = true
    on7 = true
    on8 = true
    on9 = true
    on10 = true
    on11 = true
    on12 = true

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

    if GetPlayerInteractShape() == bkr1 and InputPressed("interact") and onM and power and not broken then
        if on1 then
            on1 = false
            PlaySound(offSound)
            SetTag(bkr1, "interact", "Turn On")
            SetBool(name .. "-1", false)
        else
            on1 = true
            PlaySound(onSound)
            SetTag(bkr1, "interact", "Turn Off")
            SetBool(name .. "-1", true)
        end
    end

    if GetPlayerInteractShape() == bkr2 and InputPressed("interact") and onM and power and not broken then
        if on2 then
            on2 = false
            PlaySound(offSound)
            SetTag(bkr2, "interact", "Turn On")
            SetBool(name .. "-2", false)
        else
            on2 = true
            PlaySound(onSound)
            SetTag(bkr2, "interact", "Turn Off")
            SetBool(name .. "-2", true)
        end
    end

    if GetPlayerInteractShape() == bkr3 and InputPressed("interact") and onM and power and not broken then
        if on3 then
            on3 = false
            PlaySound(offSound)
            SetTag(bkr3, "interact", "Turn On")
            SetBool(name .. "-3", false)
        else
            on3 = true
            PlaySound(onSound)
            SetTag(bkr3, "interact", "Turn Off")
            SetBool(name .. "-3", true)
        end
    end

    if GetPlayerInteractShape() == bkr4 and InputPressed("interact") and onM and power and not broken then
        if on4 then
            on4 = false
            PlaySound(offSound)
            SetTag(bkr4, "interact", "Turn On")
            SetBool(name .. "-4", false)
        else
            on4 = true
            PlaySound(onSound)
            SetTag(bkr4, "interact", "Turn Off")
            SetBool(name .. "-4", true)
        end
    end

    if GetPlayerInteractShape() == bkr5 and InputPressed("interact") and onM and power and not broken then
        if on5 then
            on5 = false
            PlaySound(offSound)
            SetTag(bkr5, "interact", "Turn On")
            SetBool(name .. "-5", false)
        else
            on5 = true
            PlaySound(onSound)
            SetTag(bkr5, "interact", "Turn Off")
            SetBool(name .. "-5", true)
        end
    end

    if GetPlayerInteractShape() == bkr6 and InputPressed("interact") and onM and power and not broken then
        if on6 then
            on6 = false
            PlaySound(offSound)
            SetTag(bkr6, "interact", "Turn On")
            SetBool(name .. "-6", false)
        else
            on6 = true
            PlaySound(onSound)
            SetTag(bkr6, "interact", "Turn Off")
            SetBool(name .. "-6", true)
        end
    end

    if GetPlayerInteractShape() == bkr7 and InputPressed("interact") and onM and power and not broken then
        if on7 then
            on7 = false
            PlaySound(offSound)
            SetTag(bkr7, "interact", "Turn On")
            SetBool(name .. "-7", false)
        else
            on7 = true
            PlaySound(onSound)
            SetTag(bkr7, "interact", "Turn Off")
            SetBool(name .. "-7", true)
        end
    end

    if GetPlayerInteractShape() == bkr8 and InputPressed("interact") and onM and power and not broken then
        if on8 then
            on8 = false
            PlaySound(offSound)
            SetTag(bkr8, "interact", "Turn On")
            SetBool(name .. "-8", false)
        else
            on8 = true
            PlaySound(onSound)
            SetTag(bkr8, "interact", "Turn Off")
            SetBool(name .. "-8", true)
        end
    end

    if GetPlayerInteractShape() == bkr9 and InputPressed("interact") and onM and power and not broken then
        if on9 then
            on9 = false
            PlaySound(offSound)
            SetTag(bkr9, "interact", "Turn On")
            SetBool(name .. "-9", false)
        else
            on9 = true
            PlaySound(onSound)
            SetTag(bkr9, "interact", "Turn Off")
            SetBool(name .. "-9", true)
        end
    end

    if GetPlayerInteractShape() == bkr10 and InputPressed("interact") and onM and power and not broken then
        if on10 then
            on10 = false
            PlaySound(offSound)
            SetTag(bkr10, "interact", "Turn On")
            SetBool(name .. "-10", false)
        else
            on10 = true
            PlaySound(onSound)
            SetTag(bkr10, "interact", "Turn Off")
            SetBool(name .. "-10", true)
        end
    end

    if GetPlayerInteractShape() == bkr11 and InputPressed("interact") and onM and power and not broken then
        if on11 then
            on11 = false
            PlaySound(offSound)
            SetTag(bkr11, "interact", "Turn On")
            SetBool(name .. "-11", false)
        else
            on11 = true
            PlaySound(onSound)
            SetTag(bkr11, "interact", "Turn Off")
            SetBool(name .. "-11", true)
        end
    end

    if GetPlayerInteractShape() == bkr12 and InputPressed("interact") and onM and power and not broken then
        if on12 then
            on12 = false
            PlaySound(offSound)
            SetTag(bkr12, "interact", "Turn On")
            SetBool(name .. "-12", false)
        else
            on12 = true
            PlaySound(onSound)
            SetTag(bkr12, "interact", "Turn Off")
            SetBool(name .. "-12", true)
        end
    end
end





function panelbroken()
    SetBool(name, false)
    SetBool(name .. "-1", false)
    SetBool(name .. "-2", false)
    SetBool(name .. "-3", false)
    SetBool(name .. "-4", false)
    SetBool(name .. "-5", false)
    SetBool(name .. "-6", false)
    SetBool(name .. "-7", false)
    SetBool(name .. "-8", false)
    SetBool(name .. "-9", false)
    SetBool(name .. "-10", false)
    SetBool(name .. "-11", false)
    SetBool(name .. "-12", false)

    SetTag(bkrm,"interact", "broken")
    SetTag(bkr1,"interact", "broken")
    SetTag(bkr2,"interact", "broken")
    SetTag(bkr3,"interact", "broken")
    SetTag(bkr4,"interact", "broken")
    SetTag(bkr5,"interact", "broken")
    SetTag(bkr6,"interact", "broken")
    SetTag(bkr7,"interact", "broken")
    SetTag(bkr8,"interact", "broken")
    SetTag(bkr9,"interact", "broken")
    SetTag(bkr10,"interact", "broken")
    SetTag(bkr11,"interact", "broken")
    SetTag(bkr12,"interact", "broken")
end

function panelPower()
    SetBool(name, false)
    SetBool(name .. "-1", false)
    SetBool(name .. "-2", false)
    SetBool(name .. "-3", false)
    SetBool(name .. "-4", false)
    SetBool(name .. "-5", false)
    SetBool(name .. "-6", false)
    SetBool(name .. "-7", false)
    SetBool(name .. "-8", false)
    SetBool(name .. "-9", false)
    SetBool(name .. "-10", false)
    SetBool(name .. "-11", false)
    SetBool(name .. "-12", false)

    SetTag(bkrm,"interact", "no power")
    SetTag(bkr1,"interact", "no power")
    SetTag(bkr2,"interact", "no power")
    SetTag(bkr3,"interact", "no power")
    SetTag(bkr4,"interact", "no power")
    SetTag(bkr5,"interact", "no power")
    SetTag(bkr6,"interact", "no power")
    SetTag(bkr7,"interact", "no power")
    SetTag(bkr8,"interact", "no power")
    SetTag(bkr9,"interact", "no power")
    SetTag(bkr10,"interact", "no power")
    SetTag(bkr11,"interact", "no power")
    SetTag(bkr12,"interact", "no power")
end

function panelOff()
    SetBool(name, false)
    SetBool(name .. "-1", false)
    SetBool(name .. "-2", false)
    SetBool(name .. "-3", false)
    SetBool(name .. "-4", false)
    SetBool(name .. "-5", false)
    SetBool(name .. "-6", false)
    SetBool(name .. "-7", false)
    SetBool(name .. "-8", false)
    SetBool(name .. "-9", false)
    SetBool(name .. "-10", false)
    SetBool(name .. "-11", false)
    SetBool(name .. "-12", false)

    SetTag(bkrm,"interact", "Turn On")
    SetTag(bkr1,"interact", "no power")
    SetTag(bkr2,"interact", "no power")
    SetTag(bkr3,"interact", "no power")
    SetTag(bkr4,"interact", "no power")
    SetTag(bkr5,"interact", "no power")
    SetTag(bkr6,"interact", "no power")
    SetTag(bkr7,"interact", "no power")
    SetTag(bkr8,"interact", "no power")
    SetTag(bkr9,"interact", "no power")
    SetTag(bkr10,"interact", "no power")
    SetTag(bkr11,"interact", "no power")
    SetTag(bkr12,"interact", "no power")
end

function panelOn()
    SetTag(bkrm,"interact", "Turn Off")
    SetBool(name, true)

    if on1 then
        SetTag(bkr1, "interact", "Turn Off")
        SetBool(name .. "-1", true)
    else
        SetTag(bkr1, "interact", "Turn On")
        SetBool(name .. "-1", false)
    end

    if on2 then
        SetTag(bkr2, "interact", "Turn Off")
        SetBool(name .. "-2", true)
    else
        SetTag(bkr2, "interact", "Turn On")
        SetBool(name .. "-2", false)
    end

    if on3 then
        SetTag(bkr3, "interact", "Turn Off")
        SetBool(name .. "-3", true)
    else
        SetTag(bkr3, "interact", "Turn On")
        SetBool(name .. "-3", false)
    end

    if on4 then
        SetTag(bkr4, "interact", "Turn Off")
        SetBool(name .. "-4", true)
    else
        SetTag(bkr4, "interact", "Turn On")
        SetBool(name .. "-4", false)
    end

    if on5 then
        SetTag(bkr5, "interact", "Turn Off")
        SetBool(name .. "-5", true)
    else
        SetTag(bkr5, "interact", "Turn On")
        SetBool(name .. "-5", false)
    end

    if on6 then
        SetTag(bkr6, "interact", "Turn Off")
        SetBool(name .. "-6", true)
    else
        SetTag(bkr6, "interact", "Turn On")
        SetBool(name .. "-6", false)
    end

    if on7 then
        SetTag(bkr7, "interact", "Turn Off")
        SetBool(name .. "-7", true)
    else
        SetTag(bkr7, "interact", "Turn On")
        SetBool(name .. "-7", false)
    end

    if on8 then
        SetTag(bkr8, "interact", "Turn Off")
        SetBool(name .. "-8", true)
    else
        SetTag(bkr8, "interact", "Turn On")
        SetBool(name .. "-8", false)
    end

    if on9 then
        SetTag(bkr9, "interact", "Turn Off")
        SetBool(name .. "-9", true)
    else
        SetTag(bkr9, "interact", "Turn On")
        SetBool(name .. "-9", false)
    end

    if on10 then
        SetTag(bkr10, "interact", "Turn Off")
        SetBool(name .. "-10", true)
    else
        SetTag(bkr10, "interact", "Turn On")
        SetBool(name .. "-10", false)
    end

    if on11 then
        SetTag(bkr11, "interact", "Turn Off")
        SetBool(name .. "-11", true)
    else
        SetTag(bkr11, "interact", "Turn On")
        SetBool(name .. "-11", false)
    end

    if on12 then
        SetTag(bkr12, "interact", "Turn Off")
        SetBool(name .. "-12", true)
    else
        SetTag(bkr12, "interact", "Turn On")
        SetBool(name .. "-12", false)
    end
end

function setupOn()
    SetTag(bkrm,"interact", "Turn Off")
    SetTag(bkr1,"interact", "Turn Off")
    SetTag(bkr2,"interact", "Turn Off")
    SetTag(bkr3,"interact", "Turn Off")
    SetTag(bkr4,"interact", "Turn Off")
    SetTag(bkr5,"interact", "Turn Off")
    SetTag(bkr6,"interact", "Turn Off")
    SetTag(bkr7,"interact", "Turn Off")
    SetTag(bkr8,"interact", "Turn Off")
    SetTag(bkr9,"interact", "Turn Off")
    SetTag(bkr10,"interact", "Turn Off")
    SetTag(bkr11,"interact", "Turn Off")
    SetTag(bkr12,"interact", "Turn Off")
    
    SetBool(name, true)
    SetBool(name .. "-1", true)
    SetBool(name .. "-2", true)
    SetBool(name .. "-3", true)
    SetBool(name .. "-4", true)
    SetBool(name .. "-5", true)
    SetBool(name .. "-6", true)
    SetBool(name .. "-7", true)
    SetBool(name .. "-8", true)
    SetBool(name .. "-9", true)
    SetBool(name .. "-10", true)
    SetBool(name .. "-11", true)
    SetBool(name .. "-12", true)
end

function setupOff()
    SetTag(bkrm,"interact", "Turn On")
    SetTag(bkr1,"interact", "no power")
    SetTag(bkr2,"interact", "no power")
    SetTag(bkr3,"interact", "no power")
    SetTag(bkr4,"interact", "no power")
    SetTag(bkr5,"interact", "no power")
    SetTag(bkr6,"interact", "no power")
    SetTag(bkr7,"interact", "no power")
    SetTag(bkr8,"interact", "no power")
    SetTag(bkr9,"interact", "no power")
    SetTag(bkr10,"interact", "no power")
    SetTag(bkr11,"interact", "no power")
    SetTag(bkr12,"interact", "no power")
    
    SetBool(name, false)
    SetBool(name .. "-1", false)
    SetBool(name .. "-2", false)
    SetBool(name .. "-3", false)
    SetBool(name .. "-4", false)
    SetBool(name .. "-5", false)
    SetBool(name .. "-6", false)
    SetBool(name .. "-7", false)
    SetBool(name .. "-8", false)
    SetBool(name .. "-9", false)
    SetBool(name .. "-10", false)
    SetBool(name .. "-11", false)
    SetBool(name .. "-12", false)
end
