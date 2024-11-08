-- Function to create and initialize a table by filtering shapes with "ALSLight" tag
function createTable(index)
    local shapes = GetBodyShapes(BodyLight[index])
    for i = #shapes, 1, -1 do
        if not HasTag(shapes[i], "ALSLight") then
            table.remove(shapes, i)
        end
    end
    return shapes
end

function RemoveFromTable(tbl, element)
    for i = #tbl, 1, -1 do
        if tbl[i] == element then
            table.remove(tbl, i)
        end
    end
end

-- Function to insert a key-value pair into a table
function insertKeyValue(table, key, value)
    table[key] = value
end

-- Function to print the value for a given key in a table
function printValueForKey(table, key)
    return table[key]
end

function init()
    -- Find bodies with the "light" tag
    BodyLight = FindBodies("light")
    SetBool("ALS.NewVehicle", true)

    alarmlight = FindShapes("alarmlight")

    for i = 1, #alarmlight do SetShapeEmissiveScale(alarmlight[i], 0) end


    gethealthdoor = {}


    --use this--
    --shootSnd = {}
    --for i=0, 3 do
    --    shootSnd[i] = LoadSound("tools/tankgun"..i..".ogg")
    --end


    alarmList = {}
    alarmList[#alarmList + 1] = LoadLoop("sound/alarm01.ogg")
    alarmList[#alarmList + 1] = LoadLoop("sound/alarm02.ogg")

    alarmOffList = {}
    alarmOffList[#alarmOffList + 1] = LoadSound("sound/Off01.ogg")
    alarmOffList[#alarmOffList + 1] = LoadSound("sound/Off02.ogg")

    alarmOnList = {}
    alarmOnList[#alarmOnList + 1] = LoadSound("sound/On01.ogg")
    alarmOnList[#alarmOnList + 1] = LoadSound("sound/On02.ogg")

    chimeList = {}
    chimeList[#chimeList + 1] = LoadLoop("sound/chime01.ogg")
    chimeList[#chimeList + 1] = LoadLoop("sound/chime02.ogg")
    chimeList[#chimeList + 1] = LoadLoop("sound/chime03.ogg")
    chimeList[#chimeList + 1] = LoadLoop("sound/chime04.ogg")
    chimeList[#chimeList + 1] = LoadLoop("sound/chime05.ogg")


    honkList = {}
    honkList[#honkList + 1] = LoadLoop("sound/honk01.ogg")
    honkList[#honkList + 1] = LoadLoop("sound/honk02.ogg")
    honkList[#honkList + 1] = LoadLoop("sound/honk03.ogg")
    honkList[#honkList + 1] = LoadLoop("sound/honk04.ogg")


    frame1 = 0
    counter = 0


    ALSdoors = {}
    Vehicles = {}
    -- Locate the vehicle the light is in
    local all = GetJointedBodies(BodyLight[1])
    for i = 1, #all do
        if HasTag(all[i], "VehicleBody") then
            Vehicle = GetBodyVehicle(all[i])

            local shapes = GetBodyShapes(all[i])
            for i = 1, #shapes do
                if HasTag(shapes[i], "ALShorn") then
                    findvehicle = shapes[i]
                end
                if HasTag(shapes[i], "chimepos") then
                    chimepos = shapes[i]
                end
                if HasTag(shapes[i], "hornpos") then
                    hornpos = shapes[i]
                end
            end
        end

        if HasTag(all[i], "ALSdoor") then
            Vehicles[#Vehicles + 1] = GetBodyVehicle(all[i])
            ALSdoors[#ALSdoors + 1] = all[i]
        end
    end




    -- Number of tables you want to create
    local numTables = #BodyLight
    -- Create and store tables in a container table

    --create tables containg the ligth shapes
    local GroupTablesNormal = {}

    --reference for the body shapes/groups
    ReferenceTable = {}
    local temp = {}


    --conteiner for the light animations
    containerTableLightsNormal = {}
    GroupNumber = 0

    for i = 1, numTables do
        if HasTag(BodyLight[i], "group") then
            GroupNumber = GroupNumber + 1
        end

        lightgroup = GroupNumber

        if HasTag(BodyLight[i], "HL") or HasTag(BodyLight[i], "HB") or HasTag(BodyLight[i], "BL") or HasTag(BodyLight[i], "BRL") or HasTag(BodyLight[i], "RL") or HasTag(BodyLight[i], "B") or HasTag(BodyLight[i], "AD") or HasTag(BodyLight[i], "FL") then
            if not HasTag(BodyLight[i], "add") then
                containerTableLightsNormal[#containerTableLightsNormal + 1] = createTable(i)
                -- Insert a new key-value pair into the table
                insertKeyValue(GroupTablesNormal, lightgroup, #containerTableLightsNormal)
                ReferenceTable[#ReferenceTable + 1] = BodyLight[i]
            else
                --return positon of the container
                local tablenumber = printValueForKey(GroupTablesNormal, lightgroup)

                temp[1] = createTable(i)

                for _, value in ipairs(temp[1]) do
                    table.insert(containerTableLightsNormal[tablenumber], value)
                end
            end

            if HasTag(BodyLight[i], "normal") then
                RemoveTag(BodyLight[i], "add")
                RemoveTag(BodyLight[i], "light")
            end
        end
    end

    --reload the BodyLight table
    BodyLight = FindBodies("light")


    turnOff = true
    change = 0
    lightvallue = "1"

    -- Find shapes with the "ALSLight" tag
    lightShapesEM = FindShapes("ALSLight")

    -- Turn off all lights initially
    for i = 1, #lightShapesEM do
        SetShapeEmissiveScale(lightShapesEM[i], 0)
    end


    UP = HasTag(Vehicle, "UP")
    if UP then
        PopUpJoints = FindJoints("popup")
    end

    InternalLight = HasTag(Vehicle, "IL")
    if InternalLight then
        InternalLights = FindShapes("InternalLight")

        for i = 1, #InternalLights do
            SetShapeEmissiveScale(InternalLights[i], 0)
        end
    end
    
    TrunkLight = HasTag(Vehicle, "TL")
    if TrunkLight then
        TrunkLights = FindShapes("TrunkLight")
        for i = 1, #TrunkLights do
            SetShapeEmissiveScale(TrunkLights[i], 0)
        end
    end

    FoldingMirror = HasTag(Vehicle, "FM")
    if FoldingMirror then
        FoldingMirrors = FindJoints("mirror")
        for i = 1, #FoldingMirrors do
            SetJointMotorTarget(FoldingMirrors[i], 0, GetTagValue(FoldingMirrors[i], "speed"))
        end
    end


    -- Find lights with the "lights" tag
    lights = FindLights("lights")


    -- Clean memory
    collectgarbage("collect")

    --update lights status
    NormalLight(Vehicle, 0)
end

function PopUpHeadlights(HLON, HBON, EMON)
    for i = 1, #PopUpJoints do
        if HLON or HBON or EMON then
            SetTag(PopUpJoints[i], "UP")
            SetJointMotorTarget(PopUpJoints[i], GetTagValue(PopUpJoints[i], "popup"),
                GetTagValue(PopUpJoints[i], "veloc"))
        end
        if HasTag(PopUpJoints[i], "UP") then
            if not HLON and not HBON and not EMON then
                SetJointMotorTarget(PopUpJoints[i], 0, GetTagValue(PopUpJoints[i], "veloc"))
                RemoveTag(PopUpJoints[i], "UP")
            end
        end
    end
end

function NormalLight(Vehicle, Time, forceback, brake)
    local Blinker = HasTag(Vehicle, "B")
    local Right = GetTagValue(Vehicle, "B") == "1"
    local Left = GetTagValue(Vehicle, "B") == "2"
    local Razard = GetTagValue(Vehicle, "B") == "3"
    HeadLight = HasTag(Vehicle, "HL")
    local HighBeam = HasTag(Vehicle, "HB")
    local HighBeamTemp = HasTag(Vehicle, "HBT")
    local FogLight = HasTag(Vehicle, "FL")
    Aditional = HasTag(Vehicle, "AD")

    if UP then
        PopUpHeadlights(HeadLight, HighBeamTemp, HasTag(Vehicle, "em"))
    end

    for i = 1, #ReferenceTable do
        --headlight normal
        if HasTag(ReferenceTable[i], "HL") then
            local typeValue = GetTagValue(ReferenceTable[i], "type")
            if typeValue == "1" then
                local statusValue = GetTagValue(ReferenceTable[i], "status")

                if HeadLight and not HighBeam and not HighBeamTemp then
                    SetTag(ReferenceTable[i], "on")
                    for j = 1, #containerTableLightsNormal[i] do
                        SetShapeEmissiveScale(containerTableLightsNormal[i][j], 1)
                        local light = GetShapeLights(containerTableLightsNormal[i][j])
                        for i = 1, #light do
                            if GetTagValue(light[i], "type") == "1" then
                                SetLightIntensity(light[i], GetFloat("ALS.Front") / 5)
                            end
                            if GetTagValue(light[i], "type") == "2" then
                                SetLightIntensity(light[i], 0)
                            end
                        end
                        if HasTag(containerTableLightsNormal[i][j], "inv") then
                            RemoveTag(containerTableLightsNormal[i][j], "invisible")
                        end
                        RemoveFromTable(lightShapesEM, containerTableLightsNormal[i][j])
                        SetTag(ReferenceTable[i], "skip")
                    end
                elseif HeadLight and HighBeam or HighBeamTemp then
                    SetTag(ReferenceTable[i], "on")
                    for j = 1, #containerTableLightsNormal[i] do
                        SetShapeEmissiveScale(containerTableLightsNormal[i][j], 1)
                        local light = GetShapeLights(containerTableLightsNormal[i][j])
                        for i = 1, #light do
                            if GetTagValue(light[i], "type") == "1" then
                                SetLightIntensity(light[i], 0)
                            end
                            if GetTagValue(light[i], "type") == "2" then
                                SetLightIntensity(light[i], GetFloat("ALS.HighBeamL"))
                            end
                        end
                        if HasTag(containerTableLightsNormal[i][j], "inv") then
                            RemoveTag(containerTableLightsNormal[i][j], "invisible")
                        end
                        RemoveFromTable(lightShapesEM, containerTableLightsNormal[i][j])
                        SetTag(ReferenceTable[i], "skip")
                    end
                elseif HasTag(ReferenceTable[i], "on") then
                    for j = 1, #containerTableLightsNormal[i] do
                        SetShapeEmissiveScale(containerTableLightsNormal[i][j], 0)
                        table.insert(lightShapesEM, containerTableLightsNormal[i][j])
                        RemoveTag(ReferenceTable[i], "skip")
                        RemoveTag(ReferenceTable[i], "on")
                        RemoveTag(Vehicle, "HB")
                        if HasTag(containerTableLightsNormal[i][j], "inv") then
                            SetTag(containerTableLightsNormal[i][j], "invisible")
                        end
                    end
                end
            elseif typeValue == "2" then
                if HeadLight and not HighBeam and not HighBeamTemp then
                    for j = 1, #containerTableLightsNormal[i] do
                        local light = GetShapeLights(containerTableLightsNormal[i][j])
                        SetShapeEmissiveScale(containerTableLightsNormal[i][j], 1)
                        for i = 1, #light do
                            SetLightIntensity(light[i], GetFloat("ALS.Front") / 5)
                        end
                        if HasTag(containerTableLightsNormal[i][j], "inv") then
                            RemoveTag(containerTableLightsNormal[i][j], "invisible")
                        end
                        RemoveFromTable(lightShapesEM, containerTableLightsNormal[i][j])
                    end
                    SetTag(ReferenceTable[i], "on")
                    SetTag(ReferenceTable[i], "skip")
                elseif HeadLight and HighBeam or HighBeamTemp then
                    for j = 1, #containerTableLightsNormal[i] do
                        SetShapeEmissiveScale(containerTableLightsNormal[i][j], 0)
                        if HasTag(containerTableLightsNormal[i][j], "inv") then
                            SetTag(containerTableLightsNormal[i][j], "invisible")
                        end
                        RemoveFromTable(lightShapesEM, containerTableLightsNormal[i][j])
                    end
                    SetTag(ReferenceTable[i], "on")
                    SetTag(ReferenceTable[i], "skip")
                elseif HasTag(ReferenceTable[i], "on") then
                    for j = 1, #containerTableLightsNormal[i] do
                        SetShapeEmissiveScale(containerTableLightsNormal[i][j], 0)
                        table.insert(lightShapesEM, containerTableLightsNormal[i][j])
                        RemoveTag(ReferenceTable[i], "skip")
                        RemoveTag(ReferenceTable[i], "on")
                        RemoveTag(Vehicle, "HB")
                        if HasTag(containerTableLightsNormal[i][j], "inv") then
                            SetTag(containerTableLightsNormal[i][j], "invisible")
                        end
                    end
                end
            elseif typeValue == "3" then
                if HeadLight and not HighBeam and not HighBeamTemp then
                    for j = 1, #containerTableLightsNormal[i] do
                        SetShapeEmissiveScale(containerTableLightsNormal[i][j], 1)
                        local light = GetShapeLights(containerTableLightsNormal[i][j])
                        for i = 1, #light do
                            SetLightIntensity(light[i], GetFloat("ALS.Front") / 5)
                        end
                        if HasTag(containerTableLightsNormal[i][j], "inv") then
                            RemoveTag(containerTableLightsNormal[i][j], "invisible")
                        end
                        RemoveFromTable(lightShapesEM, containerTableLightsNormal[i][j])
                    end
                    SetTag(ReferenceTable[i], "on")
                    SetTag(ReferenceTable[i], "skip")
                elseif HeadLight and HighBeam or HighBeamTemp then
                    for j = 1, #containerTableLightsNormal[i] do
                        SetShapeEmissiveScale(containerTableLightsNormal[i][j], 1)
                        local light = GetShapeLights(containerTableLightsNormal[i][j])
                        for i = 1, #light do
                            SetLightIntensity(light[i], 0)
                        end
                        if HasTag(containerTableLightsNormal[i][j], "inv") then
                            RemoveTag(containerTableLightsNormal[i][j], "invisible")
                        end
                        RemoveFromTable(lightShapesEM, containerTableLightsNormal[i][j])
                    end
                    SetTag(ReferenceTable[i], "on")
                    SetTag(ReferenceTable[i], "skip")
                elseif HasTag(ReferenceTable[i], "on") then
                    for j = 1, #containerTableLightsNormal[i] do
                        SetShapeEmissiveScale(containerTableLightsNormal[i][j], 0)
                        local light = GetShapeLights(containerTableLightsNormal[i][j])
                        for i = 1, #light do
                            SetLightIntensity(light[i], GetFloat("ALS.Front") / 5)
                        end
                        if HasTag(containerTableLightsNormal[i][j], "inv") then
                            SetTag(containerTableLightsNormal[i][j], "invisible")
                        end
                        table.insert(lightShapesEM, containerTableLightsNormal[i][j])
                        RemoveTag(ReferenceTable[i], "skip")
                        RemoveTag(ReferenceTable[i], "on")
                        RemoveTag(Vehicle, "HB")
                    end
                end
            end
        end
        --headlight normal end

        --HighBeam normal
        if HasTag(ReferenceTable[i], "HB") then
            if HeadLight and HighBeam or HighBeamTemp then
                for j = 1, #containerTableLightsNormal[i] do
                    SetShapeEmissiveScale(containerTableLightsNormal[i][j], 1)
                    local light = GetShapeLights(containerTableLightsNormal[i][j])
                    for i = 1, #light do
                        SetLightIntensity(light[i], GetFloat("ALS.HighBeamL"))
                    end
                    if HasTag(containerTableLightsNormal[i][j], "inv") then
                        RemoveTag(containerTableLightsNormal[i][j], "invisible")
                    end
                    RemoveFromTable(lightShapesEM, containerTableLightsNormal[i][j])
                end
                SetTag(ReferenceTable[i], "on")
                SetTag(ReferenceTable[i], "skip")
            elseif HasTag(ReferenceTable[i], "on") then
                for j = 1, #containerTableLightsNormal[i] do
                    SetShapeEmissiveScale(containerTableLightsNormal[i][j], 0)
                    if HasTag(containerTableLightsNormal[i][j], "inv") then
                        SetTag(containerTableLightsNormal[i][j], "invisible")
                    end
                    RemoveTag(ReferenceTable[i], "skip")
                    RemoveTag(ReferenceTable[i], "on")
                end
            end
        end
        --ALS.HighBeamL end

        --fog light normal
        if HasTag(ReferenceTable[i], "FL") then
            if FogLight and HeadLight then
                for j = 1, #containerTableLightsNormal[i] do
                    SetShapeEmissiveScale(containerTableLightsNormal[i][j], 1)
                    local light = GetShapeLights(containerTableLightsNormal[i][j])
                    for i = 1, #light do
                        SetLightIntensity(light[i], GetFloat("ALS.FogLight") / 5)
                    end
                    if HasTag(containerTableLightsNormal[i][j], "inv") then
                        RemoveTag(containerTableLightsNormal[i][j], "invisible")
                    end
                    RemoveFromTable(lightShapesEM, containerTableLightsNormal[i][j])
                end
                SetTag(ReferenceTable[i], "on")
                SetTag(ReferenceTable[i], "skip")
            elseif HasTag(ReferenceTable[i], "on") then
                for j = 1, #containerTableLightsNormal[i] do
                    SetShapeEmissiveScale(containerTableLightsNormal[i][j], 0)
                    if HasTag(containerTableLightsNormal[i][j], "inv") then
                        SetTag(containerTableLightsNormal[i][j], "invisible")
                    end
                end
                RemoveTag(ReferenceTable[i], "skip")
                RemoveTag(ReferenceTable[i], "on")
            end
        end
        --fog light end

        --adtional normal
        if HasTag(ReferenceTable[i], "AD") then
            if Aditional then
                for j = 1, #containerTableLightsNormal[i] do
                    SetShapeEmissiveScale(containerTableLightsNormal[i][j], 1)
                    local light = GetShapeLights(containerTableLightsNormal[i][j])
                    for i = 1, #light do
                        SetLightIntensity(light[i], GetFloat("ALS.Aditional") / 5)
                    end
                    if HasTag(containerTableLightsNormal[i][j], "inv") then
                        RemoveTag(containerTableLightsNormal[i][j], "invisible")
                    end
                    RemoveFromTable(lightShapesEM, containerTableLightsNormal[i][j])
                end
                SetTag(ReferenceTable[i], "on")
                SetTag(ReferenceTable[i], "skip")
            elseif HasTag(ReferenceTable[i], "on") then
                for j = 1, #containerTableLightsNormal[i] do
                    SetShapeEmissiveScale(containerTableLightsNormal[i][j], 0)
                    if HasTag(containerTableLightsNormal[i][j], "inv") then
                        SetTag(containerTableLightsNormal[i][j], "invisible")
                    end
                    table.insert(lightShapesEM, containerTableLightsNormal[i][j])
                end
                RemoveTag(ReferenceTable[i], "skip")
                RemoveTag(ReferenceTable[i], "on")
            end
        end
        --aditional end

        --reverse normal
        if HasTag(ReferenceTable[i], "RL") then
            if forceback then
                counter = 2
                for j = 1, #containerTableLightsNormal[i] do
                    SetTag(ReferenceTable[i], "on")
                    SetShapeEmissiveScale(containerTableLightsNormal[i][j], 1)
                    local light = GetShapeLights(containerTableLightsNormal[i][j])
                    for i = 1, #light do
                        SetLightIntensity(light[i], GetFloat("ALS.Reverse") / 50)
                    end
                    if HasTag(containerTableLightsNormal[i][j], "inv") then
                        RemoveTag(containerTableLightsNormal[i][j], "invisible")
                    end
                    RemoveFromTable(lightShapesEM, containerTableLightsNormal[i][j])
                    SetTag(ReferenceTable[i], "skip")
                end
            else
                if HasTag(ReferenceTable[i], "on") then
                    for j = 1, #containerTableLightsNormal[i] do
                        SetShapeEmissiveScale(containerTableLightsNormal[i][j], 0)
                        table.insert(lightShapesEM, containerTableLightsNormal[i][j])
                        if HasTag(containerTableLightsNormal[i][j], "inv") then
                            SetTag(containerTableLightsNormal[i][j], "invisible")
                        end
                    end
                    RemoveTag(ReferenceTable[i], "skip")
                    RemoveTag(ReferenceTable[i], "on")
                end
            end
        end
        --reverse end

        --blinkers normal
        if HasTag(ReferenceTable[i], "B") then
            if Blinker then
                for j = 1, #containerTableLightsNormal[i] do
                    if not Time then
                        if Right or Razard then
                            if GetTagValue(containerTableLightsNormal[i][j], "ALSLight") == "R1" then
                                SetShapeEmissiveScale(containerTableLightsNormal[i][j], 0.5)
                                local light = GetShapeLights(containerTableLightsNormal[i][j])
                                for i = 1, #light do
                                    SetLightIntensity(light[i], GetFloat("ALS.Blinkers") / 40)
                                end
                                if HasTag(containerTableLightsNormal[i][j], "inv") then
                                    RemoveTag(containerTableLightsNormal[i][j], "invisible")
                                end
                            end
                        else
                            if GetTagValue(containerTableLightsNormal[i][j], "ALSLight") == "R1" then
                                SetShapeEmissiveScale(containerTableLightsNormal[i][j], 0)
                                if HasTag(containerTableLightsNormal[i][j], "inv") then
                                    SetTag(containerTableLightsNormal[i][j], "invisible")
                                end
                            end
                        end
                        if Left or Razard then
                            if GetTagValue(containerTableLightsNormal[i][j], "ALSLight") == "L1" then
                                SetShapeEmissiveScale(containerTableLightsNormal[i][j], 0.5)
                                local light = GetShapeLights(containerTableLightsNormal[i][j])
                                for i = 1, #light do
                                    SetLightIntensity(light[i], GetFloat("ALS.Blinkers") / 40)
                                end
                                if HasTag(containerTableLightsNormal[i][j], "inv") then
                                    RemoveTag(containerTableLightsNormal[i][j], "invisible")
                                end
                            end
                        else
                            if GetTagValue(containerTableLightsNormal[i][j], "ALSLight") == "L1" then
                                SetShapeEmissiveScale(containerTableLightsNormal[i][j], 0)
                                if HasTag(containerTableLightsNormal[i][j], "inv") then
                                    SetTag(containerTableLightsNormal[i][j], "invisible")
                                end
                            end
                        end
                    else
                        if HasTag(containerTableLightsNormal[i][j], "inv") then
                            SetTag(containerTableLightsNormal[i][j], "invisible")
                        end
                        SetShapeEmissiveScale(containerTableLightsNormal[i][j], 0)
                    end
                    SetTag(ReferenceTable[i], "on")
                    RemoveFromTable(lightShapesEM, containerTableLightsNormal[i][j])
                end
                SetTag(ReferenceTable[i], "skip")
            elseif HasTag(ReferenceTable[i], "on") then
                for j = 1, #containerTableLightsNormal[i] do
                    SetShapeEmissiveScale(containerTableLightsNormal[i][j], 0)
                    if HasTag(containerTableLightsNormal[i][j], "inv") then
                        SetTag(containerTableLightsNormal[i][j], "invisible")
                    end
                end
            end
        end
        --blinkers normal end

        --Back light normal
        if HasTag(ReferenceTable[i], "BL") then
            local typeValue = GetTagValue(ReferenceTable[i], "type")
            if typeValue == "1" then
                if HeadLight or HighBeamTemp then
                    for j = 1, #containerTableLightsNormal[i] do
                        SetShapeEmissiveScale(containerTableLightsNormal[i][j], 1)
                        local light = GetShapeLights(containerTableLightsNormal[i][j])
                        for i = 1, #light do
                            SetLightIntensity(light[i], GetFloat("ALS.back") / 50)
                        end
                        if HasTag(containerTableLightsNormal[i][j], "inv") then
                            RemoveTag(containerTableLightsNormal[i][j], "invisible")
                        end
                    end
                    SetTag(ReferenceTable[i], "on")
                    SetTag(ReferenceTable[i], "skip")
                    RemoveFromTable(lightShapesEM, containerTableLightsNormal[i][j])
                elseif HasTag(ReferenceTable[i], "on") then
                    for j = 1, #containerTableLightsNormal[i] do
                        SetShapeEmissiveScale(containerTableLightsNormal[i][j], 0)
                        if HasTag(containerTableLightsNormal[i][j], "inv") then
                            SetTag(containerTableLightsNormal[i][j], "invisible")
                        end
                        table.insert(lightShapesEM, containerTableLightsNormal[i][j])
                        RemoveTag(ReferenceTable[i], "skip")
                        RemoveTag(ReferenceTable[i], "on")
                    end
                end
            elseif typeValue == "2" then
                for j = 1, #containerTableLightsNormal[i] do
                    if Blinker then
                        SetTag(ReferenceTable[i], "on")
                        SetTag(ReferenceTable[i], "skip")
                        RemoveFromTable(lightShapesEM, containerTableLightsNormal[i][j])
                    end

                    if Blinker and not Time then
                        if HeadLight or HighBeamTemp then
                            SetShapeEmissiveScale(containerTableLightsNormal[i][j], 0.5)
                            local light = GetShapeLights(containerTableLightsNormal[i][j])
                            for i = 1, #light do
                                SetLightIntensity(light[i], GetFloat("ALS.back") / 40)
                            end
                            if HasTag(containerTableLightsNormal[i][j], "inv") then
                                RemoveTag(containerTableLightsNormal[i][j], "invisible")
                            end
                        else
                            if HasTag(containerTableLightsNormal[i][j], "inv") then
                                SetTag(containerTableLightsNormal[i][j], "invisible")
                            end
                            SetShapeEmissiveScale(containerTableLightsNormal[i][j], 0)
                        end
                        if GetTagValue(containerTableLightsNormal[i][j], "ALSLight") == "R1" and Right or Razard then
                            SetShapeEmissiveScale(containerTableLightsNormal[i][j], 1)
                            local light = GetShapeLights(containerTableLightsNormal[i][j])
                            for i = 1, #light do
                                SetLightIntensity(light[i], GetFloat("ALS.Blinkers") / 40)
                            end
                            if HasTag(containerTableLightsNormal[i][j], "inv") then
                                RemoveTag(containerTableLightsNormal[i][j], "invisible")
                            end
                        end
                        if GetTagValue(containerTableLightsNormal[i][j], "ALSLight") == "L1" and Left or Razard then
                            SetShapeEmissiveScale(containerTableLightsNormal[i][j], 1)
                            local light = GetShapeLights(containerTableLightsNormal[i][j])
                            for i = 1, #light do
                                SetLightIntensity(light[i], GetFloat("ALS.Blinkers") / 40)
                            end
                            if HasTag(containerTableLightsNormal[i][j], "inv") then
                                RemoveTag(containerTableLightsNormal[i][j], "invisible")
                            end
                        end
                        RemoveFromTable(lightShapesEM, containerTableLightsNormal[i][j])
                    elseif HeadLight or HighBeamTemp then
                        SetTag(ReferenceTable[i], "on")
                        SetTag(ReferenceTable[i], "skip")
                        RemoveFromTable(lightShapesEM, containerTableLightsNormal[i][j])
                        SetShapeEmissiveScale(containerTableLightsNormal[i][j], 0.5)
                        local light = GetShapeLights(containerTableLightsNormal[i][j])
                        for i = 1, #light do
                            SetLightIntensity(light[i], GetFloat("ALS.back") / 40)
                        end
                        if HasTag(containerTableLightsNormal[i][j], "inv") then
                            RemoveTag(containerTableLightsNormal[i][j], "invisible")
                        end
                    elseif HasTag(ReferenceTable[i], "on") then
                        for j = 1, #containerTableLightsNormal[i] do
                            SetShapeEmissiveScale(containerTableLightsNormal[i][j], 0)
                            table.insert(lightShapesEM, containerTableLightsNormal[i][j])
                            if HasTag(containerTableLightsNormal[i][j], "inv") then
                                SetTag(containerTableLightsNormal[i][j], "invisible")
                            end
                            if not Blinker then
                                RemoveTag(ReferenceTable[i], "skip")
                            end
                            RemoveTag(ReferenceTable[i], "on")
                        end
                    end
                end
            end
        end
        --back light normal end

        --brake light normal
        if HasTag(ReferenceTable[i], "BRL") then
            local typeValue = GetTagValue(ReferenceTable[i], "type")
            if typeValue == "1" then
                if brake then
                    for j = 1, #containerTableLightsNormal[i] do
                        SetShapeEmissiveScale(containerTableLightsNormal[i][j], 1)
                        local light = GetShapeLights(containerTableLightsNormal[i][j])
                        for i = 1, #light do
                            SetLightIntensity(light[i], GetFloat("ALS.Brake") / 50)
                        end
                        if HasTag(containerTableLightsNormal[i][j], "inv") then
                            RemoveTag(containerTableLightsNormal[i][j], "invisible")
                        end
                    end
                    SetTag(ReferenceTable[i], "on")
                    SetTag(ReferenceTable[i], "skip")
                    RemoveFromTable(lightShapesEM, containerTableLightsNormal[i][j])
                elseif HasTag(ReferenceTable[i], "on") then
                    for j = 1, #containerTableLightsNormal[i] do
                        SetShapeEmissiveScale(containerTableLightsNormal[i][j], 0)
                        if HasTag(containerTableLightsNormal[i][j], "inv") then
                            SetTag(containerTableLightsNormal[i][j], "invisible")
                        end
                        table.insert(lightShapesEM, containerTableLightsNormal[i][j])
                        RemoveTag(ReferenceTable[i], "skip")
                        RemoveTag(ReferenceTable[i], "on")
                    end
                end
            elseif typeValue == "2" then
                for j = 1, #containerTableLightsNormal[i] do
                    if Blinker then
                        SetTag(ReferenceTable[i], "on")
                        SetTag(ReferenceTable[i], "skip")
                        RemoveFromTable(lightShapesEM, containerTableLightsNormal[i][j])
                    end

                    if Blinker then
                        if brake and GetTagValue(containerTableLightsNormal[i][j], "ALSLight") == "L1" and Right then
                            SetShapeEmissiveScale(containerTableLightsNormal[i][j], 1)
                            local light = GetShapeLights(containerTableLightsNormal[i][j])
                            for i = 1, #light do
                                SetLightIntensity(light[i], GetFloat("ALS.Brake") / 40)
                            end
                            if HasTag(containerTableLightsNormal[i][j], "inv") then
                                RemoveTag(containerTableLightsNormal[i][j], "invisible")
                            end
                        else
                            SetShapeEmissiveScale(containerTableLightsNormal[i][j], 0)
                            if HasTag(containerTableLightsNormal[i][j], "inv") then
                                SetTag(containerTableLightsNormal[i][j], "invisible")
                            end
                        end
                        if brake and GetTagValue(containerTableLightsNormal[i][j], "ALSLight") == "R1" and Left then
                            SetShapeEmissiveScale(containerTableLightsNormal[i][j], 1)
                            local light = GetShapeLights(containerTableLightsNormal[i][j])
                            for i = 1, #light do
                                SetLightIntensity(light[i], GetFloat("ALS.Brake") / 40)
                            end
                            if HasTag(containerTableLightsNormal[i][j], "inv") then
                                RemoveTag(containerTableLightsNormal[i][j], "invisible")
                            end
                        end

                        if GetTagValue(containerTableLightsNormal[i][j], "ALSLight") == "R1" and Right and not Time or Razard and not Time then
                            SetShapeEmissiveScale(containerTableLightsNormal[i][j], 1)
                            local light = GetShapeLights(containerTableLightsNormal[i][j])
                            for i = 1, #light do
                                SetLightIntensity(light[i], GetFloat("ALS.Blinkers") / 40)
                            end
                            if HasTag(containerTableLightsNormal[i][j], "inv") then
                                RemoveTag(containerTableLightsNormal[i][j], "invisible")
                            end
                        end
                        if GetTagValue(containerTableLightsNormal[i][j], "ALSLight") == "L1" and Left and not Time or Razard and not Time then
                            SetShapeEmissiveScale(containerTableLightsNormal[i][j], 1)
                            local light = GetShapeLights(containerTableLightsNormal[i][j])
                            for i = 1, #light do
                                SetLightIntensity(light[i], GetFloat("ALS.Blinkers") / 40)
                            end
                            if HasTag(containerTableLightsNormal[i][j], "inv") then
                                RemoveTag(containerTableLightsNormal[i][j], "invisible")
                            end
                        end
                        RemoveFromTable(lightShapesEM, containerTableLightsNormal[i][j])
                    elseif brake and not Blinker then
                        SetTag(ReferenceTable[i], "on")
                        SetTag(ReferenceTable[i], "skip")
                        RemoveFromTable(lightShapesEM, containerTableLightsNormal[i][j])
                        SetShapeEmissiveScale(containerTableLightsNormal[i][j], 1)
                        local light = GetShapeLights(containerTableLightsNormal[i][j])
                        for i = 1, #light do
                            SetLightIntensity(light[i], GetFloat("ALS.Brake") / 40)
                        end
                        if HasTag(containerTableLightsNormal[i][j], "inv") then
                            RemoveTag(containerTableLightsNormal[i][j], "invisible")
                        end
                    elseif HasTag(ReferenceTable[i], "on") then
                        for j = 1, #containerTableLightsNormal[i] do
                            SetShapeEmissiveScale(containerTableLightsNormal[i][j], 0)
                            if HasTag(containerTableLightsNormal[i][j], "inv") then
                                SetTag(containerTableLightsNormal[i][j], "invisible")
                            end
                            table.insert(lightShapesEM, containerTableLightsNormal[i][j])
                            if not Blinker then
                                RemoveTag(ReferenceTable[i], "skip")
                            end
                            RemoveTag(ReferenceTable[i], "on")
                        end
                    end
                end
            elseif typeValue == "3" then
                for j = 1, #containerTableLightsNormal[i] do
                    if Blinker then
                        SetTag(ReferenceTable[i], "on")
                        SetTag(ReferenceTable[i], "skip")
                        RemoveFromTable(lightShapesEM, containerTableLightsNormal[i][j])
                    end

                    if Blinker then
                        if HeadLight or HighBeamTemp then
                            SetShapeEmissiveScale(containerTableLightsNormal[i][j], 0.5)
                            local light = GetShapeLights(containerTableLightsNormal[i][j])
                            for i = 1, #light do
                                SetLightIntensity(light[i], GetFloat("ALS.back") / 40)
                            end
                            if HasTag(containerTableLightsNormal[i][j], "inv") then
                                RemoveTag(containerTableLightsNormal[i][j], "invisible")
                            end
                        else
                            SetShapeEmissiveScale(containerTableLightsNormal[i][j], 0)
                            if HasTag(containerTableLightsNormal[i][j], "inv") then
                                SetTag(containerTableLightsNormal[i][j], "invisible")
                            end
                        end

                        if brake and GetTagValue(containerTableLightsNormal[i][j], "ALSLight") == "L1" and Right then
                            SetShapeEmissiveScale(containerTableLightsNormal[i][j], 1)
                            local light = GetShapeLights(containerTableLightsNormal[i][j])
                            for i = 1, #light do
                                SetLightIntensity(light[i], GetFloat("ALS.Brake") / 40)
                            end
                            if HasTag(containerTableLightsNormal[i][j], "inv") then
                                RemoveTag(containerTableLightsNormal[i][j], "invisible")
                            end
                        end
                        if brake and GetTagValue(containerTableLightsNormal[i][j], "ALSLight") == "R1" and Left then
                            SetShapeEmissiveScale(containerTableLightsNormal[i][j], 1)
                            local light = GetShapeLights(containerTableLightsNormal[i][j])
                            for i = 1, #light do
                                SetLightIntensity(light[i], GetFloat("ALS.Brake") / 40)
                            end
                            if HasTag(containerTableLightsNormal[i][j], "inv") then
                                RemoveTag(containerTableLightsNormal[i][j], "invisible")
                            end
                        end

                        if GetTagValue(containerTableLightsNormal[i][j], "ALSLight") == "R1" and Right and not Time or Razard and not Time then
                            SetShapeEmissiveScale(containerTableLightsNormal[i][j], 1)
                            local light = GetShapeLights(containerTableLightsNormal[i][j])
                            for i = 1, #light do
                                SetLightIntensity(light[i], GetFloat("ALS.Blinkers") / 40)
                            end
                            if HasTag(containerTableLightsNormal[i][j], "inv") then
                                RemoveTag(containerTableLightsNormal[i][j], "invisible")
                            end
                        end
                        if GetTagValue(containerTableLightsNormal[i][j], "ALSLight") == "L1" and Left and not Time or Razard and not Time then
                            SetShapeEmissiveScale(containerTableLightsNormal[i][j], 1)
                            local light = GetShapeLights(containerTableLightsNormal[i][j])
                            for i = 1, #light do
                                SetLightIntensity(light[i], GetFloat("ALS.Blinkers") / 40)
                            end
                            if HasTag(containerTableLightsNormal[i][j], "inv") then
                                RemoveTag(containerTableLightsNormal[i][j], "invisible")
                            end
                        end
                        RemoveFromTable(lightShapesEM, containerTableLightsNormal[i][j])
                    elseif brake and not Blinker then
                        SetTag(ReferenceTable[i], "on")
                        SetTag(ReferenceTable[i], "skip")
                        RemoveFromTable(lightShapesEM, containerTableLightsNormal[i][j])
                        SetShapeEmissiveScale(containerTableLightsNormal[i][j], 1)
                        local light = GetShapeLights(containerTableLightsNormal[i][j])
                        for i = 1, #light do
                            SetLightIntensity(light[i], GetFloat("ALS.Brake") / 40)
                        end
                        if HasTag(containerTableLightsNormal[i][j], "inv") then
                            RemoveTag(containerTableLightsNormal[i][j], "invisible")
                        end
                    elseif HeadLight or HighBeamTemp then
                        SetTag(ReferenceTable[i], "on")
                        SetTag(ReferenceTable[i], "skip")
                        RemoveFromTable(lightShapesEM, containerTableLightsNormal[i][j])
                        SetShapeEmissiveScale(containerTableLightsNormal[i][j], 0.5)
                        local light = GetShapeLights(containerTableLightsNormal[i][j])
                        for i = 1, #light do
                            SetLightIntensity(light[i], GetFloat("ALS.back") / 40)
                        end
                        if HasTag(containerTableLightsNormal[i][j], "inv") then
                            RemoveTag(containerTableLightsNormal[i][j], "invisible")
                        end
                    elseif HasTag(ReferenceTable[i], "on") then
                        for j = 1, #containerTableLightsNormal[i] do
                            SetShapeEmissiveScale(containerTableLightsNormal[i][j], 0)
                            if HasTag(containerTableLightsNormal[i][j], "inv") then
                                SetTag(containerTableLightsNormal[i][j], "invisible")
                            end
                            table.insert(lightShapesEM, containerTableLightsNormal[i][j])
                            if not Blinker then
                                RemoveTag(ReferenceTable[i], "skip")
                            end
                            RemoveTag(ReferenceTable[i], "on")
                        end
                    end
                end
            elseif typeValue == "4" then
                for j = 1, #containerTableLightsNormal[i] do

                   
                    if brake then
                        SetTag(ReferenceTable[i], "on")
                        SetTag(ReferenceTable[i], "skip")
                        RemoveFromTable(lightShapesEM, containerTableLightsNormal[i][j])
                        SetShapeEmissiveScale(containerTableLightsNormal[i][j], 1)
                        local light = GetShapeLights(containerTableLightsNormal[i][j])
                        for i = 1, #light do
                            SetLightIntensity(light[i], GetFloat("ALS.Brake") / 40)
                        end
                        if HasTag(containerTableLightsNormal[i][j], "inv") then
                            RemoveTag(containerTableLightsNormal[i][j], "invisible")
                        end
                    elseif HeadLight or HighBeamTemp then
                        SetTag(ReferenceTable[i], "on")
                        SetTag(ReferenceTable[i], "skip")
                        RemoveFromTable(lightShapesEM, containerTableLightsNormal[i][j])
                        SetShapeEmissiveScale(containerTableLightsNormal[i][j], 0.5)
                        local light = GetShapeLights(containerTableLightsNormal[i][j])
                        for i = 1, #light do
                            SetLightIntensity(light[i], GetFloat("ALS.back") / 40)
                        end
                        if HasTag(containerTableLightsNormal[i][j], "inv") then
                            RemoveTag(containerTableLightsNormal[i][j], "invisible")
                        end
                    elseif HasTag(ReferenceTable[i], "on") then
                        for j = 1, #containerTableLightsNormal[i] do
                            SetShapeEmissiveScale(containerTableLightsNormal[i][j], 0)
                            if HasTag(containerTableLightsNormal[i][j], "inv") then
                                SetTag(containerTableLightsNormal[i][j], "invisible")
                            end
                            table.insert(lightShapesEM, containerTableLightsNormal[i][j])
                            if not Blinker then
                                RemoveTag(ReferenceTable[i], "skip")
                            end
                            RemoveTag(ReferenceTable[i], "on")
                        end
                    end
                end
            end
        end
        --Brake light normal end
    end
end

local valor_anterior = nil
function verificar_mudanca(valor_atual)
    if valor_anterior == nil then
        -- Se for a primeira vez, apenas armazene o valor atual
        valor_anterior = valor_atual
        return false
    elseif valor_anterior ~= valor_atual then
        -- Se o valor atual for diferente do valor anterior, houve uma mudança
        valor_anterior = valor_atual
        return true
    else
        -- Não houve mudança
        return false
    end
end

-- Function to handle each frame tick
function tick(dt)
    -- Set the lights to the luminosity chosen on the menu
    --if this is on the init, if the car is already on the map, the ligths wont update
    if not first then
        for i = 1, #ReferenceTable do
            if HasTag(ReferenceTable[i], "FL") then
                local typeValue = GetTagValue(ReferenceTable[i], "type")
                for j = 1, #containerTableLightsNormal[i] do
                    local light = GetShapeLights(containerTableLightsNormal[i][j])
                    for i = 1, #light do
                        SetLightIntensity(light[i], GetFloat("lightsf") / 5)
                    end
                end
            end
            if HasTag(ReferenceTable[i], "HL") then
                local typeValue = GetTagValue(ReferenceTable[i], "type")
                for j = 1, #containerTableLightsNormal[i] do
                    local light = GetShapeLights(containerTableLightsNormal[i][j])
                    for k = 1, #light do
                        if GetTagValue(light[k], "type") == "1" then
                            SetLightIntensity(light[k], GetFloat("lightsf") / 5)
                        end
                    end
                end
                if HasTag(ReferenceTable[i], "BL") then
                    local typeValue = GetTagValue(ReferenceTable[i], "type")
                    for j = 1, #containerTableLightsNormal[i] do
                        local light = GetShapeLights(containerTableLightsNormal[i][j])
                        for k = 1, #light do
                            SetLightIntensity(light[i], GetFloat("lightst") / 50)
                        end
                    end
                end
            end

            for j = 1, #containerTableLightsNormal[i] do
                local light = GetShapeLights(containerTableLightsNormal[i][j])
                for k = 1, #light do
                    if GetTagValue(light[k], "type") == "2" then
                        SetLightIntensity(light[k], 0)
                    end
                    RemoveFromTable(lights, light[k])
                end
            end
        end
    end



    if GetBool("ALS.LightIntensity") or not first then
        for i = 1, #lights do
            SetLightIntensity(lights[i], GetFloat("EmLights") / 10)
        end
        first = true
    end


    --//car alarm//--
    alarmcar = HasTag(Vehicle, "alarm")

    if not HasTag(findvehicle, "quantdoor") then
        SetTag(findvehicle, "quantdoor", "0")
        SetTag(findvehicle, "quanttrunk", "0")
        SetTag(findvehicle, "quanthood", "0")
    end



    if InternalLight then
        lastquantdoor = quantdoor
        quantdoor = tonumber(string.sub(GetTagValue(findvehicle, "quantdoor"), 0, 1))
        if quantdoor ~= lastquantdoor then
            OnOffLightDoor = true
        end
        if OnOffLightDoor then
            OnOffLightDoor = InternalLightssOnOff(InternalLights, 1, quantdoor, dt)
        end
    end

    if TrunkLight then
        lastquanttrunk = quanttrunk
        quanttrunk = tonumber(string.sub(GetTagValue(findvehicle, "quanttrunk"), 0, 1))
        if quanttrunk ~= lastquanttrunk then
            OnOffLightTrunk = true
        end
        if OnOffLightTrunk then
            OnOffLightTrunk = InternalLightssOnOff(TrunkLights, 2, quanttrunk, dt)
        end
    end


    if HasTag(findvehicle, "lock") and notlock == false then
        if HasTag(findvehicle, "PlayOn") then
            local Shape = GetShapeWorldTransform(chimepos)
            local alarmsound = tonumber(string.sub(GetTagValue(findvehicle, "lock"), 0, 1))
            PlaySound(alarmOnList[alarmsound], Shape.pos, 0.5)
            RemoveTag(findvehicle, "PlayOn")
            turnofflights = true
            piscatemp = true
            Time = false
            SetTag(Vehicle, "B", 3)
            SetTag(Vehicle, "lightupdate")
            frame1 = 0
            gethealth = GetVehicleHealth(Vehicle)
            for i = 1, #ALSdoors do
                gethealthdoor[i] = IsBodyBroken(ALSdoors[i])
            end
            if FoldingMirror then
                for i = 1, #FoldingMirrors do
                    SetJointMotorTarget(FoldingMirrors[i], GetTagValue(FoldingMirrors[i], "mirror"),
                        GetTagValue(FoldingMirrors[i], "speed"))
                end
            end
        end

        for i = 1, #Vehicles do
            if GetPlayerVehicle() == Vehicles[i] then
                SetTag(Vehicle, "alarm")
            end
        end

        for i = 1, #ALSdoors do
            if IsBodyBroken(ALSdoors[i]) ~= gethealthdoor[i] then
                SetTag(Vehicle, "alarm")
            end
        end

        if HasTag(findvehicle, "quanttrunk") or GetPlayerVehicle() == Vehicles then
            local quanttrunk = tonumber(string.sub(GetTagValue(findvehicle, "quanttrunk"), 0, 1))
            if quanttrunk > 0 or GetPlayerVehicle() == Vehicle then
                SetTag(Vehicle, "alarm")
            end
        end
        if HasTag(findvehicle, "quanthood") or GetPlayerVehicle() == Vehicles then
            local quanttrunk = tonumber(string.sub(GetTagValue(findvehicle, "quanthood"), 0, 1))
            if quanttrunk > 0 or GetPlayerVehicle() == Vehicle then
                SetTag(Vehicle, "alarm")
            end
        end
        if HasTag(findvehicle, "quantdoor") or GetPlayerVehicle() == Vehicle then
            local quantdoor = tonumber(string.sub(GetTagValue(findvehicle, "quantdoor"), 0, 1))
            if quantdoor > 0 or GetPlayerVehicle() == Vehicle then
                SetTag(Vehicle, "alarm")
            end
        end
        if GetVehicleHealth(Vehicle) ~= gethealth then
            SetTag(Vehicle, "alarm")
        end
    elseif HasTag(findvehicle, "quantdoor") or HasTag(findvehicle, "quanttrunk") or HasTag(findvehicle, "quanthood") then
        local quantdoor = tonumber(string.sub(GetTagValue(findvehicle, "quantdoor"), 0, 1))
        local quanttrunk = tonumber(string.sub(GetTagValue(findvehicle, "quanttrunk"), 0, 1))
        local quanthood = tonumber(string.sub(GetTagValue(findvehicle, "quanthood"), 0, 1))
        if quantdoor > 0 or quanttrunk > 0 or quanthood > 0 then
            notlock = true
            RemoveTag(findvehicle, "lock")
        else
            notlock = false
        end
    end

    if not HasTag(findvehicle, "lock") then
        if HasTag(findvehicle, "PlayOff") then
            local Shape = GetShapeWorldTransform(chimepos)
            local alarmsound = tonumber(string.sub(GetTagValue(findvehicle, "PlayOff"), 0, 1))
            PlaySound(alarmOffList[alarmsound], Shape.pos, 0.5)
            RemoveTag(findvehicle, "PlayOff")
            turnofflights = false
            piscatemp = false
            piscatemp2 = true
            Time = false
            frame1 = 0
            SetTag(Vehicle, "p", 3)
            SetTag(Vehicle, "lightupdate")
            for i = 1, #alarmlight do
                SetShapeEmissiveScale(alarmlight[i], 0)
            end
        end
        if HasTag(Vehicle, "alarm") then
            RemoveTag(Vehicle, "alarm")
        end
        if FoldingMirror then
            for i = 1, #FoldingMirrors do
                SetJointMotorTarget(FoldingMirrors[i], 0, GetTagValue(FoldingMirrors[i], "speed"))
            end
        end
    end

    --car chime
    if HeadLight or Aditional or GetPlayerVehicle() == Vehicle then
        if HasTag(findvehicle, "quantdoor") then
            local quantdoor = tonumber(string.sub(GetTagValue(findvehicle, "quantdoor"), 0, 1))
            if quantdoor > 0 then
                local Shape = GetShapeWorldTransform(chimepos)
                local chime = tonumber(string.sub(GetTagValue(findvehicle, "chime"), 0, 1))
                PlayLoop(chimeList[chime], Shape.pos, GetFloat("ALS.Chime") / 500)
            end
        end
    end
    --alarmsound
    if HasTag(Vehicle, "alarm") then
        local Shape = GetShapeWorldTransform(chimepos)
        local alarm = tonumber(string.sub(GetTagValue(findvehicle, "lock"), 0, 1))
        PlayLoop(alarmList[alarm], Shape.pos, GetFloat("ALS.alarm") / 500)
        if FoldingMirror then
            for i = 1, #FoldingMirrors do
                SetJointMotorTarget(FoldingMirrors[i], 0, GetTagValue(FoldingMirrors[i], "speed"))
            end
        end
    end


    if Blinker or alarmcar or HasTag(findvehicle, "lock") and notlock == false or piscatemp2 then
        period1 = 50

        frame1 = frame1 + dt * 60
        if alarmcar then
            period1 = 24
        elseif piscatemp then
            period1 = 40
        elseif piscatemp2 then
            period1 = 80
        elseif HasTag(findvehicle, "lock") then
            period1 = 200
        end

        t1 = math.ceil(frame1) % period1

        if alarmcar then
            if frame1 > 0 then
                Time = false
                SetTag(Vehicle, "B", 3)
                SetTag(Vehicle, "lightupdate")
            end
            if frame1 > period1 / 2 then
                Time = true
                SetTag(Vehicle, "lightupdate")
            end
        elseif piscatemp then
            if frame1 > period1 then
                piscatemp = false
                piscatemp2 = false
                RemoveTag(Vehicle, "B")
                SetTag(Vehicle, "lightupdate")
            end
        elseif piscatemp2 then
            if frame1 > 0 then
                Time = false
                SetTag(Vehicle, "B", 3)
                SetTag(Vehicle, "lightupdate")
            end
            if frame1 > 10 then
                Time = true
                SetTag(Vehicle, "lightupdate")
            end
            if frame1 > 20 then
                Time = false
                SetTag(Vehicle, "lightupdate")
            end

            if frame1 > 30 then
                Time = true
                SetTag(Vehicle, "lightupdate")
            end

            if frame1 > 40 then
                Time = false
                SetTag(Vehicle, "lightupdate")
            end

            if frame1 > 50 then
                Time = true
                RemoveTag(Vehicle, "B")
                SetTag(Vehicle, "lightupdate")
            end


            if frame1 > period1 then
                piscatemp2 = false
            end
        else
            if frame1 > period1 then
                frame1 = 0
            end
        end

        if frame1 > period1 and not piscatemp2 then
            frame1 = 0
            piscatemp = false
            piscatemp2 = false
        end


        if Blinker and not piscatemp2 and not piscatemp then
            if t1 == 1 then
                SetTag(Vehicle, "lightupdate")
                Time = false
                turnOff2 = true
            end

            if t1 == period1 / 2 then
                SetTag(Vehicle, "lightupdate")
                Time = true
            end
        end


        if HasTag(findvehicle, "lock") and notlock == false then
            if t1 <= period1 / 4 then
                for i = 1, #alarmlight do
                    SetShapeEmissiveScale(alarmlight[i], 1)
                end
            else
                for i = 1, #alarmlight do
                    SetShapeEmissiveScale(alarmlight[i], 0)
                end
            end
        end
    elseif turnOff2 then
        Time = false
        turnOff2 = false
        frame1 = 0
    end


    if GetPlayerVehicle() == Vehicle then
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


        if InputPressed("down") then
            counter = counter + 1
        end


        if InputPressed("up") then
            counter = 0
        end



        if InputDown("handbrake") or InputDown("down") and correntKmh > 2 or InputDown("up") and correntKmh < -20 then
            if not forceback or InputDown("handbrake") then
                brakepress = true
            end
        else
            brakepress = false
        end

        if verificar_mudanca(brakepress) then
            SetTag(Vehicle, "lightupdate")
        end

        anteriorfreio = brakepress

        if anterior ~= forceback then
            SetTag(Vehicle, "lightupdate")
        end

        anterior = forceback

        if correntKmh < 2 and InputDown("down") and counter >= 1 then
            forceback = true
        else
            forceback = false
        end

        if counter >= 2 then
            counter = 2
            forceback = true
        end
    elseif brakepress or forceback or HighBeamTemp then
        counter = 0
        forceback = false
        brakepress = false
        RemoveTag(Vehicle, "HBT")
        SetTag(Vehicle, "lightupdate")
    end

    --update the state of lights
    if HasTag(Vehicle, "lightupdate") then
        NormalLight(Vehicle, Time, forceback, brakepress)
        Blinker = HasTag(Vehicle, "B")
        Right = GetTagValue(Vehicle, "B") == "1"
        Left = GetTagValue(Vehicle, "B") == "2"
        Razard = GetTagValue(Vehicle, "B") == "3"

        RemoveTag(Vehicle, "lightupdate")
    end


    --//play audio//--
    if HasTag(findvehicle, "Horn") then
        ALS_PlaySound(findvehicle, honkList, hornpos)
    end




    if GetVehicleHealth(Vehicle) ~= gethealth2 then
        for i = 1, #BodyLight do
            local all = GetJointedBodies(BodyLight[i])
            if #all < 4 then
                Delete(BodyLight[i])
            end
        end

        if InternalLights then
            for i = 1, #InternalLights do
                body = GetShapeBody(InternalLights[i], true)
                local all = GetJointedBodies(body)
                if #all < 4 then
                    Delete(body)
                end
            end
        end
        if TrunkLights then
            for i = 1, #TrunkLights do
                body = GetShapeBody(TrunkLights[i], true)
                local all = GetJointedBodies(body)
                if #all < 4 then
                    Delete(body)
                end
            end
        end

        for i = 1, #alarmlight do
            body = GetShapeBody(alarmlight[i], true)
            local all = GetJointedBodies(body)
            if #all < 4 then
                Delete(body)
            end
        end

        if GetVehicleHealth(Vehicle) == 0 then
            destroyed = true
            for i = 1, #lightShapesEM do
                SetShapeEmissiveScale(lightShapesEM[i], 0)
            end
            for i = 1, #lights do
                SetLightIntensity(lights[i], 0)
            end
        end
    end

    gethealth2 = GetVehicleHealth(Vehicle)
end

local currentBrightness = {} -- tabela para rastrear o brilho atual de cada grupo de luzes
local transitionTime = 1     -- tempo total para a transição, em segundos

function InternalLightssOnOff(lights, groupID, status, dt)
    local isAnimating = false

    if not currentBrightness[groupID] then
        currentBrightness[groupID] = {}
    end

    for i = 1, #lights do
        if not currentBrightness[groupID][i] then
            currentBrightness[groupID][i] = 0
        end

        if status > 0 then
            -- Acender as luzes gradualmente
            if currentBrightness[groupID][i] < 1 then
                currentBrightness[groupID][i] = currentBrightness[groupID][i] + (dt / transitionTime)
                if currentBrightness[groupID][i] > 1 then
                    currentBrightness[groupID][i] = 1
                end
                isAnimating = true
            end
        else
            -- Desligar as luzes gradualmente
            if currentBrightness[groupID][i] > 0 then
                currentBrightness[groupID][i] = currentBrightness[groupID][i] - (dt / transitionTime)
                if currentBrightness[groupID][i] < 0 then
                    currentBrightness[groupID][i] = 0
                end
                isAnimating = true
            end
        end

        SetShapeEmissiveScale(lights[i], currentBrightness[groupID][i])
    end

    return isAnimating
end

-- Function to update lights based on animation time
function updateLights(index, lightTime, ContainerShape, ConteinerLight)
    local LightType = GetTagValue(ReferenceTableEm[index], "light")

    for i = 1, #ContainerShape[index] do
        if not HasTag(ReferenceTableEm[index], "skip") then
            local tagValue = GetTagValue(ContainerShape[index][i], "ALSLight")
            local scaleIndex = tagMappings[LightType] and tagMappings[LightType][tagValue]

            if scaleIndex then
                if ConteinerLight[index][lightTime][scaleIndex] == 0 and HasTag(ContainerShape[index][i], "inv") then
                    SetTag(ContainerShape[index][i], "invisible")
                else
                    RemoveTag(ContainerShape[index][i], "invisible")
                end

                SetShapeEmissiveScale(ContainerShape[index][i], ConteinerLight[index][lightTime][scaleIndex])
            end
        end
    end
end

--==========--
--  Horn  --
--==========--

function ALS_PlaySound(Vehicle, honks, SoundShape)
    if Vehicle ~= empty then
        local ALSsiren = GetTagValue(Vehicle, "ALSsiren")
        local Shape = GetShapeWorldTransform(SoundShape)

        if HasTag(Vehicle, "Horn") then
            local honkNum = tonumber(string.sub(GetTagValue(Vehicle, "ALShorn"), 1, 2))
            PlayLoop(honks[honkNum], Shape.pos, GetFloat("ALS.HornVol") / 500)
        end
    end
end
