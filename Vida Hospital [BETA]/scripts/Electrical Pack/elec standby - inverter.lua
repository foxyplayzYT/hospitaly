name = GetStringParam("panel-name", "")
fail = GetIntParam("percentage-for-failure", 50)

function init()
    inv = FindShapes("inverter")
    pnl = FindShape("panel")
    light = FindLight("light")
end

function tick()
    --This detects if the generator is broken
    local broken = IsShapeBroken(pnl)
    if broken then
        pnlbroken()
        return
    end

    -- Count the number of broken inverters
    local totalInverters = #inv
    local brokenCount = 0

    -- Iterate through each inverter to check for broken status
    for _, inverter in ipairs(inv) do
        if IsShapeBroken(inverter) then
            brokenCount = brokenCount + 1  -- Increment count for broken inverters
        end
    end

    -- Calculate the percentage of broken inverters
    local brokenPercentage = (brokenCount / totalInverters) * 100

    -- Set the state based on the broken percentage
    if brokenPercentage >= fail then
        SetBool(name, false)          -- Set name to false if fail percentage is met
        SetLightEnabled(light, false) -- Turn off light
    else
        SetBool(name, true)           -- Set name to true if not met
        SetLightEnabled(light, true)  -- Turn on light
    end
end

function pnlbroken()
    SetBool(name, false)
    SetLightEnabled(light, false)
end