name = GetStringParam("panel-name", "")

function init()
    panel = FindShape("panel")

        SetTag(bkr,"interact", "")
        SetBool(name, true)
end

function tick()
    --This detects if the panel is broken
    local broken = IsShapeBroken(panel)
    if broken then
        panelbroken()
    end

    
end

function panelbroken()
    SetBool(name, false)
    SetTag(bkr,"interact", "broken")
end