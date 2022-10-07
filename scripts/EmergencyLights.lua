function init()
    lightShapes = FindShapes("ALSem")
    lightShapesN = FindShapes("ALSlight")
    findvehicle = FindShape("ALShorn")
    frame = 0
    click = LoadSound("sound/click.ogg")
    direcu=1

    frentei=2   frenteo=3   frentep=5
    cimai=1     cimao=2     cimap=5
    cima2i=0    cima2o=1    cima2p=4
    ladoi=1     ladoo=2     ladop=5
    trazi=1     trazo=2     trazp=4
    frenteli=0  frentelo=4  frentelp=5
    trazli=0    trazlo=1    trazlp=2
    trazfi=0    trazfo=1    trazfp=5
    rei=0       reo=1        rep=5

end
function update(dt)
    
        lights1 = GetTagValue(findvehicle, "em") == "1"
        lights2 = GetTagValue(findvehicle, "em") == "2"
        lights3 = GetTagValue(findvehicle, "em") == "3"
        direcional = GetTagValue(findvehicle, "di") == "1"
        di = GetTagValue(findvehicle, "p") == "1"
        esq = GetTagValue(findvehicle, "p") == "2"
        ad = GetTagValue(findvehicle, "ad") == "1"
                
        if not HasTag(findvehicle, "active") then
            for i = 1, #lightShapes do
                SetShapeEmissiveScale(lightShapes[i], 0)
            end
        end

        if lights1 or lights2 or lights3 or direcional then
            frame = frame + dt*60
            local period = 120
            local t = math.ceil(frame) % period
            patter(t)
            if frame > 120 then
                frame = 0
            end
        else
            for i = 1, #lightShapes do
                SetShapeEmissiveScale(lightShapes[i], 0)
            end
        end
        if not lights1 and not lights2 and not lights3 then
            for i = 1, #lightShapesN do
                SetShapeEmissiveScale(lightShapesN[i], 0)
            end
        end

        if HasTag(findvehicle, "GF") then giroflexemergencia() end
end

function EmergencyLights()
    if lightShapes ~= empty and HasTag(findvehicle, "active") then
        for i = 1, #lightShapes do
            tagValue = GetTagValue(lightShapes[i], "ALSem")
            lights = GetShapeLights(lightShapes[i])
            local hinge = GetShapeJoints(lightShapes[i])
            for u = 1, #hinge do hinges = hinge[u] end
            if IsShapeBroken(lightShapes[i]) or IsJointBroken(hinges) then
                Delete(lightShapes[i])
            end
            if direcional then
                    for j = 1, #lights do
                        SetLightIntensity(lights[j], GetFloat("EmLights")/10)
                    end
                    if tagValue == "DL_E1" then
                        tagValue = DLE1
                    elseif tagValue == "DL_E2" then
                        tagValue = DLE2
                    elseif tagValue == "DL_E3" then
                        tagValue = DLE3
                    elseif tagValue == "DL_E4" then
                        tagValue = DLE4
                    elseif tagValue == "DL_E5" then
                        tagValue = DLE5
                    elseif tagValue == "DL_D1" then
                        tagValue = DLD1
                    elseif tagValue == "DL_D2" then
                        tagValue = DLD2
                    elseif tagValue == "DL_D3" then
                        tagValue = DLD3
                    elseif tagValue == "DL_D4" then
                        tagValue = DLD4
                    elseif tagValue == "DL_D5" then
                        tagValue = DLD5
                    end
                SetShapeEmissiveScale(lightShapes[i], tagValue)
            end

            if lights1 or lights2 or lights3 then
                for j = 1, #lights do
                    SetLightIntensity(lights[j], GetFloat("EmLights")/5)
                end
                --frente--
                if tagValue == "FTE_D1" then
                    tagValue = FTD1
                elseif tagValue == "FTE_D2" then
                    tagValue = FTD2
                elseif tagValue == "FTE_E1" then
                    tagValue = FTE1
                elseif tagValue == "FTE_E2" then
                    tagValue = FTE2
                --cima--
                elseif tagValue == "CME_E1" then
                    tagValue = CME1
                elseif tagValue == "CME_E2" then
                    tagValue = CME2
                elseif tagValue == "CME_E3" then
                    tagValue = CME3
                elseif tagValue == "CME_E4" then
                    tagValue = CME4
                elseif tagValue == "CME_E5" then
                    tagValue = CME5
                elseif tagValue == "CME_D1" then
                    tagValue = CMD1
                elseif tagValue == "CME_D2" then
                    tagValue = CMD2
                elseif tagValue == "CME_D3" then
                    tagValue = CMD3
                elseif tagValue == "CME_D4" then
                    tagValue = CMD4
                elseif tagValue == "CME_D5" then
                    tagValue = CMD5
                    -- cima lateral--
                elseif tagValue == "C2E_E1" then
                    tagValue = C2E1
                elseif tagValue == "C2E_E2" then
                    tagValue = C2E2
                elseif tagValue == "C2E_E3" then
                    tagValue = C2E3
                elseif tagValue == "C2E_D1" then
                    tagValue = C2D1
                elseif tagValue == "C2E_D2" then
                    tagValue = C2D2
                elseif tagValue == "C2E_D3" then
                    tagValue = C2D3
                    -- lado--
                elseif tagValue == "LDE_E1" then
                    tagValue = LDE1
                elseif tagValue == "LDE_E2" then
                    tagValue = LDE2
                elseif tagValue == "LDE_E3" then
                    tagValue = LDE3
                elseif tagValue == "LDE_E4" then
                    tagValue = LDE4
                elseif tagValue == "LDE_D1" then
                    tagValue = LDD1
                elseif tagValue == "LDE_D2" then
                    tagValue = LDD2
                elseif tagValue == "LDE_D3" then
                    tagValue = LDD3
                elseif tagValue == "LDE_D4" then
                    tagValue = LDD4
                    -- traz--
                elseif tagValue == "TZE_E1" then
                    tagValue = TZE1
                elseif tagValue == "TZE_E2" then
                    tagValue = TZE2
                elseif tagValue == "TZE_D1" then
                    tagValue = TZD1
                elseif tagValue == "TZE_D2" then
                    tagValue = TZD2
                end
                SetShapeEmissiveScale(lightShapes[i], tagValue)
            end
        end

        for i = 1, #lightShapesN do
            tagValue = GetTagValue(lightShapesN[i], "ALSlight")
            lights = GetShapeLights(lightShapesN[i])
            statusValue = GetTagValue(lightShapesN[i], "status")
            local hinge = GetShapeJoints(lightShapesN[i])
            for u = 1, #hinge do hinges = hinge[u] end
            if IsShapeBroken(lightShapesN[i]) or IsJointBroken(hinges) then
                Delete(lightShapesN[i])
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

                if tagValue == "FFN_E" and not luz and headlight and not apaga2 then
                    tagValue = FFE1
                    if HasTag(findvehicle, "UP") then
                        if frenteli > 0 and lights1 or frentelo > 0 and lights2 or frentelp > 0 and lights3 then
                            RemoveTag(lightShapesN[i],"DOWN")
                            SetTag(lightShapesN[i], "UP")
                        else
                            if frenteli == 0 or frentelo == 0 or frentelp == 0 then
                                RemoveTag(lightShapesN[i],"UP")
                                SetTag(lightShapesN[i], "DOWN")
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
                elseif tagValue == "FFN_D" and not luz and headlight and not apaga then
                    tagValue = FFD1
                    if HasTag(findvehicle, "UP") then
                        if frenteli > 0 and lights1 or frentelo > 0 and lights2 or frentelp > 0 and lights3 then
                            RemoveTag(lightShapesN[i],"DOWN")
                            SetTag(lightShapesN[i], "UP")
                        else
                            if frenteli == 0 or frentelo == 0 or frentelp == 0 then
                                RemoveTag(lightShapesN[i],"UP")
                                SetTag(lightShapesN[i], "DOWN")
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
                elseif tagValue == "LTN_E" and not luz and headlight then
                    tagValue = LTE1
                    for j = 1, #lights do
                        SetLightIntensity(lights[j], GetFloat("lightst")/50)
                    end
                elseif tagValue == "LTN_D" and not luz and headlight then
                    tagValue = LTD1
                    for j = 1, #lights do
                        SetLightIntensity(lights[j], GetFloat("lightst")/50)
                    end
                    -- freio--
                elseif tagValue == "LFN_E" and headlight then
                    tagValue = LFE1
                    for j = 1, #lights do
                        SetLightIntensity(lights[j], GetFloat("lightst")/50)
                    end
                elseif tagValue == "LFN_D" and headlight then
                    tagValue = LFD1
                    for j = 1, #lights do
                        SetLightIntensity(lights[j], GetFloat("lightst")/50)
                    end
                elseif tagValue == "BLN_D" and headlight then
                    tagValue = BLD1
                    for j = 1, #lights do
                        SetLightIntensity(lights[j], GetFloat("lightst")/50)
                    end
                elseif tagValue == "BLN_E" and headlight then
                    tagValue = BLE1
                    for j = 1, #lights do
                        SetLightIntensity(lights[j], GetFloat("lightst")/50)
                    end
                elseif tagValue == "ADN_E" and headlight then
                    tagValue = C2E1
                    for j = 1, #lights do
                        if GetTagValue(lights[j], "type") == "1" then
                            SetLightIntensity(lights[j], GetFloat("lightsf"))
                        end
                        if GetTagValue(lights[j], "type") == "2" then
                            SetLightIntensity(lights[j], GetFloat("lightst"))  
                        end
                    end
                elseif tagValue == "ADN_D" and headlight then
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
                SetShapeEmissiveScale(lightShapesN[i], tagValue)
            end
        end
    end
end

function giroflexemergencia()
    for i = 1, #lightShapes do
        tagValue = GetTagValue(lightShapes[i], "ALSem")
        lights = GetShapeLights(lightShapes[i])

        local hinge = GetShapeJoints(lightShapes[i])
        for u = 1, #hinge do hinges = hinge[u] end
        if lights1 or lights2 or lights3 then
            -- giroflex--
            if tagValue == "GFE" or tagValue == "GFEOFF" then
                SetShapeEmissiveScale(lightShapes[i], 1)
                for j = 1, #lights do
                    SetLightIntensity(lights[j], GetFloat("EmLights")/5)
                end
                SetJointMotor(hinges, GetTagValue(hinges, "giroflex"), 25)
                SetTag(lightShapes[i], "ALSem", "GFEOFF")
            end
        end
        if not lights1 and not lights2 and not lights3 then
            if tagValue == "GFEOFF" then
                SetShapeEmissiveScale(lightShapes[i], 0)
                for j = 1, #lights do
                    SetLightIntensity(lights[j], 0)
                end
                SetJointMotor(hinges, 0, 0)
                SetJointMotorTarget(hinges, 0)
                SetTag(lightShapes[i], "ALSem", "GFE")
            end
        end
    end
end

function draw()
    if not deleted then
        lightsOptions()
        if GetPlayerVehicle() == GetBodyVehicle(GetShapeBody(findvehicle)) then
            if InputPressed(GetString("emergency.menu")) then
                visible = not visible
            end
            if visible then
                SetBool("game.disablepause", true)
                SetBool("game.disablemap", true)	
                drawOptions()
            end
        end
    end
end

function drawOptions()
    if InputPressed("rmb") then
        movecamera=not movecamera
    end
    if not movecamera then
    UiMakeInteractive()
    end

    local w = UiWidth()
    local h = UiHeight()
    UiTranslate(w,h/2)
    UiScale(0.7,0.7)



    UiPush()
    UiAlign("right middle")
    UiImage("MOD/images/Interface.png")
    UiPush()   
    UiTranslate(-180, -420)
    UiColor(1, 1, 1)
    UiFont("regular.ttf", 40)
    if not movecamera then
    UiText("Right click to move the camera")
    else
    UiText("Right click to go back to edit")
    end
    UiPop()

    UiPush()
    UiColor(1, 1, 1)
    UiButtonImageBox("MOD/images/box-buttons.png", 6, 6, 1, 0.3, 0.3, 0.9)
    UiTranslate(-70, 430)

    UiColor(1, 1, 1)
    UiFont("bold.ttf", 40)
    close = UiTextButton("CLOSE", 600, 60)

    if close or InputPressed("esc") then visible = false end
    UiPop()
    --FFN
        UiPush()
            UiPush()
            if lights1 or lights2 or lights3 then
                if frentel > 0 then
            UiTranslate(-686.5,-205)
            UiImageBox("MOD/images/box-lights.png", 90, 40, 10, 10)
                end
            end
            UiPop()
            UiTranslate(-737,-251)
            somar = DrawButtons(somar, "<", 40, 30, 2, 40, 0, 0, 0, frentel, "FFN")
            if somar then
                atualizar=true
            frentel = frentel-1
                if frentel < 0 then
                    frentel=5
                end
            end
            UiTranslate(50,0)
            subtrair = DrawButtons(subtrair, ">", 40, 30, 2, 40, 0, 0, 0)
            if subtrair then
                atualizar=true
            frentel = frentel+1
                if frentel > 5 then
                    frentel=0
                end
            end
        UiPop()
    --CME
        UiPush()
            UiTranslate(0,160)
            UiPush()
            if lights1 or lights2 or lights3 then
                if cima > 0 then
            UiTranslate(-686.5,-205)
            UiImageBox("MOD/images/box-lights.png", 90, 40, 10, 10)
                end
            end
            UiPop()
            UiTranslate(-737,-251)
            somar = DrawButtons(somar, "<", 40, 30, 2, 40, 0, 0, 0, cima, "CME")
            if somar then
                atualizar=true
            cima = cima-1
                if cima < 0 then
                    cima=5
                end
            end
            UiTranslate(50,0)
            subtrair = DrawButtons(subtrair, ">", 40, 30, 2, 40, 0, 0, 0)
            if subtrair then
                atualizar=true
            cima = cima+1
                if cima > 5 then
                    cima=0
                end
            end
        UiPop()
    --LTN
        UiPush()
            UiTranslate(0,320)
            UiPush()
            if lights1 or lights2 or lights3 then
                if trazl > 0 then
            UiTranslate(-686.5,-205)
            UiImageBox("MOD/images/box-lights.png", 90, 40, 10, 10)
                end
            end
            UiPop()
            UiTranslate(-737,-251)
            somar = DrawButtons(somar, "<", 40, 30, 2, 40, 0, 0, 0, trazl, "LTN")
            if somar then
                atualizar=true
            trazl = trazl-1
                if trazl < 0 then
                    trazl=5
                end
            end
            UiTranslate(50,0)
            subtrair = DrawButtons(subtrair, ">", 40, 30, 2, 40, 0, 0, 0)
            if subtrair then
                atualizar=true
            trazl = trazl+1
                if trazl > 5 then
                    trazl=0
                end
            end
        UiPop()

    --SIRENE
        UiPush()
            UiTranslate(0,480)
            UiPush()
                if HasTag(findvehicle, "ALSsiren1") or HasTag(findvehicle, "ALSsiren2") or HasTag(findvehicle, "ALSsiren3") or HasTag(findvehicle, "ALSsiren4") or HasTag(findvehicle, "Yell") then
            UiTranslate(-686.5,-205)
            UiImageBox("MOD/images/box-lights.png", 90, 40, 10, 10)
                end
            UiPop()
            UiColor(0,0,0)
            UiTranslate(-694,-205)
            UiFont("regular.ttf", 30)
            UiText("SIREN")
            UiColor(1,1,1)
            UiTranslate(5,50)
            if not HasTag(findvehicle, "Yell") then
                if HasTag(findvehicle, "ALSsiren1") then
                UiTranslate(-10,0)
                UiText("WAIL")
                elseif HasTag(findvehicle, "ALSsiren2") then
                UiTranslate(-15,0)
                UiText("YELP")
                elseif HasTag(findvehicle, "ALSsiren3") then
                UiTranslate(-12,0)
                UiText("PRTY")
                elseif HasTag(findvehicle, "ALSsiren4") then
                UiTranslate(-15,0)
                UiText("HILO")
                else
                UiTranslate(-25,0)
                UiText("----")    
                end   
            end
            if HasTag(findvehicle, "Yell") then
                if HasTag(findvehicle, "ALSsiren1") then
                UiTranslate(-10,0)
                UiText("YELP")
                elseif HasTag(findvehicle, "ALSsiren2") then
                UiTranslate(-15,0)
                UiText("PRTY")
                elseif HasTag(findvehicle, "ALSsiren3") then
                UiTranslate(-12,0)
                UiText("HILO")
                elseif HasTag(findvehicle, "ALSsiren4") then
                UiTranslate(-25,0)
                UiText("----")
                else
                    UiTranslate(-5,0)
                    UiText("TEMP")
                end 
            end

        UiPop()

        UiTranslate(109,0)
    --FTE
        UiPush()
            UiPush()
            if lights1 or lights2 or lights3 then
                if frente > 0 then
            UiTranslate(-686.5,-205)
            UiImageBox("MOD/images/box-lights.png", 90, 40, 10, 10)
                end
            end
            UiPop()
            UiTranslate(-737,-251)
            somar = DrawButtons(somar, "<", 40, 30, 2, 40, 0, 0, 0, frente, "FTE")
            if somar then
                atualizar=true
            frente = frente-1
                if frente < 0 then
                    frente=5
                end
            end
            UiTranslate(50,0)
            subtrair = DrawButtons(subtrair, ">", 40, 30, 2, 40, 0, 0, 0)
            if subtrair then
                atualizar=true
            frente = frente+1
                if frente > 5 then
                    frente=0
                end
            end
        UiPop()

    --CM2
        UiPush()
            UiTranslate(0,160)
            UiPush()
            if lights1 or lights2 or lights3 then
                if cima2 > 0 then
            UiTranslate(-686.5,-205)
            UiImageBox("MOD/images/box-lights.png", 90, 40, 10, 10)
                end
            end
            UiPop()
            UiTranslate(-737,-251)
            somar = DrawButtons(somar, "<", 40, 30, 2, 40, 0, 0, 0, cima2, "CM2")
            if somar then
                atualizar=true
            cima2 = cima2-1
                if cima2 < 0 then
                    cima2=5
                end
            end
            UiTranslate(50,0)
            subtrair = DrawButtons(subtrair, ">", 40, 30, 2, 40, 0, 0, 0)
            if subtrair then
                atualizar=true
            cima2 = cima2+1
                if cima2 > 5 then
                    cima2=0
                end
            end
        UiPop()

    --LFN
        UiPush()
            UiTranslate(0,320)
            UiPush()
            if lights1 or lights2 or lights3 then
                if trazf > 0 then
            UiTranslate(-686.5,-205)
            UiImageBox("MOD/images/box-lights.png", 90, 40, 10, 10)
                end
            end
            UiPop()
            UiTranslate(-737,-251)
            somar = DrawButtons(somar, "<", 40, 30, 2, 40, 0, 0, 0, trazf, "LFN")
            if somar then
                atualizar=true
            trazf = trazf-1
                if trazf < 0 then
                    trazf=5
                end
            end
            UiTranslate(50,0)
            subtrair = DrawButtons(subtrair, ">", 40, 30, 2, 40, 0, 0, 0)
            if subtrair then
                atualizar=true
            trazf = trazf+1
                if trazf > 5 then
                    trazf=0
                end
            end
        UiPop()


    --LUZEXTRA/BUZINA
        UiPush()
            UiTranslate(-686.5,275)
            UiPush()
                if ad then
                    UiImageBox("MOD/images/box-lights.png", 90, 40, 10, 10)
                end
                UiColor(0,0,0)
                UiTranslate(-7.5,0)
                UiFont("regular.ttf", 30)
                UiText("LAMP")
            UiPop()
            UiTranslate(0,51)            
            UiPush()
            if HasTag(findvehicle, "Horn") then
                UiImageBox("MOD/images/box-lights.png", 90, 40, 10, 10)
            end
            UiColor(0,0,0)
            UiTranslate(-7.5,0)
            UiFont("regular.ttf", 30)
            UiText("HORN")
            UiPop()


        UiPop()

        UiTranslate(111,0)

    --LDE
        UiPush()
            UiPush()
            if lights1 or lights2 or lights3 then
                if lado > 0 then
            UiTranslate(-686.5,-205)
            UiImageBox("MOD/images/box-lights.png", 90, 40, 10, 10)
                end
            end
            UiPop()
            UiTranslate(-737,-251)
            somar = DrawButtons(somar, "<", 40, 30, 2, 40, 0, 0, 0, lado, "LDE")
            if somar then
                atualizar=true
            lado = lado-1
                if lado < 0 then
                    lado=5
                end
            end
            UiTranslate(50,0)
            subtrair = DrawButtons(subtrair, ">", 40, 30, 2, 40, 0, 0, 0)
            if subtrair then
                atualizar=true
            lado = lado+1
                if lado > 5 then
                    lado=0
                end
            end
        UiPop()

    --TZE
        UiPush()
            UiTranslate(0,160)
            UiPush()
            if lights1 or lights2 or lights3 then
                if traz > 0 then
            UiTranslate(-686.5,-205)
            UiImageBox("MOD/images/box-lights.png", 90, 40, 10, 10)
                end
            end
            UiPop()
            UiTranslate(-737,-251)
            somar = DrawButtons(somar, "<", 40, 30, 2, 40, 0, 0, 0, traz, "TZE")
            if somar then
                atualizar=true
            traz = traz-1
                if traz < 0 then
                    traz=5
                end
            end
            UiTranslate(50,0)
            subtrair = DrawButtons(subtrair, ">", 40, 30, 2, 40, 0, 0, 0)
            if subtrair then
                atualizar=true
            traz = traz+1
                if traz > 5 then
                    traz=0
                end
            end
        UiPop()

        --BLN
            UiPush()
            UiTranslate(0,320)
            UiPush()
            if lights1 or lights2 or lights3 then
                if re > 0 then
            UiTranslate(-686.5,-205)
            UiImageBox("MOD/images/box-lights.png", 90, 40, 10, 10)
                end
            end
            UiPop()
            UiTranslate(-737,-251)
            somar = DrawButtons(somar, "<", 40, 30, 2, 40, 0, 0, 0, re, "BLN")
            if somar then
                atualizar=true
                re = re-1
                if re < 0 then
                    re=5
                end
            end
            UiTranslate(50,0)
            subtrair = DrawButtons(subtrair, ">", 40, 30, 2, 40, 0, 0, 0)
            if subtrair then
                atualizar=true
                re = re+1
                if re > 5 then
                    re=0
                end
            end
        UiPop()

    --DIRECIONAL
        UiPush()
            UiTranslate(0,480)
            UiPush()
            if direcional then
                if direc > 0 then
            UiTranslate(-686.5,-205)
            UiImageBox("MOD/images/box-lights.png", 90, 40, 10, 10)
                end
            end
            UiPop()
            UiTranslate(-737,-251)
            somar = DrawButtons(somar, "<", 40, 30, 2, 40, 0, 0, 0, direc, "<<>>")
            if somar then
                atualizardi=true
            direc = direc-1
                if direc < 0 then
                    direc=5
                end
            end
            UiTranslate(50,0)
            subtrair = DrawButtons(subtrair, ">", 40, 30, 2, 40, 0, 0, 0)
            if subtrair then
                atualizardi=true
            direc = direc+1
                if direc > 5 then
                    direc=0
                end
            end
        UiPop()
    --end    
        if lights1 or lights2 or lights3 then
            --PADROES
            UiPush()
            UiTranslate(-476,-227)
            UiPush()
            --fente farol
            if FFE1 == 1 then
                UiImageBox("MOD/images/box-lights.png", 27, 27, 10, 10)
            end
            UiTranslate(143,0)        
            if FFD1 == 1 then
                UiImageBox("MOD/images/box-lights.png", 27, 27, 10, 10)
            end
            UiTranslate(-160,40)
            --frente
            UiPush()
            if  FTE1== 1 then
            UiImageBox("MOD/images/box-lights.png", 27, 27, 10, 10)
            end
            UiTranslate(34,0)
            if  FTE2== 1 then
            UiImageBox("MOD/images/box-lights.png", 27, 27, 10, 10)
            end
            UiTranslate(109,0)
            if  FTD2== 1 then
            UiImageBox("MOD/images/box-lights.png", 27, 27, 10, 10)
            end
            UiTranslate(34,0)
            if  FTD1== 1 then
            UiImageBox("MOD/images/box-lights.png", 27, 27, 10, 10)
            end
            UiPop()

            UiTranslate(-66,41)
            --lado
            UiPush()
            if  LDE1== 1 then
            UiImageBox("MOD/images/box-lights.png", 27, 27, 10, 10)
            end
            UiTranslate(34,0)
            if  LDE2== 1 then
            UiImageBox("MOD/images/box-lights.png", 27, 27, 10, 10)
            end
            UiTranslate(34,0)
            if  LDE3== 1 then
            UiImageBox("MOD/images/box-lights.png", 27, 27, 10, 10)
            end
            UiTranslate(34,0)
            if  LDE4== 1 then
            UiImageBox("MOD/images/box-lights.png", 27, 27, 10, 10)
            end

            UiTranslate(107,0)
            if  LDD4== 1 then
            UiImageBox("MOD/images/box-lights.png", 27, 27, 10, 10)
            end
            UiTranslate(34,0)
            if  LDD3== 1 then
            UiImageBox("MOD/images/box-lights.png", 27, 27, 10, 10)
            end
            UiTranslate(34,0)
            if  LDD2== 1 then
            UiImageBox("MOD/images/box-lights.png", 27, 27, 10, 10)
            end
            UiTranslate(34,0)
            if  LDD1== 1 then
            UiImageBox("MOD/images/box-lights.png", 27, 27, 10, 10)
            end
            UiPop()

            UiTranslate(0,70)
            --cima
            UiPush()
            if  CME1== 1 then
            UiImageBox("MOD/images/box-lights.png", 27, 27, 10, 10)
            end
            UiTranslate(34,0)
            if  CME2== 1 then
            UiImageBox("MOD/images/box-lights.png", 27, 27, 10, 10)
            end
            UiTranslate(34,0)
            if  CME3== 1 then
            UiImageBox("MOD/images/box-lights.png", 27, 27, 10, 10)
            end
            UiTranslate(34,0)
            if  CME4== 1 then
            UiImageBox("MOD/images/box-lights.png", 27, 27, 10, 10)
            end
            UiTranslate(34,0)
            if  CME5== 1 then
            UiImageBox("MOD/images/box-lights.png", 27, 27, 10, 10)
            end

            UiTranslate(40,0)
            if  CMD5== 1 then
            UiImageBox("MOD/images/box-lights.png", 27, 27, 10, 10)
            end
            UiTranslate(33,0)
            if  CMD4== 1 then
            UiImageBox("MOD/images/box-lights.png", 27, 27, 10, 10)
            end
            UiTranslate(34,0)
            if  CMD3== 1 then
            UiImageBox("MOD/images/box-lights.png", 27, 27, 10, 10)
            end
            UiTranslate(34,0)
            if  CMD2== 1 then
            UiImageBox("MOD/images/box-lights.png", 27, 27, 10, 10)
            end
            UiTranslate(34,0)
            if  CMD1== 1 then
            UiImageBox("MOD/images/box-lights.png", 27, 27, 10, 10)
            end
            UiPop()

            UiTranslate(67,67)
            --cima2
            UiPush()
            if  C2E1== 1 then
            UiImageBox("MOD/images/box-lights.png", 27, 27, 10, 10)
            end
            UiTranslate(34,0)
            if  C2E2== 1 then
            UiImageBox("MOD/images/box-lights.png", 27, 27, 10, 10)
            end
            UiTranslate(34,0)
            if  C2E3== 1 then
            UiImageBox("MOD/images/box-lights.png", 27, 27, 10, 10)
            end

            UiTranslate(41,0)
            if  C2D3== 1 then
            UiImageBox("MOD/images/box-lights.png", 27, 27, 10, 10)
            end
            UiTranslate(33,0)
            if  C2D2== 1 then
            UiImageBox("MOD/images/box-lights.png", 27, 27, 10, 10)
            end
            UiTranslate(34,0)
            if  C2D1== 1 then
            UiImageBox("MOD/images/box-lights.png", 27, 27, 10, 10)
            end
            UiPop()

            UiTranslate(0,47)
            --traz
            UiPush()
            if  TZE1== 1 then
            UiImageBox("MOD/images/box-lights.png", 27, 27, 10, 10)
            end
            UiTranslate(34,0)
            if  TZE2== 1 then
            UiImageBox("MOD/images/box-lights.png", 27, 27, 10, 10)
            end

            UiTranslate(108,0)
            if  TZD2== 1 then
            UiImageBox("MOD/images/box-lights.png", 27, 27, 10, 10)
            end
            UiTranslate(33,0)
            if  TZD1== 1 then
            UiImageBox("MOD/images/box-lights.png", 27, 27, 10, 10)
            end
            UiPop()

            UiTranslate(17,44)

            --trazfarol
            UiPush()
            if  LTE1== 1 then
            UiImageBox("MOD/images/box-lights.png", 27, 27, 10, 10)
            end

            UiTranslate(142,0)
            if  LTD1== 1 then
            UiImageBox("MOD/images/box-lights.png", 27, 27, 10, 10)
            end
            UiPop()
            UiTranslate(0,35)
            --trazfreio
            UiPush()
            if  LFE1== 1 then
            UiImageBox("MOD/images/box-lights.png", 27, 27, 10, 10)
            end
            UiTranslate(142,0)
            if  LFD1== 1 then
            UiImageBox("MOD/images/box-lights.png", 27, 27, 10, 10)
            end
            UiPop()

            UiTranslate(0,35)
            --re
            UiPush()
            if  BLE1== 1 then
            UiImageBox("MOD/images/box-lights.png", 27, 27, 10, 10)
            end
            UiTranslate(142,0)
            if  BLD1== 1 then
            UiImageBox("MOD/images/box-lights.png", 27, 27, 10, 10)
            end
            UiPop()

            UiPop()
            UiPop()
        end
    if direcional then
        UiPush()
        UiTranslate(-595,296)
        --direcional
        UiPush()
        if DLE1==1 then
        UiImageBox("MOD/images/box-lights.png", 27, 27, 10, 10)
        end
        UiTranslate(35,0)
        if DLE2==1 then
        UiImageBox("MOD/images/box-lights.png", 27, 27, 10, 10)
        end
        UiTranslate(35,0)
        if DLE3==1 then
        UiImageBox("MOD/images/box-lights.png", 27, 27, 10, 10)
        end
        UiTranslate(35,0)
        if DLE4==1 then
        UiImageBox("MOD/images/box-lights.png", 27, 27, 10, 10)
        end
        UiTranslate(35,0)
        if DLE5==1 then
        UiImageBox("MOD/images/box-lights.png", 27, 27, 10, 10)
        end
        UiTranslate(46,0)
        if DLD5==1 then
        UiImageBox("MOD/images/box-lights.png", 27, 27, 10, 10)
        end
        UiTranslate(35,0)
        if DLD4==1 then
        UiImageBox("MOD/images/box-lights.png", 27, 27, 10, 10)
        end
        UiTranslate(35,0)
        if DLD3==1 then
        UiImageBox("MOD/images/box-lights.png", 27, 27, 10, 10)
        end
        UiTranslate(35,0)
        if DLD2==1 then
        UiImageBox("MOD/images/box-lights.png", 27, 27, 10, 10)
        end
        UiTranslate(35,0)
        if DLD1==1 then
        UiImageBox("MOD/images/box-lights.png", 27, 27, 10, 10)
        end
        UiPop()
        UiPop()
    end
    UiPop()

    UiPush()
    UiTranslate(-518,-326)
    primary = DrawButtons(primary, GetString("emergency.primary"), 106, 24, 2, 20, 0, 0, 0)
    if primary then
        SetTag(findvehicle, "em", "1")
    end

    UiTranslate(110,0)
    secondary = DrawButtons(secondary, GetString("emergency.secondary"), 106, 24, 2, 20, 0, 0, 0)
    if secondary then
        SetTag(findvehicle, "em", "2")
    end
    UiTranslate(115,0)
    secondary = DrawButtons(secondary, GetString("emergency.tertiary"), 106, 24, 2, 20, 0, 0, 0)
    if secondary then
        SetTag(findvehicle, "em", "3")
    end

    UiTranslate(55,570)
    if HasTag(findvehicle, "directional") then
    directionalb = DrawButtons(directionalb, GetString("emergency.directional"), 106, 24, 2, 20, 0, 0, 0)
        if directionalb then
            SetTag(findvehicle, "di", "1")
        end
    end
    UiPop()
    
end


function DrawButtons(condicao, texto, w, h, fonte, tamanho, R, G, B, numero, nome)
    UiPush()
        UiButtonHoverColor(1, 0.8, 0.7)
        UiButtonPressColor(1, 0.6, 0.4)
        UiButtonPressDist(0)
        UiFont("regular.ttf", tamanho*1.2)
        UiButtonImageBox("MOD/images/box-buttons.png", 6, 6)
        UiColor(R,G,B)
        if UiTextButton(texto, w, h) then
            PlaySound(click)
            condicao = true
        else
            condicao = false        
        end
        UiTranslate(40,45)     
        UiFont("regular.ttf", tamanho)
        UiText(nome)
        UiColor(1,1,1)
        UiTranslate(10,50)
        if numero==0 then
        UiText("OFF")
        else
        UiText(numero)
        end
    UiPop()
    return condicao
end

function lightsOptions()
    if lights1 then
        if atualizar then
        frentei=frente
        cimai=cima
        cima2i=cima2
        ladoi=lado
        trazi=traz
        rei=re
        frenteli=frentel
        trazli=trazl
        trazfi=trazf 
        atualizar=false
        end
        frente=frentei
        cima=cimai
        cima2=cima2i
        lado=ladoi
        traz=trazi
        re=rei
        frentel=frenteli
        trazl=trazli
        trazf=trazfi

    elseif lights2 then
        if atualizar then
            frenteo=frente
            cimao=cima
            cima2o=cima2
            ladoo=lado
            trazo=traz
            reo=re
            frentelo=frentel
            trazlo=trazl
            trazfo=trazf
            atualizar=false
            end
            frente=frenteo
            cima=cimao
            cima2=cima2o
            lado=ladoo
            traz=trazo
            re=reo
            frentel=frentelo
            trazl=trazlo
            trazf=trazfo

    elseif lights3 then
        if atualizar then
            frentep=frente
            cimap=cima
            cima2p=cima2
            ladop=lado
            trazp=traz
            rep=re
            frentelp=frentel
            trazlp=trazl
            trazfp=trazf
            atualizar=false
            end
            frente=frentep
            cima=cimap
            cima2=cima2p
            lado=ladop
            traz=trazp
            re=rep
            frentel=frentelp
            trazl=trazlp
            trazf=trazfp
        else
            atualizar=false
            frente=0
            cima=0
            cima2=0
            lado=0
            traz=0
            re=0
            frentel=0
            trazl=0
            trazf=0
        end
        if direcional then
            if atualizardi then
            direcu=direc
            atualizardi=false
            end
            direc=direcu
        else
            atualizardi=false
            direc=0
        end
end

function patter(t)
        if frente ==0 then 
        FTE1 = 0        FTD1 = 0
        FTE2 = 0        FTD2 = 0
        elseif frente ==1 then
        FTE1 = a1        FTD1 = a2
        FTE2 = a1        FTD2 = a2
        elseif frente==2 then
        FTE1 = a1        FTD1 = a2
        FTE2 = a2        FTD2 = a1
        elseif frente==3 then
        FTE1 = a3        FTD1 = a4
        FTE2 = a2        FTD2 = a1
        elseif frente==4 then
        FTE1 = a1        FTD1 = a2
        FTE2 = a3        FTD2 = a4
        elseif frente==5 then
        FTE1 = a3        FTD1 = a4
        FTE2 = a4        FTD2 = a3
        end

        if cima==0 then
        CMD1 = 0        CME1 = 0
        CMD2 = 0        CME2 = 0
        CMD3 = 0        CME3 = 0
        CMD4 = 0        CME4 = 0
        CMD5 = 0        CME5 = 0
        elseif cima==1 then
        CMD1 = a1       CME1 = a2
        CMD2 = 0        CME2 = 0
        CMD3 = 0        CME3 = 0
        CMD4 = 0        CME4 = 0
        CMD5 = a1       CME5 = a2
        elseif cima==2 then
        CMD1 = a1       CME1 = a2
        CMD2 = a1       CME2 = a2
        CMD3 = a1       CME3 = a2
        CMD4 = a1       CME4 = a2
        CMD5 = a1       CME5 = a2
        elseif cima==3 then
        CMD1 = a3       CME1 = a4
        CMD2 = a3       CME2 = a4
        CMD3 = a3       CME3 = a4
        CMD4 = a3       CME4 = a4
        CMD5 = a3       CME5 = a4
        elseif cima==4 then
        CMD1 = a3       CME1 = a4
        CMD2 = a4       CME2 = a3
        CMD3 = a3       CME3 = a4
        CMD4 = a4       CME4 = a3
        CMD5 = a3       CME5 = a4
        elseif cima==5 then 
        CMD1 = a3       CME1 = a4
        CMD2 = a1       CME2 = a2
        CMD3 = a6       CME3 = a5
        CMD4 = a4       CME4 = a3
        CMD5 = a5       CME5 = a6  
        end

        if cima2==0 then
        C2D1 = 0        C2E1 = 0
        C2D2 = 0        C2E2 = 0
        C2D3 = 0        C2E3 = 0
        elseif cima2==1 then
        C2D1 = a2       C2E1 = a1
        C2D2 = a2       C2E2 = a1
        C2D3 = a2       C2E3 = a1
        elseif cima2==2 then
        C2D1 = a3        C2E1 = a4
        C2D2 = a3        C2E2 = a4
        C2D3 = a3        C2E3 = a4
        elseif cima2==3 then
        C2D1 = a5        C2E1 = a6
        C2D2 = a5        C2E2 = a6
        C2D3 = a5        C2E3 = a6
        elseif cima2==4 then
        C2D1 = a4        C2E1 = a3
        C2D2 = a3        C2E2 = a4
        C2D3 = a4        C2E3 = a3
        elseif cima2==5 then
        C2D1 = a1        C2E1 = a1
        C2D2 = a3        C2E2 = a3
        C2D3 = a1        C2E3 = a1
        end

        if lado==0 then
        LDD1 = 0        LDE1 = 0
        LDD2 = 0        LDE2 = 0
        LDD3 = 0        LDE3 = 0
        LDD4 = 0        LDE4 = 0
        elseif lado==1 then
        LDD1 = a2       LDE1 = a1
        LDD2 = a1       LDE2 = a2
        LDD3 = a1       LDE3 = a2
        LDD4 = a2       LDE4 = a1
        elseif lado==2 then
        LDD1 = a3       LDE1 = a4
        LDD2 = a4       LDE2 = a3
        LDD3 = a4       LDE3 = a3
        LDD4 = a3       LDE4 = a4
        elseif lado==3 then
        LDD1 = a1       LDE1 = a1
        LDD2 = a2       LDE2 = a2
        LDD3 = a2       LDE3 = a2
        LDD4 = a1       LDE4 = a1
        elseif lado==4 then
        LDD1 = a3       LDE1 = a4
        LDD2 = a5       LDE2 = a6
        LDD3 = a6       LDE3 = a5
        LDD4 = a4       LDE4 = a3
        elseif lado==5 then
        LDD1 = a6       LDE1 = a5
        LDD2 = a5       LDE2 = a6
        LDD3 = a5       LDE3 = a6
        LDD4 = a6       LDE4 = a5
        end

        if traz==0 then
        TZD1 = 0        TZE1 = 0
        TZD2 = 0        TZE2 = 0
        elseif traz==1 then
        TZD1 = a1       TZE1 = a2
        TZD2 = a1       TZE2 = a2
        elseif traz==2 then
        TZD1 = a2       TZE1 = a1
        TZD2 = a1       TZE2 = a2
        elseif traz==3 then
        TZD1 = a1       TZE1 = a2
        TZD2 = a2       TZE2 = a1
        elseif traz==4 then
        TZD1 = a3       TZE1 = a4
        TZD2 = a3       TZE2 = a4
        elseif traz==5 then
        TZD1 = a3       TZE1 = a4
        TZD2 = a4       TZE2 = a3
        end

        if re==0 then
        BLD1 = 0        BLE1 = 0
        elseif re==1 then
        BLD1 = a1       BLE1 = a2
        elseif re==2 then
        BLD1 = a2       BLE1 = a1
        elseif re==3 then
        BLD1 = a1       BLE1 = a2
        elseif re==4 then
        BLD1 = a3       BLE1 = a4
        elseif re==5 then
        BLD1 = a3       BLE1 = a4
        end

        if frentel==0 then
        FFD1 = 0        FFE1 = 0
        elseif frentel==1 then
        FFD1 = a1       FFE1 = a2
        elseif frentel==2 then
        FFD1 = a3       FFE1 = a4
        elseif frentel==3 then
        FFD1 = a5       FFE1 = a6
        elseif frentel==4 then
        FFD1 = a2       FFE1 = a1
        elseif frentel==5 then
        FFD1 = a4       FFE1 = a3
        end

        if trazl==0 then
        LTD1 = 0        LTE1 = 0
        elseif trazl==1 then
        LTD1 = a1       LTE1 = a2
        elseif trazl==2 then
        LTD1 = a3       LTE1 = a4
        elseif trazl==3 then
        LTD1 = a5       LTE1 = a6
        elseif trazl==4 then
        LTD1 = a2       LTE1 = a1
        elseif trazl==5 then
        LTD1 = a4       LTE1 = a3
        end

        if trazf==0 then
        LFD1 = 0        LFE1 = 0
        elseif trazf==1 then
        LFD1 = a1        LFE1 = a2
        elseif trazf==2 then
        LFD1 = a3        LFE1 = a4
        elseif trazf==3 then
        LFD1 = a5        LFE1 = a6
        elseif trazf==4 then
        LFD1 = a2        LFE1 = a1
        elseif trazf==5 then
        LFD1 = a4        LFE1 = a3
        end

        if direc==0 then
        DLD1 = 0        DLE1 = 0
        DLD2 = 0        DLE2 = 0
        DLD3 = 0        DLE3 = 0
        DLD4 = 0        DLE4 = 0
        DLD5 = 0        DLE5 = 0
        elseif direc==1 then
        DLD1 = b1       DLE1 = b10
        DLD2 = b2       DLE2 = b9
        DLD3 = b3       DLE3 = b8
        DLD4 = b4       DLE4 = b7
        DLD5 = b5       DLE5 = b6
        elseif direc==2 then
        DLD1 = b10      DLE1 = b1
        DLD2 = b9       DLE2 = b2
        DLD3 = b8       DLE3 = b3
        DLD4 = b7       DLE4 = b4
        DLD5 = b6       DLE5 = b5
        elseif direc==3 then
        DLD1 = a1       DLE1 = a2
        DLD2 = a1       DLE2 = a2
        DLD3 = a1       DLE3 = a2
        DLD4 = a1       DLE4 = a2
        DLD5 = a1       DLE5 = a2
        elseif direc==4 then
        DLD1 = a1       DLE1 = a1
        DLD2 = a1       DLE2 = a1
        DLD3 = a1       DLE3 = a1
        DLD4 = a2       DLE4 = a2
        DLD5 = a2       DLE5 = a2
        elseif direc==5 then
        DLD1 = a4       DLE1 = a4
        DLD2 = a6       DLE2 = a6
        DLD3 = a1       DLE3 = a1
        DLD4 = a2       DLE4 = a2
        DLD5 = a3       DLE5 = a3
        end

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