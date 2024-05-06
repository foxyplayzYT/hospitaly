function init()
    lightShapes = FindShapes("ALSlight")
    findvehicle = FindShape("ALShorn")
    ALSVehicle = FindVehicle("ALS")
    crane = FindVehicle("crane")
    for i = 1, #lightShapes do SetShapeEmissiveScale(lightShapes[i], 0) end
    currentKmh = 0
    correntKmh = 0
    counter=0
end
function update(dt)
    if GetVehicleHealth(ALSVehicle) >= 0 and not deleted and HasTag(findvehicle, "active") then

    di = GetTagValue(findvehicle, "p") == "1"
    esq = GetTagValue(findvehicle, "p") == "2"
    alerta = GetTagValue(findvehicle, "p") == "3"
    luz = GetTagValue(findvehicle, "l") == "1"
    luzA = GetTagValue(findvehicle, "la") == "1"
    luzAT = GetTagValue(findvehicle, "lat") == "1"
    fadm = GetTagValue(findvehicle, "fa") == "1"
    ad = GetTagValue(findvehicle, "ad") == "1"
    lights1 = GetTagValue(findvehicle, "em") == "1"
    lights2 = GetTagValue(findvehicle, "em") == "2"
    lights3 = GetTagValue(findvehicle, "em") == "3"

    if GetPlayerVehicle() == GetBodyVehicle(GetShapeBody(findvehicle)) then
        if InputDown("left") then
            impa = true
        else
            impa = false
        end
        if InputDown("right") then
            impd = true
        else
            impd = false
        end
        if InputDown("down") then
            brake = true
        else
            brake = false
        end

        if InputPressed("down") then
            counter=counter+1
        end

        if InputPressed("up") then
            counter=0
        end

        if counter >=2 then
            forceback=true
            counter=2
        else
            forceback=false
        end

        if InputDown("handbrake") then
            brake2 = true
        else
            brake2 = false
        end
        if InputDown("up") then
            brake3 = true
        else
            brake3 = false
        end
    else
        counter=0
        forceback=false
        brake = false
        brake2 = false
        brake3 = false
        impa = false
        impd = false
    end

    if HasTag(findvehicle, "delete") then
        if GetVehicleHealth(ALSVehicle) == 0 then
            Delete(ALSVehicle)
            Delete(crane)
            Delete(findvehicle)
            deleted = true
            for i = 1, #lightShapes do Delete(lightShapes[i]) end
        end
    end
    if GetVehicleHealth(ALSVehicle) < 0.20 or not HasTag(ALSVehicle, "emergency") then
        for i = 1, #lightShapes do
            SetShapeEmissiveScale(lightShapes[i], 0)
        end
    end

    if di or esq or alerta or luz or luzAT or impa or impd or ad or brake or brake2 or brake3 or forceback then
            NormalLights() 
    end
    
    if HasTag(findvehicle, "UP") then popupheadlights() end 
    end

end

function NormalLights()
    if GetPlayerVehicle() == GetBodyVehicle(GetShapeBody(findvehicle)) then
        local v = GetPlayerVehicle()
        if v ~= 0 then
            local b = GetVehicleBody(v)
            local t = GetVehicleTransform(v)
            local vel = TransformToLocalVec(t, GetBodyVelocity(b))
            local speed = -vel[3]
            currentKmh = speed * 3.6
        else
            currentKmh = 0
        end
        correntKmh = currentKmh + 0.1 * currentKmh
    end

    for i = 1, #lightShapes do
        tagValue = GetTagValue(lightShapes[i], "ALSlight")
        typeValue = GetTagValue(lightShapes[i], "type")
        statusValue = GetTagValue(lightShapes[i], "status")
        lights = GetShapeLights(lightShapes[i])

        local hinge = GetShapeJoints(lightShapes[i])
        for u = 1, #hinge do hinges = hinge[u] end

        if IsShapeBroken(lightShapes[i]) or IsJointBroken(hinges) then
            Delete(lightShapes[i])
        end

        if statusValue == "1" then
            if di then
                apaga = true
            else
                apaga = false
            end
            if esq then
                apaga2 = true
            else
                apaga2 = false
            end
        end
    --farol frente normal
        if tagValue == "FFN_D" and not apaga or tagValue == "FFN_E" and not apaga2 then
            if typeValue == "1" then
                if luz and not luzA and not luzAT then
                    SetShapeEmissiveScale(lightShapes[i], 1)
                    for j = 1, #lights do
                        if GetTagValue(lights[j], "type") == "1" then
                            SetLightIntensity(lights[j], GetFloat("lightsf")/5)
                        end
                    end
                end
                if luz and luzA or luzAT then
                    SetShapeEmissiveScale(lightShapes[i], 1)
                    for j = 1, #lights do
                        if GetTagValue(lights[j], "type") == "2" then
                            SetLightIntensity(lights[j], GetFloat("HighBeam"))
                        end
                    end
                else
                    for j = 1, #lights do
                        if GetTagValue(lights[j], "type") == "2" then
                            SetLightIntensity(lights[j], 0)
                        end
                    end
                end
            elseif typeValue == "2" then
                if luz and not luzA and not luzAT then
                    SetShapeEmissiveScale(lightShapes[i], 1)
                    for j = 1, #lights do
                        SetLightIntensity(lights[j], GetFloat("lightsf")/5)
                    end
                end
                if luz and luzA or luzAT then
                    SetShapeEmissiveScale(lightShapes[i], 0)
                    for j = 1, #lights do
                        SetLightIntensity(lights[j], 0)
                    end
                end
            elseif typeValue == "3" then
                if luz then
                    SetShapeEmissiveScale(lightShapes[i], 1)
                    for j = 1, #lights do
                        SetLightIntensity(lights[j], GetFloat("lightsf")/5)
                    end
                end
                if luz and luzA or luzAT then
                    SetShapeEmissiveScale(lightShapes[i], 1)
                    for j = 1, #lights do
                        if GetTagValue(lights[j], "type") == "1" then
                            SetLightIntensity(lights[j], 0)
                        end
                    end
                end
            end
    --lanterna trazeira normal
        elseif tagValue == "LTN_D" or tagValue == "LTN_E" then
            if typeValue == "1" then
                if luz or luzAT then
                    SetShapeEmissiveScale(lightShapes[i], 1)
                    for j = 1, #lights do
                        SetLightIntensity(lights[j], GetFloat("lightst")/50)
                    end
                end
            elseif typeValue == "2" then
                local timeScale = math.ceil(-math.cos((GetTime())*9))
                if tagValue == "LTN_D" and di or alerta then
                    SetShapeEmissiveScale(lightShapes[i], timeScale)
                    for j = 1, #lights do
                        SetLightIntensity(lights[j], timeScale/2)
                    end
                elseif tagValue == "LTN_E" and esq or alerta then
                    SetShapeEmissiveScale(lightShapes[i], timeScale)
                    for j = 1, #lights do
                        SetLightIntensity(lights[j], timeScale/2)
                    end
                elseif luz and not di or luz and not esq or luzAT and not di or luzAT and not esq then
                    SetShapeEmissiveScale(lightShapes[i], 1)
                    for j = 1, #lights do
                        SetLightIntensity(lights[j], GetFloat("lightst")/50)
                    end
                end
            end
    --farol frente Alto
        elseif tagValue == "FFA_D" and not apaga or tagValue == "FFA_E" and not apaga2 then
            if luzA and luz or luzAT then
                SetShapeEmissiveScale(lightShapes[i], 1)
                for j = 1, #lights do
                    SetLightIntensity(lights[j], GetFloat("HighBeam"))
                end
            end
    --farol de milha
        elseif tagValue == "FDM_D" or tagValue == "FDM_E" then
            if typeValue == "1" then
                if fadm and luz then
                    SetShapeEmissiveScale(lightShapes[i], 1)
                    for j = 1, #lights do
                        SetLightIntensity(lights[j], GetFloat("lightsf")/5)
                    end
                end
            elseif typeValue == "2" then
                if tagValue == "FDM_D" and impd and luz then
                    SetShapeEmissiveScale(lightShapes[i], 1)
                    for j = 1, #lights do
                        SetLightIntensity(lights[j], GetFloat("lightsf")/5)
                    end
                elseif tagValue == "FDM_E" and impa and luz then
                    SetShapeEmissiveScale(lightShapes[i], 1)
                    for j = 1, #lights do
                        SetLightIntensity(lights[j], GetFloat("lightsf")/5)
                    end
                elseif fadm and not impa and luz or fadm and not impd and luz then
                    SetShapeEmissiveScale(lightShapes[i], 1)
                    for j = 1, #lights do
                        SetLightIntensity(lights[j], GetFloat("lightsf")/5)
                    end
                end
            end
    --lanterna freio normal
        elseif tagValue == "LFN_D" or tagValue == "LFN_E" then
            if typeValue == "1" then
                if brake2 or brake and correntKmh > 2 or brake3 and correntKmh < -20 then
                    if not forceback or brake2 then
                    SetShapeEmissiveScale(lightShapes[i], 1)
                    for j = 1, #lights do
                        SetLightIntensity(lights[j], GetFloat("lightst")/50)
                    end
                end
            end
            elseif typeValue == "2" then
                if tagValue == "LFN_D" and di or alerta then
                    local timeScale = math.ceil(-math.cos((GetTime())*9))
                    SetShapeEmissiveScale(lightShapes[i], timeScale)
                    for j = 1, #lights do
                        SetLightIntensity(lights[j], timeScale/2)
                    end
                elseif tagValue == "LFN_E" and esq or alerta then
                    local timeScale = math.ceil(-math.cos((GetTime())*9))
                    SetShapeEmissiveScale(lightShapes[i], timeScale)
                    for j = 1, #lights do
                        SetLightIntensity(lights[j], timeScale/2)
                    end
                elseif brake2 or brake and correntKmh > 2 or brake3 and correntKmh < -20 then
                    if not forceback or brake2 then
                        SetShapeEmissiveScale(lightShapes[i], 1)
                        for j = 1, #lights do
                            SetLightIntensity(lights[j], GetFloat("lightst")/50)
                        end
                    end
                end
            elseif typeValue == "3" then
                if tagValue == "LFN_D" and di or alerta then
                    local timeScale = math.ceil(-math.cos((GetTime())*9))
                    SetShapeEmissiveScale(lightShapes[i], timeScale)
                    for j = 1, #lights do
                        SetLightIntensity(lights[j], timeScale/2)
                    end
                elseif tagValue == "LFN_E" and esq or alerta then
                    local timeScale = math.ceil(-math.cos((GetTime())*9))
                    SetShapeEmissiveScale(lightShapes[i], timeScale)
                    for j = 1, #lights do
                        SetLightIntensity(lights[j], timeScale/2)
                    end
                elseif brake2 or brake and correntKmh > 2 or InputDown("up") and correntKmh < -20 then
                    if not forceback or brake2 then
                        SetShapeEmissiveScale(lightShapes[i], 1)
                        for j = 1, #lights do
                            SetLightIntensity(lights[j], GetFloat("lightst")/50)
                        end
                    end
                elseif luz or luzAT then
                    SetShapeEmissiveScale(lightShapes[i], 0.5)
                    for j = 1, #lights do
                        SetLightIntensity(lights[j], GetFloat("lightst")/50)
                    end
                end
            elseif typeValue == "4" then
                if brake2 or brake and correntKmh > 2 or brake3 and correntKmh < -20 then
                    if not forceback or brake2 then
                        SetShapeEmissiveScale(lightShapes[i], 1)
                        for j = 1, #lights do
                            SetLightIntensity(lights[j], GetFloat("lightst")/50)
                        end
                    end
                elseif luz or luzAT then
                    SetShapeEmissiveScale(lightShapes[i], 0.5)
                    for j = 1, #lights do
                        SetLightIntensity(lights[j], GetFloat("lightst")/50)
                    end
                end
            end
    --luz adicional
        elseif tagValue == "ADN_E" or tagValue == "ADN_D" then
            if ad then
                SetShapeEmissiveScale(lightShapes[i], 1)
                for j = 1, #lights do
                    if GetTagValue(lights[j], "type") == "1" then
                        SetLightIntensity(lights[j], GetFloat("lightsf"))
                    end
                    if GetTagValue(lights[j], "type") == "2" then
                        SetLightIntensity(lights[j], GetFloat("lightst"))  
                    end
                end
            end
    --re
        elseif tagValue == "BLN_E" or tagValue == "BLN_D" then
            if forceback or brake and correntKmh < 0 then
                    counter=2
                for j = 1, #lights do
                    SetLightIntensity(lights[j], GetFloat("lightst")/50)
                end
                SetShapeEmissiveScale(lightShapes[i], 1)
            end

    --pisca direiro/esquerdo
        elseif tagValue == "PC_D" then
            if di or alerta then
                for j = 1, #lights do
                    SetLightIntensity(lights[j], GetFloat("lightst")/40)
                end
                local timeScale = math.ceil(-math.cos((GetTime())*9))
                SetShapeEmissiveScale(lightShapes[i], timeScale/2)
            end
        elseif tagValue == "PC_E" then
            if esq or alerta then
                for j = 1, #lights do
                    SetLightIntensity(lights[j], GetFloat("lightst")/40)
                end
                local timeScale = math.ceil(-math.cos((GetTime())*9))
                SetShapeEmissiveScale(lightShapes[i], timeScale/2)
            end
        end
    end
end

function popupheadlights()
    for i = 1, #lightShapes do
        tagValue = GetTagValue(lightShapes[i], "ALSlight")
        local hinge = GetShapeJoints(lightShapes[i])
        for u = 1, #hinge do hinges = hinge[u] end

        if lights1 or lights2 or lights3 then
            if HasTag(lightShapes[i], "UP") then
                if tagValue == "FFN_D" or tagValue == "FFN_E" then
                    SetJointMotorTarget(hinges, GetTagValue(hinges, "popup"), GetTagValue(hinges, "veloc"))
                end
            elseif HasTag(lightShapes[i], "DOWN") then
                if tagValue == "FFN_D" or tagValue == "FFN_E" then
                SetJointMotorTarget(hinges, 0, GetTagValue(hinges, "veloc"))
                end
            end
        end
        if luz or luz and luzA or luzAT then
            if tagValue == "FFN_D" or tagValue == "FFN_E" then
                SetJointMotorTarget(hinges, GetTagValue(hinges, "popup"), GetTagValue(hinges, "veloc"))
                SetTag(lightShapes[i], "UP")
            end
        else
            if HasTag(lightShapes[i], "UP") and not lights1 and not lights2 and not lights3 then
                if not luz or not luzA or not luzAT then
                    SetJointMotorTarget(hinges, 0, GetTagValue(hinges, "veloc"))
                    RemoveTag(lightShapes[i], "UP")
                    RemoveTag(lightShapes[i], "DOWN")
                end
            end
        end
    end
end

function draw()
    if GetPlayerVehicle() == GetBodyVehicle(GetShapeBody(findvehicle)) and not HasTag(findvehicle, "active") and not deleted then
        if InputPressed("esc")then
            close=true

        end
        if not close then
            SetBool("game.disablepause", true)
        UiPush()
            local w = UiWidth()
            local h = UiHeight()
            UiTranslate(w-20, h-250)
            UiAlign("right bottom")
            UiImage("MOD/images/missing.png")
            UiFont("regular.ttf", 20)
            UiWordWrap(250)
            UiTranslate(-5, 0)
            UiText("Press (ESC) to hide this message")
            UiTranslate(0, -60)
            UiText("Please make sure that you have Advanced light system installed and enabled, otherwise the lights and sirens won't work.")
        UiPop()
        end
    end
end
