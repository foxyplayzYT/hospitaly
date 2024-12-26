fedfrom = GetStringParam("fed-from", "panel-ckt")
name = GetStringParam("panel-name", "")
onSound = LoadSound("clickup.ogg")
offSound = LoadSound("clickdown.ogg")

function init()
    panel = FindShape("panel")
    bkrm = FindShape("bkrm")

    if power then
        setupOn()
    else
        panelPower()
    end
end

function tick()
    --This detects if the panel is broken
    local broken = IsShapeBroken(panel)
    if broken then
        panelbroken()
    end
    
    -- Update power status dynamically
    power = GetBool(fedfrom)

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
