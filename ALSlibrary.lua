function LightShapeUpdate(lightShapes, shapelight, LightIntensity)
    SetShapeEmissiveScale(lightShapes, shapelight)
    for j = 1, #lights do
        SetLightIntensity(lights[j], LightIntensity)
    end
end

function LightUpdate(lightShapes, shapelight, LightIntensity, lighttype)
    SetShapeEmissiveScale(lightShapes, shapelight)
    for j = 1, #lights do
        if lighttype == 1 then
            if GetTagValue(lights[j], "type") == "1" then
                SetLightIntensity(lights[j], LightIntensity)
            end
        elseif lighttype == 2 then
            if GetTagValue(lights[j], "type") == "2" then
                SetLightIntensity(lights[j], LightIntensity)
            end
        end
    end
end

--normal lights
function NormalLights(time)
    --if inside the vehicle
    if GetPlayerVehicle() == ALSVehicle then
        --vehicle velocity
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
    if alarmcar then
        timing=15
    elseif piscatemp2 then
        timing=8
    elseif piscatemp then
        timing=0
    else
        timing=25
    end

    for i = 1, #lightShapes do
        --get the tags value
        tagValue = GetTagValue(lightShapes[i], "ALSlight")
        typeValue = GetTagValue(lightShapes[i], "type")
        statusValue = GetTagValue(lightShapes[i], "status")
        lights = GetShapeLights(lightShapes[i])

        --find joints
        local hinge = GetShapeJoints(lightShapes[i])
        for u = 1, #hinge do hinges = hinge[u] end

        --if broken delete
        if IsShapeBroken(lightShapes[i]) or IsJointBroken(hinges) then
            Delete(lightShapes[i])
        end

        --activate some light functions
        --EX: Fog light assitance
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
        if tagValue == "FFN_R" and not apaga or tagValue == "FFN_L" and not apaga2 then
            --farol com 2 shapes e 4 luses
            if typeValue == "1" then
                --farol Aceso
                if luz and not luzA and not luzAT then
                    LightUpdate(lightShapes[i], 1, GetFloat("lightsf")/5, 1)
                end
                --farol alto ou farol alto temporario
                if luz and luzA or luzAT then
                    LightUpdate(lightShapes[i], 1, GetFloat("HighBeam"), 2)
                    LightUpdate(0, 0, 0, 1)
                else
                    --se nao tiver nada aceso apagar farol alto
                    LightUpdate(0, 0, 0, 2)
                end

            --farol com 4 shapes e 4 luzes onde o farol alterna com o farol alto
            elseif typeValue == "2" then
                --farol aceso
                if luz and not luzA and not luzAT then
                    LightShapeUpdate(lightShapes[i], 1, GetFloat("lightsf")/5)
                end
                --luz alta apaga o shape e a luz do farol
                if luz and luzA or luzAT then
                    LightShapeUpdate(lightShapes[i], 0, 0)
                end
            --farol com 4 shape e 4 luzes
            elseif typeValue == "3" then
                --farol aceso
                if luz then
                    LightShapeUpdate(lightShapes[i], 1, GetFloat("lightsf")/5)
                end
                --farol luz alta apaga apenas a luz do farol normal
                if luz and luzA or luzAT then
                    LightUpdate(lightShapes[i], 1, 0, 1)
                end
            end

    --lanterna trazeira normal
        elseif tagValue == "LTN_R" or tagValue == "LTN_L" then
            --farol com 2 shapes e 2 luzes
            if typeValue == "1" then
                --farol aceso de traz
                if luz or luzAT then
                    LightShapeUpdate(lightShapes[i], 1, GetFloat("lightst")/50)
                end
            --farol com 2 shapes e 2 luzes mais pisca
            elseif typeValue == "2" then
                --acender pisca direito
                if tagValue == "LTN_R" and di or alerta then
                    if time >= timing then
                        LightShapeUpdate(lightShapes[i], 1, 0.5)
                    end
                --acender pisca esquerdo
                elseif tagValue == "LTN_L" and esq or alerta then
                    LightShapeUpdate(lightShapes[i], 1, 0.5)
                --acender farol quando os pisca estiverem desligados
                elseif luz and not di or luz and not esq or luzAT and not di or luzAT and not esq then
                    LightShapeUpdate(lightShapes[i], 1, GetFloat("lightst")/50)
                end
            end

    --farol frente Alto com 2 shapes e 2 luzes
        elseif tagValue == "FFA_R" and not apaga or tagValue == "FFA_L" and not apaga2 then
            --acende farol alto
            if luzA and luz or luzAT then
                LightShapeUpdate(lightShapes[i], 1, GetFloat("HighBeam"))
            end

    --farol de milha
        elseif tagValue == "FDM_R" or tagValue == "FDM_L" then
            --farol de milha normal
            if typeValue == "1" then
                --acende farol alto
                if fadm and luz then
                    LightShapeUpdate(lightShapes[i], 1, GetFloat("lightsf")/5)
                end
            --farol de milha com asistencia a curva
            elseif typeValue == "2" then
                --se virar para a direitata acender luz da direitata
                if tagValue == "FDM_R" and di and luz then
                    LightShapeUpdate(lightShapes[i], 1, GetFloat("lightsf")/5)
            --se virar para a esquerda acender luz da esquerda
                elseif tagValue == "FDM_L" and esq and luz then
                    LightShapeUpdate(lightShapes[i], 1, GetFloat("lightsf")/5)
            -- acender farois de milha normal
                elseif fadm and luz or fadm and luz then
                    LightShapeUpdate(lightShapes[i], 1, GetFloat("lightsf")/5)
                end
            end

    --lanterna fpry[9]o normal com 2 shapes e 2 luzes
        elseif tagValue == "LFN_R" or tagValue == "LFN_L" then
            --farol de fpry[9]o normal
            if typeValue == "1" then
                --acender luz de fpry[9]o
                if brake3 or brake and correntKmh > 2 or brake2 and correntKmh < -20 then
                    if not forceback or brake3 then
                        LightShapeUpdate(lightShapes[i], 1, GetFloat("lightst")/50)
                end
            end
            --farol de fpry[9]o com pisca
            elseif typeValue == "2" then
                --acender pisca dipry[9]to
                if tagValue == "LFN_R" and di or alerta then
                    if time >= timing then
                        LightShapeUpdate(lightShapes[i], 1, 0.5)
                    elseif luz or luzA or luzAT then
                        LightShapeUpdate(lightShapes[i], 0.4, GetFloat("lightst")/50)
                    end
                --acender pisca da esquerda
                elseif tagValue == "LFN_L" and esq or alerta then
                    if time >= timing then
                        LightShapeUpdate(lightShapes[i], 1, 0.5)
                    elseif luz or luzA or luzAT then
                        LightShapeUpdate(lightShapes[i], 0.4, GetFloat("lightst")/50)
                    end
                --acender luz de fpry[9]o
                elseif brake3 or brake and correntKmh > 2 or brake2 and correntKmh < -20 then
                    if not forceback or brake3 then
                        LightShapeUpdate(lightShapes[i], 1, GetFloat("lightst")/50)
                    end
                end
            --farol de fpry[9]o com pisca e luz de farol
            elseif typeValue == "3" then
                --acender pisca da dipry[9]ta
                if tagValue == "LFN_R" and di or alerta then
                    if time >= timing then
                        LightShapeUpdate(lightShapes[i], 1, 0.5)
                    elseif luz or luzA or luzAT then
                        LightShapeUpdate(lightShapes[i], 0.4, GetFloat("lightst")/50)
                    end
                --acender pisca da esquerda
                elseif tagValue == "LFN_L" and esq or alerta then
                    if time >= timing then
                        LightShapeUpdate(lightShapes[i], 1, 0.5)
                    elseif luz or luzA or luzAT then
                        LightShapeUpdate(lightShapes[i], 0.4, GetFloat("lightst")/50)
                    end
                --acender fpry[9]o
                elseif brake3 or brake and correntKmh > 2 or brake2 and correntKmh < -20 then
                    if not forceback or brake3 then
                        LightShapeUpdate(lightShapes[i], 1, GetFloat("lightst")/50)
                    end
                --acender luz do farol
                elseif luz or luzAT then
                    LightShapeUpdate(lightShapes[i], 0.4, GetFloat("lightst")/50)
                end
            --luz de fpry[9]o com farol
            elseif typeValue == "4" then
                --acener luz de fpry[9]o
                if brake3 or brake and correntKmh > 2 or brake2 and correntKmh < -20 then
                    if not forceback or brake3 then
                        LightShapeUpdate(lightShapes[i], 1, GetFloat("lightst")/50)
                    end
                --acender luz do farol
                elseif luz or luzAT then
                    LightShapeUpdate(lightShapes[i], 0.4, GetFloat("lightst")/50)
                end


            elseif typeValue == "5" then
                --acender pisca da dipry[9]ta
                if tagValue == "LFN_R" and di or alerta then
                    if time >= timing then
                        LightShapeUpdate(lightShapes[i], 1, 0.5)
                    end
                --acender pisca da esquerda
                elseif tagValue == "LFN_L" and esq or alerta then
                    if time >= timing then
                        LightShapeUpdate(lightShapes[i], 1, 0.5)
                    end
                --acender fpry[9]o
                elseif brake3 or brake and correntKmh > 2 or brake2 and correntKmh < -20 then
                    if not forceback or brake3 then
                        LightShapeUpdate(lightShapes[i], 1, GetFloat("lightst")/50)
                    end
                end
            end

            

    --luz adicional
        elseif tagValue == "ADN_L" or tagValue == "ADN_R" then
            --acende um luz adicional
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
            
        --luz de re
        elseif tagValue == "BLN_L" or tagValue == "BLN_R" then
            --acende a luz de re
            if forceback or brake and correntKmh < 0 then
                counter=2
                LightShapeUpdate(lightShapes[i], 1, GetFloat("lightst")/50)
            end

    --pisca dipry[9]ro/esquerdo
        elseif tagValue == "PC_R" then
            --acende o pisca dipry[9]to
            if di or alerta then
                if time >= timing then
                    LightShapeUpdate(lightShapes[i], 0.5, GetFloat("lightst")/40)
                else
                    LightShapeUpdate(lightShapes[i], 0, 0)
                end
            end
        --acende o pisca esquerdo
        elseif tagValue == "PC_L" then
            if esq or alerta then
                if time >= timing then
                LightShapeUpdate(lightShapes[i], 0.5, GetFloat("lightst")/40)
                else
                LightShapeUpdate(lightShapes[i], 0, 0)
                end
            end
        end
    end
end



function popupheadlights()
    for i = 1, #lightShapes do
        tagValue = GetTagValue(lightShapes[i], "ALSlight")
        statusValue = GetTagValue(lightShapes[i], "status")
        local hinge = GetShapeJoints(lightShapes[i])
        for u = 1, #hinge do hinges = hinge[u] end

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

        if statusValue == "2" then
            headlight = false
        else
            headlight = true
        end
        
        if lightsOn then
            
            if tagValue == "FFN_L" and not luz and headlight and not apaga2 then
                    if pry[6] > 0 and lights1 or sec[6] > 0 and lights2 or ter[6] > 0 and lights3 then
                        SetTag(lightShapes[i], "UP")
                        SetJointMotorTarget(hinges, GetTagValue(hinges, "popup"), GetTagValue(hinges, "veloc"))
                    else
                        if pry[6] == 0 or sec[6] == 0 or ter[6] == 0 then
                            RemoveTag(lightShapes[i],"UP")
                            SetJointMotorTarget(hinges, 0, GetTagValue(hinges, "veloc"))
                        end
                    end
            elseif tagValue == "FFN_R" and not luz and headlight and not apaga then
                    if pry[6] > 0 and lights1 or sec[6] > 0 and lights2 or ter[6] > 0 and lights3 then
                        SetTag(lightShapes[i], "UP")
                        SetJointMotorTarget(hinges, GetTagValue(hinges, "popup"), GetTagValue(hinges, "veloc"))
                    else
                        if pry[6] == 0 or sec[6] == 0 or ter[6] == 0 then
                            RemoveTag(lightShapes[i],"UP")
                            SetJointMotorTarget(hinges, 0, GetTagValue(hinges, "veloc"))
                        end
                    end
            end
        end

        if luz or luz and luzA or luzAT then
            if tagValue == "FFN_R" or tagValue == "FFN_L" then
                SetJointMotorTarget(hinges, GetTagValue(hinges, "popup"), GetTagValue(hinges, "veloc"))
                SetTag(lightShapes[i], "UP")
            end
        else
            if HasTag(lightShapes[i], "UP") and not lights1 and not lights2 and not lights3 then
                if not luz or not luzA or not luzAT then
                    SetJointMotorTarget(hinges, 0, GetTagValue(hinges, "veloc"))
                    RemoveTag(lightShapes[i], "UP")
                end
            end
        end
    end
end

function EmergencyLights()
    if lightShapesEM ~= empty then
        for i = 1, #lightShapesEM do
            tagValue = GetTagValue(lightShapesEM[i], "ALSem")
            lights = GetShapeLights(lightShapesEM[i])
            local hinge = GetShapeJoints(lightShapesEM[i])
            for u = 1, #hinge do hinges = hinge[u] end
            if IsShapeBroken(lightShapesEM[i]) or IsJointBroken(hinges) then
                Delete(lightShapesEM[i])
            end
            if direcional then
                    if tagValue == "DL_L1" then
                        tagValue = DLE1
                    elseif tagValue == "DL_L2" then
                        tagValue = DLE2
                    elseif tagValue == "DL_L3" then
                        tagValue = DLE3
                    elseif tagValue == "DL_L4" then
                        tagValue = DLE4
                    elseif tagValue == "DL_L5" then
                        tagValue = DLE5
                    elseif tagValue == "DL_R1" then
                        tagValue = DLD1
                    elseif tagValue == "DL_R2" then
                        tagValue = DLD2
                    elseif tagValue == "DL_R3" then
                        tagValue = DLD3
                    elseif tagValue == "DL_R4" then
                        tagValue = DLD4
                    elseif tagValue == "DL_R5" then
                        tagValue = DLD5
                    end
                    LightShapeUpdate(lightShapesEM[i], tagValue, GetFloat("EmLights")/10)
            end

            if lights1 or lights2 or lights3 then
                --frente--
                if tagValue == "FTE_R1" then
                    tagValue = FTD1
                elseif tagValue == "FTE_R2" then
                    tagValue = FTD2
                elseif tagValue == "FTE_L1" then
                    tagValue = FTE1
                elseif tagValue == "FTE_L2" then
                    tagValue = FTE2
                --cima--
                elseif tagValue == "CME_L1" then
                    tagValue = CME1
                elseif tagValue == "CME_L2" then
                    tagValue = CME2
                elseif tagValue == "CME_L3" then
                    tagValue = CME3
                elseif tagValue == "CME_L4" then
                    tagValue = CME4
                elseif tagValue == "CME_L5" then
                    tagValue = CME5
                elseif tagValue == "CME_R1" then
                    tagValue = CMD1
                elseif tagValue == "CME_R2" then
                    tagValue = CMD2
                elseif tagValue == "CME_R3" then
                    tagValue = CMD3
                elseif tagValue == "CME_R4" then
                    tagValue = CMD4
                elseif tagValue == "CME_R5" then
                    tagValue = CMD5
                    -- cima lateral--
                elseif tagValue == "C2E_L1" then
                    tagValue = C2E1
                elseif tagValue == "C2E_L2" then
                    tagValue = C2E2
                elseif tagValue == "C2E_L3" then
                    tagValue = C2E3
                elseif tagValue == "C2E_R1" then
                    tagValue = C2D1
                elseif tagValue == "C2E_R2" then
                    tagValue = C2D2
                elseif tagValue == "C2E_R3" then
                    tagValue = C2D3
                    -- lado--
                elseif tagValue == "LDE_L1" then
                    tagValue = LDE1
                elseif tagValue == "LDE_L2" then
                    tagValue = LDE2
                elseif tagValue == "LDE_L3" then
                    tagValue = LDE3
                elseif tagValue == "LDE_L4" then
                    tagValue = LDE4
                elseif tagValue == "LDE_R1" then
                    tagValue = LDD1
                elseif tagValue == "LDE_R2" then
                    tagValue = LDD2
                elseif tagValue == "LDE_R3" then
                    tagValue = LDD3
                elseif tagValue == "LDE_R4" then
                    tagValue = LDD4
                    -- traz--
                elseif tagValue == "TZE_L1" then
                    tagValue = TZE1
                elseif tagValue == "TZE_L2" then
                    tagValue = TZE2
                elseif tagValue == "TZE_R1" then
                    tagValue = TZD1
                elseif tagValue == "TZE_R2" then
                    tagValue = TZD2
                end
                LightShapeUpdate(lightShapesEM[i], tagValue, GetFloat("EmLights")/5)
            end
        end

        for i = 1, #lightShapes do
            tagValue = GetTagValue(lightShapes[i], "ALSlight")
            lights = GetShapeLights(lightShapes[i])
            statusValue = GetTagValue(lightShapes[i], "status")
            typeValue = GetTagValue(lightShapes[i], "type")
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

            if statusValue == "2" then
                headlight = false
            else
                headlight = true
            end

            if lights1 or lights2 or lights3 then

                if tagValue == "FFN_L" and not luz and headlight and not apaga2 then
                    tagValue = FFE1
                    if HasTag(findvehicle, "UP") then
                        if pry[6] > 0 and lights1 or sec[6] > 0 and lights2 or ter[6] > 0 and lights3 then
                            RemoveTag(lightShapes[i],"DOWN")
                            SetTag(lightShapes[i], "UP")
                        else
                            if pry[6] == 0 or sec[6] == 0 or ter[6] == 0 then
                                RemoveTag(lightShapes[i],"UP")
                                SetTag(lightShapes[i], "DOWN")
                            end
                        end
                    end
                    for j = 1, #lights do
                        if GetTagValue(lights[j], "type") == "2" then
                            SetLightIntensity(lights[j], 0)
                        else
                            SetLightIntensity(lights[j], GetFloat("lightsf")/5)
                        end
                    end
                elseif tagValue == "FFN_R" and not luz and headlight and not apaga then
                    tagValue = FFD1
                    if HasTag(findvehicle, "UP") then
                        if pry[6] > 0 and lights1 or sec[6] > 0 and lights2 or ter[6] > 0 and lights3 then
                            RemoveTag(lightShapes[i],"DOWN")
                            SetTag(lightShapes[i], "UP")
                        else
                            if pry[6] == 0 or sec[6] == 0 or ter[6] == 0 then
                                RemoveTag(lightShapes[i],"UP")
                                SetTag(lightShapes[i], "DOWN")
                            end
                        end
                    end
                    for j = 1, #lights do             
                        if GetTagValue(lights[j], "type") == "2" then
                            SetLightIntensity(lights[j], 0)
                        else
                            SetLightIntensity(lights[j], GetFloat("lightsf")/5)
                        end
                    end
                    -- traz luz--
                elseif tagValue == "LTN_L" and not luz and headlight then
                    if typeValue == "1" or not blinker and typeValue == "2" then
                        tagValue = LTE1
                        LightShapeUpdate(0, 0, GetFloat("lightst")/50)
                    end
                elseif tagValue == "LTN_R" and not luz and headlight then
                    if typeValue == "1" or not blinker and typeValue == "2" then
                        tagValue = LTD1
                        LightShapeUpdate(0, 0, GetFloat("lightst")/50)
                    end
                    -- fpry[9]o--
                elseif tagValue == "LFN_L" and headlight then
                    if typeValue == "1" or typeValue == "4" or not blinker and typeValue == "2" or not blinker and typeValue == "3" then
                        tagValue = LFE1
                        LightShapeUpdate(0, 0, GetFloat("lightst")/50)
                    end
                elseif tagValue == "LFN_R" and headlight then
                    if typeValue == "1" or typeValue == "4" or not blinker and typeValue == "2" or not blinker and typeValue == "3" then
                        tagValue = LFD1
                        LightShapeUpdate(0, 0, GetFloat("lightst")/50)
                    end
                elseif tagValue == "BLN_R" and headlight then
                    tagValue = BLD1
                    LightShapeUpdate(0, 0, GetFloat("lightst")/50)
                elseif tagValue == "BLN_L" and headlight then
                    tagValue = BLE1
                    LightShapeUpdate(0, 0, GetFloat("lightst")/50)
                elseif tagValue == "ADN_L" and headlight then
                    tagValue = C2E1
                    for j = 1, #lights do
                        if GetTagValue(lights[j], "type") == "1" then
                            SetLightIntensity(lights[j], GetFloat("lightsf"))
                        end
                        if GetTagValue(lights[j], "type") == "2" then
                            SetLightIntensity(lights[j], GetFloat("lightst"))  
                        end
                    end
                elseif tagValue == "ADN_R" and headlight then
                    tagValue = C2D1
                    for j = 1, #lights do
                        if GetTagValue(lights[j], "type") == "1" then
                            SetLightIntensity(lights[j], GetFloat("lightsf"))
                        end
                        if GetTagValue(lights[j], "type") == "2" then
                            SetLightIntensity(lights[j], GetFloat("lightst"))  
                        end
                    end
                end
                SetShapeEmissiveScale(lightShapes[i], tagValue)
            end
        end
    end
end

--fix this
function giroflexemergencia()
    for i = 1, #GiroflexLight do
        tagValue = GetTagValue(GiroflexLight[i], "ALSGF")
        lights = GetShapeLights(GiroflexLight[i])

        local hinge = GetShapeJoints(GiroflexLight[i])
        for u = 1, #hinge do hinges = hinge[u] end
        if lights1 or lights2 or lights3 then
            -- giroflex--
            if tagValue == "GFE" or tagValue == "GFEOFF" then
                LightShapeUpdate(GiroflexLight[i], 1, GetFloat("EmLights")/5)
                SetJointMotor(hinges, GetTagValue(hinges, "giroflex"))
                SetTag(GiroflexLight[i], "ALSGF", "GFEOFF")
            end
        end
        if not lights1 and not lights2 and not lights3 then
            if tagValue == "GFEOFF" then
                LightShapeUpdate(GiroflexLight[i], 0, 0)
                SetJointMotor(hinges, 0, 0)
                SetJointMotorTarget(hinges, 0)
                SetTag(GiroflexLight[i], "ALSGF", "GFE")
            end
        end
    end
end

function draw()
    if not close then
        if GetBool("level.ALS.enabled") and not close then
            close=true
        end
    if GetPlayerVehicle() == ALSVehicle then
        if InputPressed("esc")then
            close=true
        end
            SetBool("game.disablepause", true)
        UiPush()
            local w = UiWidth()
            local h = UiHeight()
            UiTranslate(w-20, h/1.5)
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



--fix this execute only one time every time the mode changes
function lightsOptions()
    if lights1 then

        for i=1, #pry do
            em[i]=pry[i]
        end


    elseif lights2 then
            for i=1, #sec do
                em[i]=sec[i]
            end

    elseif lights3 then
            for i=1, #ter do
                em[i]=ter[i]
            end
        end


        lightsPatter()
end

--fix this
function lightsPatter()
    if em[1] ==0 then 
        FTE1 = 0        FTD1 = 0
        FTE2 = 0        FTD2 = 0
        elseif em[1] ==1 then
        FTE1 = a1        FTD1 = a2
        FTE2 = a1        FTD2 = a2
        elseif em[1]==2 then
        FTE1 = a1        FTD1 = a2
        FTE2 = a2        FTD2 = a1
        elseif em[1]==3 then
        FTE1 = a3        FTD1 = a4
        FTE2 = a2        FTD2 = a1
        elseif em[1]==4 then
        FTE1 = a1        FTD1 = a2
        FTE2 = a3        FTD2 = a4
        elseif em[1]==5 then
        FTE1 = a3        FTD1 = a4
        FTE2 = a4        FTD2 = a3
        end

        if em[2]==0 then
        CMD1 = 0        CME1 = 0
        CMD2 = 0        CME2 = 0
        CMD3 = 0        CME3 = 0
        CMD4 = 0        CME4 = 0
        CMD5 = 0        CME5 = 0
        elseif em[2]==1 then
        CMD1 = a1       CME1 = a2
        CMD2 = 0        CME2 = 0
        CMD3 = 0        CME3 = 0
        CMD4 = 0        CME4 = 0
        CMD5 = a1       CME5 = a2
        elseif em[2]==2 then
        CMD1 = a1       CME1 = a2
        CMD2 = a1       CME2 = a2
        CMD3 = a1       CME3 = a2
        CMD4 = a1       CME4 = a2
        CMD5 = a1       CME5 = a2
        elseif em[2]==3 then
        CMD1 = a3       CME1 = a4
        CMD2 = a3       CME2 = a4
        CMD3 = a3       CME3 = a4
        CMD4 = a3       CME4 = a4
        CMD5 = a3       CME5 = a4
        elseif em[2]==4 then
        CMD1 = a3       CME1 = a4
        CMD2 = a4       CME2 = a3
        CMD3 = a3       CME3 = a4
        CMD4 = a4       CME4 = a3
        CMD5 = a3       CME5 = a4
        elseif em[2]==5 then 
        CMD1 = a3       CME1 = a4
        CMD2 = a1       CME2 = a2
        CMD3 = a6       CME3 = a5
        CMD4 = a4       CME4 = a3
        CMD5 = a5       CME5 = a6  
        end

        if em[3]==0 then
        C2D1 = 0        C2E1 = 0
        C2D2 = 0        C2E2 = 0
        C2D3 = 0        C2E3 = 0
        elseif em[3]==1 then
        C2D1 = a2       C2E1 = a1
        C2D2 = a2       C2E2 = a1
        C2D3 = a2       C2E3 = a1
        elseif em[3]==2 then
        C2D1 = a3        C2E1 = a4
        C2D2 = a3        C2E2 = a4
        C2D3 = a3        C2E3 = a4
        elseif em[3]==3 then
        C2D1 = a5        C2E1 = a6
        C2D2 = a5        C2E2 = a6
        C2D3 = a5        C2E3 = a6
        elseif em[3]==4 then
        C2D1 = a4        C2E1 = a3
        C2D2 = a3        C2E2 = a4
        C2D3 = a4        C2E3 = a3
        elseif em[3]==5 then
        C2D1 = a1        C2E1 = a1
        C2D2 = a3        C2E2 = a3
        C2D3 = a1        C2E3 = a1
        end

        if em[4]==0 then
        LDD1 = 0        LDE1 = 0
        LDD2 = 0        LDE2 = 0
        LDD3 = 0        LDE3 = 0
        LDD4 = 0        LDE4 = 0
        elseif em[4]==1 then
        LDD1 = a2       LDE1 = a1
        LDD2 = a1       LDE2 = a2
        LDD3 = a1       LDE3 = a2
        LDD4 = a2       LDE4 = a1
        elseif em[4]==2 then
        LDD1 = a3       LDE1 = a4
        LDD2 = a4       LDE2 = a3
        LDD3 = a4       LDE3 = a3
        LDD4 = a3       LDE4 = a4
        elseif em[4]==3 then
        LDD1 = a1       LDE1 = a1
        LDD2 = a2       LDE2 = a2
        LDD3 = a2       LDE3 = a2
        LDD4 = a1       LDE4 = a1
        elseif em[4]==4 then
        LDD1 = a3       LDE1 = a4
        LDD2 = a5       LDE2 = a6
        LDD3 = a6       LDE3 = a5
        LDD4 = a4       LDE4 = a3
        elseif em[4]==5 then
        LDD1 = a6       LDE1 = a5
        LDD2 = a5       LDE2 = a6
        LDD3 = a5       LDE3 = a6
        LDD4 = a6       LDE4 = a5
        end

        if em[5]==0 then
        TZD1 = 0        TZE1 = 0
        TZD2 = 0        TZE2 = 0
        elseif em[5]==1 then
        TZD1 = a1       TZE1 = a2
        TZD2 = a1       TZE2 = a2
        elseif em[5]==2 then
        TZD1 = a2       TZE1 = a1
        TZD2 = a1       TZE2 = a2
        elseif em[5]==3 then
        TZD1 = a1       TZE1 = a2
        TZD2 = a2       TZE2 = a1
        elseif em[5]==4 then
        TZD1 = a3       TZE1 = a4
        TZD2 = a3       TZE2 = a4
        elseif em[5]==5 then
        TZD1 = a3       TZE1 = a4
        TZD2 = a4       TZE2 = a3
        end

        if em[6]==0 then
        FFD1 = 0        FFE1 = 0
        elseif em[6]==1 then
        FFD1 = a1       FFE1 = a2
        elseif em[6]==2 then
        FFD1 = a3       FFE1 = a4
        elseif em[6]==3 then
        FFD1 = a5       FFE1 = a6
        elseif em[6]==4 then
        FFD1 = a2       FFE1 = a1
        elseif em[6]==5 then
        FFD1 = a4       FFE1 = a3
        end

        if em[7]==0 then
        LTD1 = 0        LTE1 = 0
        elseif em[7]==1 then
        LTD1 = a1       LTE1 = a2
        elseif em[7]==2 then
        LTD1 = a3       LTE1 = a4
        elseif em[7]==3 then
        LTD1 = a5       LTE1 = a6
        elseif em[7]==4 then
        LTD1 = a2       LTE1 = a1
        elseif em[7]==5 then
        LTD1 = a4       LTE1 = a3
        end

        if em[8]==0 then
        LFD1 = 0        LFE1 = 0
        elseif em[8]==1 then
        LFD1 = a1        LFE1 = a2
        elseif em[8]==2 then
        LFD1 = a3        LFE1 = a4
        elseif em[8]==3 then
        LFD1 = a5        LFE1 = a6
        elseif em[8]==4 then
        LFD1 = a2        LFE1 = a1
        elseif em[8]==5 then
        LFD1 = a4        LFE1 = a3
        end

        if em[9]==0 then
        BLD1 = 0        BLE1 = 0
        elseif em[9]==1 then
        BLD1 = a1       BLE1 = a2
        elseif em[9]==2 then
        BLD1 = a2       BLE1 = a1
        elseif em[9]==3 then
        BLD1 = a1       BLE1 = a2
        elseif em[9]==4 then
        BLD1 = a3       BLE1 = a4
        elseif em[9]==5 then
        BLD1 = a3       BLE1 = a4
        end
        if GetTagValue(ALSVehicle, "directional")=="0" then
        DLD1 = 0        DLE1 = 0
        DLD2 = 0        DLE2 = 0
        DLD3 = 0        DLE3 = 0
        DLD4 = 0        DLE4 = 0
        DLD5 = 0        DLE5 = 0
        elseif GetTagValue(ALSVehicle, "directional")=="1" then
        DLD1 = b1       DLE1 = b10
        DLD2 = b2       DLE2 = b9
        DLD3 = b3       DLE3 = b8
        DLD4 = b4       DLE4 = b7
        DLD5 = b5       DLE5 = b6
        elseif GetTagValue(ALSVehicle, "directional")=="2" then
        DLD1 = b10      DLE1 = b1
        DLD2 = b9       DLE2 = b2
        DLD3 = b8       DLE3 = b3
        DLD4 = b7       DLE4 = b4
        DLD5 = b6       DLE5 = b5
        elseif GetTagValue(ALSVehicle, "directional")=="3" then
        DLD1 = a1       DLE1 = a2
        DLD2 = a1       DLE2 = a2
        DLD3 = a1       DLE3 = a2
        DLD4 = a1       DLE4 = a2
        DLD5 = a1       DLE5 = a2
        elseif GetTagValue(ALSVehicle, "directional")=="4" then
        DLD1 = a1       DLE1 = a1
        DLD2 = a1       DLE2 = a1
        DLD3 = a1       DLE3 = a1
        DLD4 = a2       DLE4 = a2
        DLD5 = a2       DLE5 = a2
        elseif GetTagValue(ALSVehicle, "directional")=="5" then
        DLD1 = a4       DLE1 = a4
        DLD2 = a6       DLE2 = a6
        DLD3 = a1       DLE3 = a1
        DLD4 = a2       DLE4 = a2
        DLD5 = a3       DLE5 = a3
        end

end







--fix this /create permutation/
function patter(t)

    if t == 0 then
        a1 = 1 a2= 0
        a3 = 1 a4 = 0
        a5 = 1 a6 = 0
        b1 = 1
        EmergencyLights()
    end
    if t == 5 then
        b2 = 1
        a3 = 0
        EmergencyLights()
    end
    if t == 10 then
        a5 = 0 a6 = 1
        b1 = 0
        b3 = 1
        a3 = 1
        EmergencyLights()
    end
    if t == 15 then
        a1 = 0 a2= 1
        a3 = 0
        b2 = 0
        b4 = 1
        EmergencyLights()
    end
    if t == 20 then
        a5 = 1 a6 = 0
        b3 = 0
        b5 = 1
        a3 = 1
        EmergencyLights()
    end
    if t == 25 then
        b4 = 0
        b6 = 1
        EmergencyLights()
    end
    if t == 30 then
        a1 = 1 a2= 0
        a3 = 0 a4= 1
        a5 = 0 a6 = 1
        b5 = 0
        b7 = 1
        EmergencyLights()
    end
    if t == 35 then
        a4= 0
        b6 = 0
        b8 = 1
        EmergencyLights()
    end
    if t == 40 then
        a5 = 1 a6 = 0
        a4= 1
        b7 = 0
        b9 = 1
        EmergencyLights()
    end
    if t == 45 then
        a4= 0
        a1 = 0 a2= 1
        b8 = 0
        b10 = 1
        EmergencyLights()
    end
    if t == 50 then
        a5 = 0 a6 = 1
        a4= 1
        b9 = 0
        EmergencyLights()
    end
    if t == 55 then
        b10 = 0
        EmergencyLights()
    end
    if t == 60 then
        a1= 1 a2= 0
        a3= 1 a4= 0
        a5 = 1 a6 = 0
        EmergencyLights()
    end
    if t == 65 then
        a3= 0
        EmergencyLights()
    end
    if t == 70 then
        a5 = 0 a6 = 1
        a3= 1
        EmergencyLights()
    end
    if t == 75 then
        a1 = 0 a2= 1
        a3= 0
        EmergencyLights()
    end
    if t == 80 then
        a5 = 1 a6 = 0
        a3= 1
        EmergencyLights()
    end
    if t == 85 then
        EmergencyLights()
    end
    if t == 90 then
        a1 = 1 a2= 0
        a3= 0  a4= 1
        a5 = 0 a6 = 1
        EmergencyLights()
    end
    if t == 95 then
        a4= 0
        EmergencyLights()
    end
    if t == 100 then
        a5 = 1 a6 = 0
        a4= 1
        EmergencyLights()
    end
    if t == 105 then
        a4= 0
        a1 = 0 a2= 1
        EmergencyLights()
    end
    if t == 110 then
        a5 = 0 a6 = 1
        a4= 1
        EmergencyLights()
    end
    if t == 115 then
        EmergencyLights()
    end
    if t == 119 then
        EmergencyLights()
    end
end
