#include "LightAnimationTables.lua"
-- Initialize three empty tables for different light categories
Pry = {}
Sec = {}
Ter = {}
Direct = {}

local patternLengths = {
    ["25"] = 26,
    ["11"] = 23,
    ["10"] = 21,
    ["6"] = 13,
    ["5"] = 11,
    ["4"] = 9,
    ["3"] = 7,
    ["2"] = 5,
    ["1"] = 3
}

-- Define mappings between light values and corresponding light indices
local tagMappings = {
    ["10"] = { L1 = 2, L2 = 3, L3 = 4, L4 = 5, L5 = 6, L6 = 7, L7 = 8, L8 = 9, L9 = 10, L10 = 11, R1 = 21, R2 = 20, R3 = 19, R4 = 18, R5 = 17, R6 = 16, R7 = 15, R8 = 14, R9 = 13, R10 = 12 },
    ["6"] = { L1 = 2, L2 = 3, L3 = 4, L4 = 5, L5 = 6, L6 = 7, R1 = 13, R2 = 12, R3 = 11, R4 = 10, R5 = 9, R6 = 8 },
    ["5"] = { L1 = 2, L2 = 3, L3 = 4, L4 = 5, L5 = 6, R1 = 11, R2 = 10, R3 = 9, R4 = 8, R5 = 7 },
    ["4"] = { L1 = 2, L2 = 3, L3 = 4, L4 = 5, R1 = 9, R2 = 8, R3 = 7, R4 = 6 },
    ["3"] = { L1 = 2, L2 = 3, L3 = 4, R1 = 7, R2 = 6, R3 = 5 },
    ["2"] = { L1 = 2, L2 = 3, R1 = 5, R2 = 4 },
    ["1"] = { L1 = 2, R1 = 3 },
}

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



-- Function to clear the contents of the existing table
function clearTable(tbl)
    for k in pairs(tbl) do
        tbl[k] = nil
    end
end

-- Function to get the table inside
function getTableInside(tableNumber, innerTableNumber)
    local outerTable = tables[tableNumber]
    if outerTable then
        local innerTable = outerTable[innerTableNumber]
        if innerTable then
            return innerTable.data
        end
    end
    return nil
end

-- Function to create a table of lights based on the specified light value
function createTableLights(index, tbl, targetTable)
    local lightValue = tonumber(GetTagValue(tbl[index][1], "light"))
    local AnimValue = 2
    if targetTable == Pry then
        AnimValue = tonumber(GetTagValue(tbl[index][1], "Pry"))
        tbl[index][3] = AnimValue
    elseif targetTable == Sec then
        AnimValue = tonumber(GetTagValue(tbl[index][1], "Sec"))
        tbl[index][4] = AnimValue
    elseif targetTable == Ter then
        AnimValue = tonumber(GetTagValue(tbl[index][1], "Ter"))
        tbl[index][5] = AnimValue
    elseif targetTable == Direct then
        AnimValue = tonumber(GetTagValue(tbl[index][1], "Di"))
        tbl[index][3] = AnimValue
    end

    if AnimValue == empty then
        if targetTable == Pry then
            AnimValue = 2
            tbl[index][3] = AnimValue
        elseif targetTable == Sec then
            AnimValue = 3
            tbl[index][4] = AnimValue
        elseif targetTable == Ter then
            AnimValue = 4
            tbl[index][5] = AnimValue
        elseif targetTable == Direct then
            AnimValue = 2
            tbl[index][3] = AnimValue
        end
    end

    local innerTable = getTableInside(lightValue, AnimValue)


    tbl[index][2] = #tables[lightValue]


    -- Create a deep copy of the target table
    shapes = DeepCopy(innerTable)

    return shapes
end



-- Function to create a table of lights based on the specified light value
function ReloadAnimation(body, targetTable)
    local lightValue = tonumber(GetTagValue(body, "light"))

    local innerTable = getTableInside(lightValue, targetTable)

    -- Create a deep copy of the target table
    shapes = DeepCopy(innerTable)

    return shapes
end

-- Function to create a table for animation time initialization
function createTableAniTime(index, CreateTableAniTime)
    local shapes = CreateTableAniTime[index][1][1]
    return { shapes, 1 }
end

-- Function to insert a key-value pair into a table
function insertKeyValue(table, key, value)
    table[key] = value
end

-- Function to print the value for a given key in a table
function printValueForKey(table, key)
    if table[key] ~= nil then
        return table[key], true
    else
        return false, false
    end
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

    sirenPrimary = {}
    sirenPrimary[#sirenPrimary + 1] = LoadLoop("sound/sirenP01.ogg")
    sirenPrimary[#sirenPrimary + 1] = LoadLoop("sound/sirenP02.ogg")
    sirenPrimary[#sirenPrimary + 1] = LoadLoop("sound/sirenP03.ogg")
    sirenPrimary[#sirenPrimary + 1] = LoadLoop("sound/sirenP04.ogg")

    sirenSecondary = {}
    sirenSecondary[#sirenSecondary + 1] = LoadLoop("sound/sirenS01.ogg")
    sirenSecondary[#sirenSecondary + 1] = LoadLoop("sound/sirenS02.ogg")
    sirenSecondary[#sirenSecondary + 1] = LoadLoop("sound/sirenS03.ogg")
    sirenSecondary[#sirenSecondary + 1] = LoadLoop("sound/sirenS04.ogg")

    sirenTertiary = {}
    sirenTertiary[#sirenTertiary + 1] = LoadLoop("sound/sirenT01.ogg")
    sirenTertiary[#sirenTertiary + 1] = LoadLoop("sound/sirenT02.ogg")

    sirenFourth = {}
    sirenFourth[#sirenFourth + 1] = LoadLoop("sound/sirenQ01.ogg")


    frame1 = 0
    frame = 0
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





    --create tables containg the ligth shapes
    local GroupTables = {}
    local GroupTablesNormal = {}
    local GroupTablesDirectional = {}

    BodyTables = {}
    DirectionalBodyTables = {}
    BodyTablesNormal = {}

    --reference for the body shapes/groups
    ReferenceTable = {}
    ReferenceTableEm = {}
    ReferenceTableDirectional = {}
    local temp = {}


    --conteiner for the light animations
    containerTableLights = {}
    containerTableLightsNormal = {}
    containerTableLightsDirectional = {}

    for i = 1, #BodyLight do
        lightgroup = GetTagValue(BodyLight[i], "group")


        if HasTag(BodyLight[i], "Di") then
            local tablenumber, add = printValueForKey(GroupTablesDirectional, lightgroup)
            if not add then
                containerTableLightsDirectional[#containerTableLightsDirectional + 1] = createTable(i)
                -- Insert a new key-value pair into the table
                insertKeyValue(GroupTablesDirectional, lightgroup, #containerTableLightsDirectional)
                ReferenceTableDirectional[#ReferenceTableDirectional + 1] = { BodyLight[i], 0, 0, 0, 0 }
                DirectionalBodyTables[#DirectionalBodyTables + 1] = { BodyLight[i] }
            else
                --return positon of the container
                local tablenumber = printValueForKey(GroupTablesDirectional, lightgroup)
                table.insert(DirectionalBodyTables[tablenumber], BodyLight[i])
                temp[1] = createTable(i)

                for _, value in ipairs(temp[1]) do
                    table.insert(containerTableLightsDirectional[tablenumber], value)
                end
            end
        end

        if HasTag(BodyLight[i], "HL") or HasTag(BodyLight[i], "HB") or HasTag(BodyLight[i], "BL") or HasTag(BodyLight[i], "BRL") or HasTag(BodyLight[i], "RL") or HasTag(BodyLight[i], "B") or HasTag(BodyLight[i], "AD") or HasTag(BodyLight[i], "FL") then
            local tablenumber, add = printValueForKey(GroupTablesNormal, lightgroup)
            if not add then
                containerTableLightsNormal[#containerTableLightsNormal + 1] = createTable(i)
                -- Insert a new key-value pair into the table
                insertKeyValue(GroupTablesNormal, lightgroup, #containerTableLightsNormal)
                ReferenceTable[#ReferenceTable + 1] = BodyLight[i]
                BodyTablesNormal[#BodyTablesNormal + 1] = { BodyLight[i] }
            else
                --return positon of the container
                local tablenumber = printValueForKey(GroupTablesNormal, lightgroup)
                table.insert(BodyTablesNormal[tablenumber], BodyLight[i])
                temp[1] = createTable(i)

                for _, value in ipairs(temp[1]) do
                    table.insert(containerTableLightsNormal[tablenumber], value)
                end
            end

        end

        local tablenumber, add = printValueForKey(GroupTables, lightgroup)
        if not add and not HasTag(BodyLight[i], "normal") and not HasTag(BodyLight[i], "Di") then
            containerTableLights[#containerTableLights + 1] = createTable(i)
            -- Insert a new key-value pair into the table
            insertKeyValue(GroupTables, lightgroup, #containerTableLights)
            ReferenceTableEm[#ReferenceTableEm + 1] = { BodyLight[i], 0, 0, 0, 0 }
            BodyTables[#BodyTables + 1] = { BodyLight[i] }
        elseif not HasTag(BodyLight[i], "normal") and not HasTag(BodyLight[i], "Di") then
            --return positon of the container
            local tablenumber = printValueForKey(GroupTables, lightgroup)
            --add body to the body list
            table.insert(BodyTables[tablenumber], BodyLight[i])

            --get all the light shapes inside the body and put in a list
            temp[1] = createTable(i)

            --add the lightshapes to the containerTableLights
            for _, value in ipairs(temp[1]) do
                table.insert(containerTableLights[tablenumber], value)
            end

        end
    end

    --reload the BodyLight table
    --BodyLight = FindBodies("light")

    -- Print the updated table
    --for key, value in pairs(GroupTables) do
    --DebugPrint(key..value)
    --end
    if HasTag(Vehicle, "directional") then
        containerTableDirectional = {}
        for i = 1, #containerTableLightsDirectional do
            containerTableDirectional[i] = createTableLights(i, ReferenceTableDirectional, Direct)
        end

        containerTableAniTimeDirect = {}
        for i = 1, #containerTableLightsDirectional do
            containerTableAniTimeDirect[i] = createTableAniTime(i, containerTableDirectional)
        end
    end

    -- Create and store tables in container tables
    containerTablePry = {}
    containerTableSec = {}
    containerTableTer = {}


    for i = 1, #containerTableLights do
        containerTablePry[i] = createTableLights(i, ReferenceTableEm, Pry)
        containerTableSec[i] = createTableLights(i, ReferenceTableEm, Sec)
        containerTableTer[i] = createTableLights(i, ReferenceTableEm, Ter)
    end

    -- Create a table for animation time initialization
    containerTableAniTime = {}
    for i = 1, #containerTableLights do
        containerTableAniTime[i] = createTableAniTime(i, containerTablePry)
    end

    -- Container tables for different light categories
    containerTables = {
        ["1"] = containerTablePry,
        ["2"] = containerTableSec,
        ["3"] = containerTableTer,
    }

    turnOff = true
    change = 0
    frame = 0
    lightvallue = "1"
    -- Find shapes with the "ALSLight" tag
    lightShapesEM = FindShapes("ALSLight")

    -- Turn off all lights initially
    for i = 1, #lightShapesEM do
        SetShapeEmissiveScale(lightShapesEM[i], 0)
    end

    if HasTag(Vehicle, "directional") then
        lightShapesDi = {}
        for i = 1, #ReferenceTableDirectional do
            for j = 1, #containerTableLightsDirectional[i] do
                RemoveFromTable(lightShapesEM, containerTableLightsDirectional[i][j])
                table.insert(lightShapesDi, containerTableLightsDirectional[i][j])
            end
        end
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

    SteeringWHeel = HasTag(Vehicle, "SW")
    if SteeringWHeel then
        SteeringJoint = FindJoint("SteeringWheel")
    end

    -- Find lights with the "lights" tag
    lights = FindLights("lights")

    GF = HasTag(Vehicle, "GF")
    if GF then
        GiroflexLight = FindShapes("ALSGF")
        for i = 1, #GiroflexLight do SetShapeEmissiveScale(GiroflexLight[i], 0) end
    end


    ALSLightValues = {}
    ALSLightValues[#ALSLightValues + 1] = GetFloat("ALS.Front")
    ALSLightValues[#ALSLightValues + 1] = GetFloat("ALS.HighBeamL")
    ALSLightValues[#ALSLightValues + 1] = GetFloat("ALS.Aditional")
    ALSLightValues[#ALSLightValues + 1] = GetFloat("ALS.FogLight")

    ALSLightValues[#ALSLightValues + 1] = GetFloat("ALS.back")
    ALSLightValues[#ALSLightValues + 1] = GetFloat("ALS.Brake")
    ALSLightValues[#ALSLightValues + 1] = GetFloat("ALS.Reverse")
    ALSLightValues[#ALSLightValues + 1] = GetFloat("ALS.Blinkers")

    ALSLightValues[#ALSLightValues + 1] = GetFloat("ALS.Emergency")
    ALSLightValues[#ALSLightValues + 1] = GetFloat("ALS.DirectionalL")

    ALSLightValues[#ALSLightValues + 1] = GetFloat("ALS.Siren1")
    ALSLightValues[#ALSLightValues + 1] = GetFloat("ALS.Siren2")
    ALSLightValues[#ALSLightValues + 1] = GetFloat("ALS.Siren3")
    ALSLightValues[#ALSLightValues + 1] = GetFloat("ALS.Siren4")
    ALSLightValues[#ALSLightValues + 1] = GetFloat("ALS.horn")
    ALSLightValues[#ALSLightValues + 1] = GetFloat("ALS.alarm")
    ALSLightValues[#ALSLightValues + 1] = GetFloat("ALS.Chime")

    ALSLightValues[#ALSLightValues + 1] = GetFloat("ALS.Beacon")



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
--Fix
--make more efficient
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
                                SetLightIntensity(light[i], ALSLightValues[1] / 5)
                            end
                            if GetTagValue(light[i], "type") == "2" then
                                SetLightIntensity(light[i], 0)
                            end
                            RemoveFromTable(lightShapesEM, containerTableLightsNormal[i][j])
                        end
                        if HasTag(containerTableLightsNormal[i][j], "inv") then
                            RemoveTag(containerTableLightsNormal[i][j], "invisible")
                        end
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
                                SetLightIntensity(light[i], ALSLightValues[2])
                            end
                            RemoveFromTable(lightShapesEM, containerTableLightsNormal[i][j])
                        end
                        if HasTag(containerTableLightsNormal[i][j], "inv") then
                            RemoveTag(containerTableLightsNormal[i][j], "invisible")
                        end
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
                            SetLightIntensity(light[i], ALSLightValues[1] / 5)
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
                            SetLightIntensity(light[i], ALSLightValues[1] / 5)
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
                            SetLightIntensity(light[i], ALSLightValues[1] / 5)
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
                        SetLightIntensity(light[i], ALSLightValues[2])
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
                        SetLightIntensity(light[i], ALSLightValues[4] / 5)
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
                        if GetTagValue(light[i], "type") == "1" then
                            SetLightIntensity(light[i], 0)
                        end
                        if GetTagValue(light[i], "type") == "2" then
                            SetLightIntensity(light[i], ALSLightValues[3] / 5)
                        end
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
                        if GetTagValue(light[i], "type") == "1" then
                            SetLightIntensity(light[i], GetFloat("ALS.Emergency") / 10)
                        end
                        if GetTagValue(light[i], "type") == "2" then
                            SetLightIntensity(light[i], 0)
                        end
                    end
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
                        SetLightIntensity(light[i], ALSLightValues[7] / 50)
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
                            if GetTagValue(containerTableLightsNormal[i][j], "ALSLight") == "R1" or GetTagValue(containerTableLightsNormal[i][j], "ALSLight") == "R2" then
                                SetShapeEmissiveScale(containerTableLightsNormal[i][j], 0.5)
                                local light = GetShapeLights(containerTableLightsNormal[i][j])
                                for i = 1, #light do
                                    SetLightIntensity(light[i], ALSLightValues[8] / 40)
                                end
                                if HasTag(containerTableLightsNormal[i][j], "inv") then
                                    RemoveTag(containerTableLightsNormal[i][j], "invisible")
                                end
                            end
                        else
                            if GetTagValue(containerTableLightsNormal[i][j], "ALSLight") == "R1" or GetTagValue(containerTableLightsNormal[i][j], "ALSLight") == "R2" then
                                SetShapeEmissiveScale(containerTableLightsNormal[i][j], 0)
                                if HasTag(containerTableLightsNormal[i][j], "inv") then
                                    SetTag(containerTableLightsNormal[i][j], "invisible")
                                end
                            end
                        end
                        if Left or Razard then
                            if GetTagValue(containerTableLightsNormal[i][j], "ALSLight") == "L1" or GetTagValue(containerTableLightsNormal[i][j], "ALSLight") == "L2" then
                                SetShapeEmissiveScale(containerTableLightsNormal[i][j], 0.5)
                                local light = GetShapeLights(containerTableLightsNormal[i][j])
                                for i = 1, #light do
                                    SetLightIntensity(light[i], ALSLightValues[8] / 40)
                                end
                                if HasTag(containerTableLightsNormal[i][j], "inv") then
                                    RemoveTag(containerTableLightsNormal[i][j], "invisible")
                                end
                            end
                        else
                            if GetTagValue(containerTableLightsNormal[i][j], "ALSLight") == "L1" or GetTagValue(containerTableLightsNormal[i][j], "ALSLight") == "L2" then
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
                            SetLightIntensity(light[i], ALSLightValues[5] / 50)
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
                                SetLightIntensity(light[i], ALSLightValues[5] / 40)
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
                        if GetTagValue(containerTableLightsNormal[i][j], "ALSLight") == "R1" and Right or Razard or GetTagValue(containerTableLightsNormal[i][j], "ALSLight") == "R2" and Right or Razard then
                            SetShapeEmissiveScale(containerTableLightsNormal[i][j], 1)
                            local light = GetShapeLights(containerTableLightsNormal[i][j])
                            for i = 1, #light do
                                SetLightIntensity(light[i], ALSLightValues[8] / 40)
                            end
                            if HasTag(containerTableLightsNormal[i][j], "inv") then
                                RemoveTag(containerTableLightsNormal[i][j], "invisible")
                            end
                        end
                        if GetTagValue(containerTableLightsNormal[i][j], "ALSLight") == "L1" and Left or Razard or GetTagValue(containerTableLightsNormal[i][j], "ALSLight") == "L2" and Left or Razard then
                            SetShapeEmissiveScale(containerTableLightsNormal[i][j], 1)
                            local light = GetShapeLights(containerTableLightsNormal[i][j])
                            for i = 1, #light do
                                SetLightIntensity(light[i], ALSLightValues[8] / 40)
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
                            SetLightIntensity(light[i], ALSLightValues[5] / 40)
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
                            SetLightIntensity(light[i], ALSLightValues[6] / 50)
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
                        if brake and GetTagValue(containerTableLightsNormal[i][j], "ALSLight") == "L1" and Right or brake and GetTagValue(containerTableLightsNormal[i][j], "ALSLight") == "L2" and Right then
                            SetShapeEmissiveScale(containerTableLightsNormal[i][j], 1)
                            local light = GetShapeLights(containerTableLightsNormal[i][j])
                            for i = 1, #light do
                                SetLightIntensity(light[i], ALSLightValues[6] / 40)
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
                        if brake and GetTagValue(containerTableLightsNormal[i][j], "ALSLight") == "R1" and Left or brake and GetTagValue(containerTableLightsNormal[i][j], "ALSLight") == "R2" and Left then
                            SetShapeEmissiveScale(containerTableLightsNormal[i][j], 1)
                            local light = GetShapeLights(containerTableLightsNormal[i][j])
                            for i = 1, #light do
                                SetLightIntensity(light[i], ALSLightValues[6] / 40)
                            end
                            if HasTag(containerTableLightsNormal[i][j], "inv") then
                                RemoveTag(containerTableLightsNormal[i][j], "invisible")
                            end
                        end

                        if GetTagValue(containerTableLightsNormal[i][j], "ALSLight") == "R1" and Right and not Time or Razard and not Time or GetTagValue(containerTableLightsNormal[i][j], "ALSLight") == "R2" and Right and not Time or Razard and not Time then
                            SetShapeEmissiveScale(containerTableLightsNormal[i][j], 1)
                            local light = GetShapeLights(containerTableLightsNormal[i][j])
                            for i = 1, #light do
                                SetLightIntensity(light[i], ALSLightValues[8] / 40)
                            end
                            if HasTag(containerTableLightsNormal[i][j], "inv") then
                                RemoveTag(containerTableLightsNormal[i][j], "invisible")
                            end
                        end
                        if GetTagValue(containerTableLightsNormal[i][j], "ALSLight") == "L1" and Left and not Time or Razard and not Time or GetTagValue(containerTableLightsNormal[i][j], "ALSLight") == "L2" and Left and not Time or Razard and not Time then
                            SetShapeEmissiveScale(containerTableLightsNormal[i][j], 1)
                            local light = GetShapeLights(containerTableLightsNormal[i][j])
                            for i = 1, #light do
                                SetLightIntensity(light[i], ALSLightValues[8] / 40)
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
                            SetLightIntensity(light[i], ALSLightValues[6] / 40)
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
                                SetLightIntensity(light[i], ALSLightValues[5] / 40)
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

                        if brake and GetTagValue(containerTableLightsNormal[i][j], "ALSLight") == "L1" and Right or brake and GetTagValue(containerTableLightsNormal[i][j], "ALSLight") == "L2" and Right then
                            SetShapeEmissiveScale(containerTableLightsNormal[i][j], 1)
                            local light = GetShapeLights(containerTableLightsNormal[i][j])
                            for i = 1, #light do
                                SetLightIntensity(light[i], ALSLightValues[6] / 40)
                            end
                            if HasTag(containerTableLightsNormal[i][j], "inv") then
                                RemoveTag(containerTableLightsNormal[i][j], "invisible")
                            end
                        end
                        if brake and GetTagValue(containerTableLightsNormal[i][j], "ALSLight") == "R1" and Left or brake and GetTagValue(containerTableLightsNormal[i][j], "ALSLight") == "R2" and Left then
                            SetShapeEmissiveScale(containerTableLightsNormal[i][j], 1)
                            local light = GetShapeLights(containerTableLightsNormal[i][j])
                            for i = 1, #light do
                                SetLightIntensity(light[i], ALSLightValues[6] / 40)
                            end
                            if HasTag(containerTableLightsNormal[i][j], "inv") then
                                RemoveTag(containerTableLightsNormal[i][j], "invisible")
                            end
                        end

                        if GetTagValue(containerTableLightsNormal[i][j], "ALSLight") == "R1" and Right and not Time or Razard and not Time or GetTagValue(containerTableLightsNormal[i][j], "ALSLight") == "R2" and Right and not Time or Razard and not Time then
                            SetShapeEmissiveScale(containerTableLightsNormal[i][j], 1)
                            local light = GetShapeLights(containerTableLightsNormal[i][j])
                            for i = 1, #light do
                                SetLightIntensity(light[i], ALSLightValues[8] / 40)
                            end
                            if HasTag(containerTableLightsNormal[i][j], "inv") then
                                RemoveTag(containerTableLightsNormal[i][j], "invisible")
                            end
                        end
                        if GetTagValue(containerTableLightsNormal[i][j], "ALSLight") == "L1" and Left and not Time or Razard and not Time or GetTagValue(containerTableLightsNormal[i][j], "ALSLight") == "L2" and Left and not Time or Razard and not Time then
                            SetShapeEmissiveScale(containerTableLightsNormal[i][j], 1)
                            local light = GetShapeLights(containerTableLightsNormal[i][j])
                            for i = 1, #light do
                                SetLightIntensity(light[i], ALSLightValues[8] / 40)
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
                            SetLightIntensity(light[i], ALSLightValues[6] / 40)
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
                            SetLightIntensity(light[i], ALSLightValues[5] / 40)
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
                            SetLightIntensity(light[i], ALSLightValues[6] / 40)
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
                            SetLightIntensity(light[i], ALSLightValues[5] / 40)
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
    if not destroyed then
        -- Set the lights to the luminosity chosen on the menu
        --if this is on the init, if the car is already on the map, the ligths wont update

        if GetBool("ALS.LightIntensity") or not first then
            ALSLightValues[1] = GetFloat("ALS.Front")
            ALSLightValues[2] = GetFloat("ALS.HighBeamL")
            ALSLightValues[3] = GetFloat("ALS.Aditional")
            ALSLightValues[4] = GetFloat("ALS.FogLight")

            ALSLightValues[5] = GetFloat("ALS.back")
            ALSLightValues[6] = GetFloat("ALS.Brake")
            ALSLightValues[7] = GetFloat("ALS.Reverse")
            ALSLightValues[8] = GetFloat("ALS.Blinkers")

            ALSLightValues[11] = GetFloat("ALS.Siren1Vol")
            ALSLightValues[12] = GetFloat("ALS.Siren2Vol")
            ALSLightValues[13] = GetFloat("ALS.Siren3Vol")
            ALSLightValues[14] = GetFloat("ALS.Siren4Vol")
            ALSLightValues[15] = GetFloat("ALS.HornVol")
            ALSLightValues[16] = GetFloat("ALS.alarm")
            ALSLightValues[17] = GetFloat("ALS.Chime")
            ALSLightValues[18] = GetFloat("ALS.Beacon")

            for i = 1, #ReferenceTableEm do
                for j = 1, #containerTableLights[i] do
                    local light = GetShapeLights(containerTableLights[i][j])
                    for k = 1, #light do
                        SetLightIntensity(light[k], GetFloat("ALS.Emergency") / 10)
                    end
                end
            end

            --for i = 1, #lights do
            --        SetLightIntensity(lights[i], GetFloat("ALS.Emergency") / 10)
            --end

            for i = 1, #ReferenceTableDirectional do
                for j = 1, #containerTableLightsDirectional[i] do
                    local light = GetShapeLights(containerTableLightsDirectional[i][j])
                    for k = 1, #light do
                        SetLightIntensity(light[k], GetFloat("ALS.directional") / 10)
                    end
                end
            end



            if GF then
                for i = 1, #GiroflexLight do
                    local light = GetShapeLights(GiroflexLight[i])
                    for i = 1, #light do
                        SetLightIntensity(light[i], ALSLightValues[18] / 10)
                    end
                end
            end

            for i = 1, #ReferenceTable do
                if HasTag(ReferenceTable[i], "FL") then
                    local typeValue = GetTagValue(ReferenceTable[i], "type")
                    for j = 1, #containerTableLightsNormal[i] do
                        local light = GetShapeLights(containerTableLightsNormal[i][j])
                        for k = 1, #light do
                            SetLightIntensity(light[k], ALSLightValues[4] / 5)
                        end
                    end
                end
                if HasTag(ReferenceTable[i], "AD") then
                    local typeValue = GetTagValue(ReferenceTable[i], "type")
                    for j = 1, #containerTableLightsNormal[i] do
                        local light = GetShapeLights(containerTableLightsNormal[i][j])
                        for k = 1, #light do
                            SetLightIntensity(light[k], ALSLightValues[3] / 5)
                        end
                    end
                end
                if HasTag(ReferenceTable[i], "HL") then
                    local typeValue = GetTagValue(ReferenceTable[i], "type")
                    for j = 1, #containerTableLightsNormal[i] do
                        local light = GetShapeLights(containerTableLightsNormal[i][j])
                        for k = 1, #light do
                            if GetTagValue(light[k], "type") == "1" then
                                SetLightIntensity(light[k], ALSLightValues[1] / 5)
                            end
                        end
                    end
                end
                if HasTag(ReferenceTable[i], "RL") then
                    local typeValue = GetTagValue(ReferenceTable[i], "type")
                    for j = 1, #containerTableLightsNormal[i] do
                        local light = GetShapeLights(containerTableLightsNormal[i][j])
                        for k = 1, #light do
                            SetLightIntensity(light[k], ALSLightValues[7] / 50)
                        end
                    end
                end
                if HasTag(ReferenceTable[i], "BL") or HasTag(ReferenceTable[i], "BRL") then
                    local typeValue = GetTagValue(ReferenceTable[i], "type")
                    for j = 1, #containerTableLightsNormal[i] do
                        local light = GetShapeLights(containerTableLightsNormal[i][j])
                        for k = 1, #light do
                            SetLightIntensity(light[k], ALSLightValues[5] / 50)
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

            SetTag(Vehicle, "lightupdate")
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
                        SetJointMotorTarget(FoldingMirrors[i], GetTagValue(FoldingMirrors[i], "mirror"), GetTagValue(FoldingMirrors[i], "speed"))
                    end
                end
            end
            if GetVehicleHealth(Vehicle) ~= gethealth then
                SetTag(Vehicle, "alarm")
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
                if FoldingMirror then
                    for i = 1, #FoldingMirrors do
                        SetJointMotorTarget(FoldingMirrors[i], 0, GetTagValue(FoldingMirrors[i], "speed"))
                    end
                end
            end
            if HasTag(Vehicle, "alarm") then
                RemoveTag(Vehicle, "alarm")
            end
        end

        --car chime
        if HeadLight or Aditional or GetPlayerVehicle() == Vehicle then
            if HasTag(findvehicle, "quantdoor") then
                local quantdoor = tonumber(string.sub(GetTagValue(findvehicle, "quantdoor"), 0, 1))
                if quantdoor > 0 then
                    local Shape = GetShapeWorldTransform(chimepos)
                    local chime = tonumber(string.sub(GetTagValue(findvehicle, "chime"), 0, 1))
                    PlayLoop(chimeList[chime], Shape.pos, ALSLightValues[17] / 500)
                end
            end
        end
        --alarmsound
        if HasTag(Vehicle, "alarm") then
            local Shape = GetShapeWorldTransform(chimepos)
            local alarm = tonumber(string.sub(GetTagValue(findvehicle, "lock"), 0, 1))
            PlayLoop(alarmList[alarm], Shape.pos, ALSLightValues[16] / 500)
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
            if SteeringWHeel then
                if InputDown("left") then
                    SetJointMotorTarget(SteeringJoint, -85, 3.5)
                elseif InputDown("right") then
                    SetJointMotorTarget(SteeringJoint, 85, 3.5)
                else
                    SetJointMotorTarget(SteeringJoint, 0, 3.5)
                end
            end


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
        if HasTag(findvehicle, "Horn") or HasTag(findvehicle, "ALSsiren") or HasTag(findvehicle, "Yell") then
            ALS_PlaySound(findvehicle, sirenPrimary, sirenSecondary, sirenTertiary, sirenFourth, honkList, hornpos)
        end




        -- If chosen, highlight only the specified body
        if Vehicle == GetPlayerVehicle() then
            if GetBool("ALS.menu") then
                --lightgroup = GetTagValue(GetInt("ALS.vehicle"), "group")
                --local tablenumber = printValueForKey(GroupTables, lightgroup)

                --if tablenumber then
                --    for i = 1, #containerTableLights[tablenumber] do
                --        DrawShapeOutline(containerTableLights[tablenumber][i], 0.5)
                --    end
                --end

                if GetBool("ALS.ReceiveBody") and not GetBool("ALS.BodyDone") then
                    if #ReferenceTableEm == 0 then
                        ClearKey("ALS.NextBody")
                        ClearKey("ALS.ReceiveBody")
                    end

                    if GetBool("ALS.NextBody") then
                        local currentBody = GetInt("ALS.CurrentBody")
                        local sum = currentBody + 1
                        SetInt("ALS.CurrentBody", sum)
                        SetInt(("ALS.Body"), ReferenceTableEm[GetInt("ALS.CurrentBody")][1])
                        SetInt(("ALS.TotalAni"), ReferenceTableEm[GetInt("ALS.CurrentBody")][2])
                        SetInt(("ALS.Pry"), ReferenceTableEm[GetInt("ALS.CurrentBody")][3])
                        SetInt(("ALS.Sec"), ReferenceTableEm[GetInt("ALS.CurrentBody")][4])
                        SetInt(("ALS.Ter"), ReferenceTableEm[GetInt("ALS.CurrentBody")][5])

                        if sum >= #ReferenceTableEm then
                            SetBool("ALS.Finish", true)
                            SetInt("ALS.CurrentBody", 0)
                            currentBody = 0
                            sum = 0
                        end

                        SetBool("ALS.NextBody", false)
                    end
                end
                if GetBool("ALS.BodyDone") and not GetBool("ALS.ReceiveBody") then
                    if #ReferenceTableDirectional == 0 then
                        ClearKey("ALS.NextBody")
                        ClearKey("ALS.BodyDone")
                        RemoveTag(Vehicle, "directional")
                    end

                    if GetBool("ALS.NextBody") then
                        local currentBody = GetInt("ALS.CurrentBody")

                        local sum = currentBody + 1

                        SetInt("ALS.CurrentBody", sum)

                        SetInt(("ALS.Body"), ReferenceTableDirectional[GetInt("ALS.CurrentBody")][1])
                        SetInt(("ALS.TotalAni"), ReferenceTableDirectional[GetInt("ALS.CurrentBody")][2])
                        SetInt(("ALS.Pry"), ReferenceTableDirectional[GetInt("ALS.CurrentBody")][3])

                        if sum == #ReferenceTableDirectional then
                            SetBool("ALS.ReceiveBody", false)
                            SetBool("ALS.Finish", true)
                        end
                        SetBool("ALS.NextBody", false)
                    end
                end

                if GetBool("ALS.BodyReceive") then
                    local BodyPos, ChooseTable = findBodyLightPosition(GetInt(("ALS.Body")))

                    if ChooseTable then
                        if HasTag(Vehicle, "di") then
                            ReferenceTableDirectional[BodyPos][3] = GetInt(("ALS.Pry"))
                            clearTable(containerTableDirectional[BodyPos])
                            containerTableDirectional[BodyPos] = ReloadAnimation(GetInt(("ALS.Body")),
                                GetInt(("ALS.Pry")))
                        end
                    else
                        if GetTagValue(Vehicle, "em") == "1" then
                            ReferenceTableEm[BodyPos][3] = GetInt(("ALS.Pry"))
                            clearTable(containerTablePry[BodyPos])
                            containerTablePry[BodyPos] = ReloadAnimation(GetInt(("ALS.Body")), GetInt(("ALS.Pry")))
                        elseif GetTagValue(Vehicle, "em") == "2" then
                            ReferenceTableEm[BodyPos][4] = GetInt(("ALS.Pry"))
                            clearTable(containerTableSec[BodyPos])
                            containerTableSec[BodyPos] = ReloadAnimation(GetInt(("ALS.Body")), GetInt(("ALS.Pry")))
                        elseif GetTagValue(Vehicle, "em") == "3" then
                            ReferenceTableEm[BodyPos][5] = GetInt(("ALS.Pry"))
                            clearTable(containerTableTer[BodyPos])
                            containerTableTer[BodyPos] = ReloadAnimation(GetInt(("ALS.Body")), GetInt(("ALS.Pry")))
                        end
                    end

                    for i = 1, #containerTableAniTime do
                        containerTableAniTime[i] = Reset(i)
                    end
                    if HasTag(Vehicle, "directional") then
                        for i = 1, #containerTableAniTimeDirect do
                            containerTableAniTimeDirect[i] = Reset(i)
                        end
                    end
                    ClearKey("ALS.BodyReceive")
                    ClearKey("ALS.Pry")
                    ClearKey("ALS.Body")
                end


                local targetPosition, ChooseTable = findBodyLightPosition(GetInt("ALS.vehicle"))

                DrawBodyOutline(GetInt("ALS.vehicle"), 0, 1, 0, 1)
                if GetBool("ALS.Reset") then
                    for i = 1, #containerTableAniTime do
                        containerTableAniTime[i] = Reset(i)
                    end
                    if HasTag(Vehicle, "directional") then
                        for i = 1, #containerTableAniTimeDirect do
                            containerTableAniTimeDirect[i] = Reset(i)
                        end
                    end
                    SetBool("ALS.Reset", false)
                end

                if ChooseTable then
                    if HasTag(Vehicle, "directional") then
                        if targetPosition then
                            if GetBool("ALS.ReceiveTable") then
                                sendtable(targetPosition, containerTableDirectional)
                            else
                                receivetable(targetPosition, containerTableDirectional)
                            end
                            --DebugPrint("Position found: " .. targetPosition)
                        end
                    end
                else
                    if targetPosition then
                        if GetBool("ALS.ReceiveTable") then
                            local tagvalue = GetTagValue(Vehicle, "em")

                            if tagvalue == "1" then
                                lightvallue = "1"
                            elseif tagvalue == "2" then
                                lightvallue = "2"
                            elseif tagvalue == "3" then
                                lightvallue = "3"
                            end
                            sendtable(targetPosition, containerTables[lightvallue])
                        else
                            local tagvalue = GetTagValue(Vehicle, "em")

                            if tagvalue == "1" then
                                lightvallue = "1"
                            elseif tagvalue == "2" then
                                lightvallue = "2"
                            elseif tagvalue == "3" then
                                lightvallue = "3"
                            end
                            receivetable(targetPosition, containerTables[lightvallue])
                        end
                        --DebugPrint("Position found: " .. targetPosition)
                    end
                end
            end
        end


        if GetVehicleHealth(Vehicle) ~= gethealth2 then
            for i = 1, #BodyLight do
                local all = GetJointedBodies(BodyLight[i])
                if #all < 4 then
                    RemoveFromTables3(BodyTablesNormal, BodyLight[i])
                    RemoveFromTables(BodyTables, BodyLight[i])
                    RemoveFromTables2(DirectionalBodyTables, BodyLight[i])
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

--Fix
--combines the three functions into 1
function RemoveFromTables(tbl, value)
    for i = #tbl, 1, -1 do
        for j = #tbl[i], 1, -1 do
            if tbl[i][j] == value then
                table.remove(tbl[i], j)
                Delete(value)

                if #tbl[i] == 0 then
                    table.remove(ReferenceTableEm, i)
                    table.remove(containerTableLights, i)
                    table.remove(containerTablePry, i)
                    table.remove(containerTableSec, i)
                    table.remove(containerTableTer, i)
                    table.remove(containerTableAniTime, i)
                    table.remove(tbl, i)

                elseif j == 1 then
                    ReferenceTableEm[i][1] = tbl[i][j]
                else
                end
            end
        end
    end
end
function RemoveFromTables2(tbl, value)
    for i = #tbl, 1, -1 do
        for j = #tbl[i], 1, -1 do
            if tbl[i][j] == value then
                table.remove(tbl[i], j)
                Delete(value)

                if #tbl[i] == 0 then
                    table.remove(ReferenceTableDirectional, i)
                    table.remove(containerTableLightsDirectional, i)
                    table.remove(containerTableDirectional, i)
                    table.remove(containerTableAniTimeDirect, i)
                    table.remove(tbl, i)
                elseif j == 1 then
                    ReferenceTableDirectional[i][1] = tbl[i][j]
                else
                end
            end
        end
    end
end
function RemoveFromTables3(tbl, value)
    for i = #tbl, 1, -1 do
        for j = #tbl[i], 1, -1 do
            if tbl[i][j] == value then
                table.remove(tbl[i], j)
                if #tbl[i] == 0 then
                    table.remove(ReferenceTable, i)
                    table.remove(containerTableLightsNormal, i)
                    table.remove(tbl, i)
                elseif j == 1 then
                    ReferenceTable[i] = tbl[i][j]
                else
                end
            end
        end
    end
end


function findBodyLightPosition(targetBody)
    for i = 1, #ReferenceTableEm do
        if targetBody == ReferenceTableEm[i][1] then
            return i, false -- Return the position if found
        end
    end
    if HasTag(Vehicle, "directional") then
        for i = 1, #ReferenceTableDirectional do
            if targetBody == ReferenceTableDirectional[i][1] then
                return i, true -- Return the position if found
            end
        end
    end
    -- Return nil if the targetBody is not found in the table
    return nil
end



--receive light animation from main script
function receivetable(targetPosition, ContainerShape)
    -- clear the animation and begin the new one
    if GetBool("ALS.Clean") and GetBool("ALS.SendTable") then
        for i = #ContainerShape[targetPosition], 1, -1 do
            table.remove(ContainerShape[targetPosition], i)
        end
        SetBool("ALS.Clean", false)
        RowSize = 1
        TableSize = 1
        -- create a new blank canvas
        local patternLength = patternLengths[LightType] or 3
        local pattern = {}

        for _ = 1, patternLength do
            table.insert(pattern, 0)
        end

        for i = 1, GetInt("ALS.TableSize") do
            local row = {}
            for _, value in ipairs(pattern) do
                table.insert(row, value)
            end
            ContainerShape[targetPosition][#ContainerShape[targetPosition] + 1] = row
        end
    end
    -- receve the new table and replace with the blank
    if GetBool("ALS.SendTable") then
        roundnumber = Round(GetFloat("ALS.TableVallue"), 2)
        ContainerShape[targetPosition][TableSize][RowSize] = roundnumber
        -- DebugPrint(roundnumber)
        RowSize = RowSize + 1
        if RowSize > GetInt("ALS.RowSize") then
            TableSize = TableSize + 1
            RowSize = 1
            SetBool("ALS.NextLine", false)
        end
        -- DebugPrint(RowSize)
        -- DebugPrint(TableSize)
        SetBool("ALS.SendTable", false)
    end
end

--send the light animation to the main script
function sendtable(targetPosition, ContainerShape)
    if GetBool("ALS.Start") then
        -- DebugPrint("start")
        stop = false
        RowSize = 0
        TableSize = 1
        SetInt("ALS.TableSize", #ContainerShape[targetPosition])
        SetInt("ALS.RowSize", #ContainerShape[targetPosition][1])
        SetBool("ALS.Clean", true)
        SetBool("ALS.Start", false)
    end
    if RowSize == 1 and TableSize == 1 then
        SetBool("ALS.Stop", true)
    end

    if stop then
        SetBool("ALS.ReceiveTable", false)
    end

    if not GetBool("ALS.SendTable2") and not stop then
        SetInt("ALS.Table", TableSize)
        SetInt("ALS.Row", RowSize)
        SetFloat("ALS.TableVallue", ContainerShape[targetPosition][TableSize][RowSize])

        RowSize = RowSize + 1
        if RowSize > #ContainerShape[targetPosition][TableSize] then
            RowSize = 1
            TableSize = TableSize + 1
            SetBool("ALS.NextLine", true)
        end
        if TableSize > #ContainerShape[targetPosition] then
            TableSize = 1
            RowSize = 1
            --DebugPrint("stop")
            stop = true
        end
        SetBool("ALS.Stop", false)
        SetBool("ALS.SendTable2", true)
    end
end

function giroflexemergencia()
    for i = 1, #GiroflexLight do
        tagValue = GetTagValue(GiroflexLight[i], "ALSGF")
        lights = GetShapeLights(GiroflexLight[i])

        local hinge = GetShapeJoints(GiroflexLight[i])
        for u = 1, #hinge do hinges = hinge[u] end
        if HasTag(Vehicle, "em") then
            -- giroflex--
            if tagValue == "GFE" or tagValue == "GFEOFF" then
                SetShapeEmissiveScale(GiroflexLight[i], 1)
                SetJointMotor(hinges, GetTagValue(hinges, "giroflex"))
                SetTag(GiroflexLight[i], "ALSGF", "GFEOFF")
            end
        end
        if not HasTag(Vehicle, "em") then
            if tagValue == "GFEOFF" then
                SetShapeEmissiveScale(GiroflexLight[i], 0)
                SetJointMotor(hinges, 0, 0)
                SetJointMotorTarget(hinges, 0)
                SetTag(GiroflexLight[i], "ALSGF", "GFE")
            end
        end
    end
end

--animated lights have to be on update else the lights behave strangely
function update(dt)
    if not destroyed then
        -- If the car has the emergency lights on
        if HasTag(Vehicle, "em") or HasTag(Vehicle, "di") then
            -- Initiate tick counter
            frame = frame + dt * 60
            local period = 2
            local t = math.ceil(frame) % period


            if HasTag(Vehicle, "di") then
                if turnOn then
                    for i = 1, #containerTableAniTime do
                        containerTableAniTime[i] = Reset(i)
                    end
                    turnOn = false
                end
                -- Run an update every tick
                if frame > period then
                    LightAnimation(t, containerTableAniTimeDirect, containerTableLightsDirectional, containerTableDirectional, ReferenceTableDirectional)
                    turnOffdi = true
                end
            elseif turnOffdi then
                if HasTag(Vehicle, "directional") then
                    for i = 1, #containerTableAniTimeDirect do
                        containerTableAniTimeDirect[i] = Reset(i)
                    end
                    for i = 1, #lightShapesDi do
                        SetShapeEmissiveScale(lightShapesDi[i], 0)
                        if HasTag(lightShapesDi[i], "inv") then
                            SetTag(lightShapesDi[i], "invisible")
                        end
                    end
                    turnOn = true
                    turnOffdi = false
                    collectgarbage("collect")
                end
            end

            if HasTag(Vehicle, "em") then
                if turnOn2 then
                    if HasTag(Vehicle, "directional") then
                        for i = 1, #containerTableAniTimeDirect do
                            containerTableAniTimeDirect[i] = Reset(i)
                        end
                    end
                    for i = 1, #containerTableAniTime do
                        containerTableAniTime[i] = Reset(i)
                    end
                    turnOn2 = false
                    if GF then
                        giroflexemergencia()
                    end
                    if UP then
                        SetTag(Vehicle, "lightupdate")
                    end
                end
                -- Run an update every tick
                if frame > period then
                    local tagvalue = GetTagValue(Vehicle, "em")
                    if change ~= tagvalue then
                        for i = 1, #containerTableAniTime do
                            containerTableAniTime[i] = Reset(i)
                        end
                        change = GetTagValue(Vehicle, "em")
                    end
                    LightAnimation(t, containerTableAniTime, containerTableLights, containerTables[GetTagValue(Vehicle, "em")], ReferenceTableEm)
                    turnOff = true
                end
            elseif turnOff then
                collectgarbage("collect")
                for i = 1, #containerTableAniTime do
                    containerTableAniTime[i] = Reset(i)
                end
                for i = 1, #lightShapesEM do
                    SetShapeEmissiveScale(lightShapesEM[i], 0)
                    if HasTag(lightShapesEM[i], "inv") then
                        SetTag(lightShapesEM[i], "invisible")
                    end
                end
                if GF then
                    giroflexemergencia()
                end
                if UP then
                    SetTag(Vehicle, "lightupdate")
                end
                turnOn2 = true
                turnOff = false
            end

            if frame > period then
                frame = 0
            end

            -- Turn off the lights
        elseif turnOff then
            collectgarbage("collect")
            for i = 1, #containerTableAniTime do
                containerTableAniTime[i] = Reset(i)
            end
            for i = 1, #lightShapesEM do
                SetShapeEmissiveScale(lightShapesEM[i], 0)
                if HasTag(lightShapesEM[i], "inv") then
                    SetTag(lightShapesEM[i], "invisible")
                end
            end
            if GF then
                giroflexemergencia()
            end
            if UP then
                SetTag(Vehicle, "lightupdate")
            end
            turnOn2 = true
            turnOff = false
        elseif turnOffdi then
            if HasTag(Vehicle, "directional") then
                for i = 1, #containerTableAniTimeDirect do
                    containerTableAniTimeDirect[i] = Reset(i)
                end
                for i = 1, #lightShapesDi do
                    SetShapeEmissiveScale(lightShapesDi[i], 0)
                    if HasTag(lightShapesDi[i], "inv") then
                        SetTag(lightShapesDi[i], "invisible")
                    end
                end
                turnOffdi = false
                collectgarbage("collect")
            end
        end
    end
end

-- Function to reset animation time
function Reset(index)
    return { 0, 0 }
end

-- Function to handle light animation
function LightAnimation(t, ContainerAnimationTime, ContainerShape, ConteinerLight, TheReferenteTable)
    for i = 1, #ContainerAnimationTime do
        ContainerAnimationTime[i][1] = ContainerAnimationTime[i][1] - 1

        if ContainerAnimationTime[i][1] < 1 then
            local nextLineResult = nextline(i, ConteinerLight, ContainerAnimationTime)
            ContainerAnimationTime[i] = nextLineResult
            updateLights(i, nextLineResult[2], ContainerShape, ConteinerLight, TheReferenteTable)
        end
    end
end

-- Function to get the next line in the animation
function nextline(index, containerTable, containerTableAniTime)
    local containerAniTime = containerTableAniTime[index]
    local anipos = (containerAniTime[2] % #containerTable[index]) + 1
    local shapes = containerTable[index][anipos][1]

    return { shapes, anipos }
end

-- Function to update lights based on animation time
function updateLights(index, lightTime, ContainerShape, ConteinerLight, TheReferenteTable)
    local LightType = GetTagValue(TheReferenteTable[index][1], "light")

    for i = 1, #ContainerShape[index] do
        if not HasTag(TheReferenteTable[index][1], "skip") then
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

function Round(num, dp)
    --[[
round a number to so-many decimal of places, which can be negative,
e.g. -1 places rounds to 10's,

examples
    173.2562 rounded to 0 dps is 173.0
    173.2562 rounded to 2 dps is 173.26
    173.2562 rounded to -1 dps is 170.0
 ]]
    --
    local mult = 10 ^ (dp or 0)
    return math.floor(num * mult + 0.5) / mult
end

function DeepCopy(orig, copies)
    copies = copies or {}
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        if copies[orig] then
            copy = copies[orig]
        else
            copy = {}
            copies[orig] = copy
            for orig_key, orig_value in next, orig, nil do
                copy[DeepCopy(orig_key, copies)] = DeepCopy(orig_value, copies)
            end
            setmetatable(copy, DeepCopy(getmetatable(orig), copies))
        end
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

--==========--
--  sirens  --
--==========--

function ALS_PlaySound(Vehicle, sirens1, sirens2, sirens3, sirens4, honks, SoundShape)
    if Vehicle ~= empty then
        local ALSsiren = GetTagValue(Vehicle, "ALSsiren")
        local Shape = GetShapeWorldTransform(SoundShape)

        if HasTag(Vehicle, "Horn") then
            local honkNum = tonumber(string.sub(GetTagValue(Vehicle, "ALShorn"), 1, 2))
            PlayLoop(honks[honkNum], Shape.pos, ALSLightValues[15] / 500)
        else
            if not HasTag(Vehicle, "ALSsiren") then
                if HasTag(Vehicle, "Yell") and not HasTag(Vehicle, "Yell2") then
                    local sirenNum = tonumber(string.sub(GetTagValue(Vehicle, "ALShorn"), 3, 4))
                    PlayLoop(sirens1[sirenNum], Shape.pos, ALSLightValues[11] / 500)
                elseif HasTag(Vehicle, "Yell") and HasTag(Vehicle, "Yell2") then
                    local sirenNum = tonumber(string.sub(GetTagValue(Vehicle, "ALShorn"), 5, 6))
                    PlayLoop(sirens2[sirenNum], Shape.pos, ALSLightValues[11] / 500)
                end
            end

            if HasTag(Vehicle, "Yell") then
                if ALSsiren == "1" then
                    local sirenNum = tonumber(string.sub(GetTagValue(Vehicle, "ALShorn"), 5, 6))
                    PlayLoop(sirens2[sirenNum], Shape.pos, ALSLightValues[12] / 500)
                end
                if ALSsiren == "2" then
                    local sirenNum = tonumber(string.sub(GetTagValue(Vehicle, "ALShorn"), 7, 8))
                    PlayLoop(sirens3[sirenNum], Shape.pos, ALSLightValues[13] / 500)
                end
                if ALSsiren == "3" then
                    local sirenNum = tonumber(string.sub(GetTagValue(Vehicle, "ALShorn"), 9, 10))
                    PlayLoop(sirens4[sirenNum], Shape.pos, ALSLightValues[14] / 500)
                end
                if ALSsiren == "4" then
                    local sirenNum = tonumber(string.sub(GetTagValue(Vehicle, "ALShorn"), 1, 2))
                    PlayLoop(honks[sirenNum], Shape.pos, ALSLightValues[15] / 500)
                end
            else
                if ALSsiren == "1" then
                    local sirenNum = tonumber(string.sub(GetTagValue(Vehicle, "ALShorn"), 3, 4))
                    PlayLoop(sirens1[sirenNum], Shape.pos, ALSLightValues[11] / 500)
                end
                if ALSsiren == "2" then
                    local sirenNum = tonumber(string.sub(GetTagValue(Vehicle, "ALShorn"), 5, 6))
                    PlayLoop(sirens2[sirenNum], Shape.pos, ALSLightValues[12] / 500)
                end
                if ALSsiren == "3" then
                    local sirenNum = tonumber(string.sub(GetTagValue(Vehicle, "ALShorn"), 7, 8))
                    PlayLoop(sirens3[sirenNum], Shape.pos, ALSLightValues[13] / 500)
                end
                if ALSsiren == "4" then
                    local sirenNum = tonumber(string.sub(GetTagValue(Vehicle, "ALShorn"), 9, 10))
                    PlayLoop(sirens4[sirenNum], Shape.pos, ALSLightValues[14] / 500)
                end
            end
        end
    end
end

function draw()
    if HasTag(GetPlayerVehicle(), "ALS") then
        if GetBool("ALS.enabled") then
            SetTag(GetPlayerVehicle(), "ok")
        end

        if not HasTag(GetPlayerVehicle(), "ok") then
            if InputPressed("esc") then
                SetTag(GetPlayerVehicle(), "ok")
            end

            SetBool("game.disablepause", true)
            SetBool("game.disablemap", true)
            UiPush()
            local w = UiWidth()
            local h = UiHeight()
            UiTranslate(w - 20, h / 1.5)
            UiAlign("right bottom")
            UiImage("MOD/images/missing.png")
            UiFont("regular.ttf", 20)
            UiWordWrap(250)
            UiTranslate(-5, 0)
            UiText("Press (ESC) to hide this message")
            UiTranslate(0, -60)
            UiText(
                "Please make sure that you have Advanced light system installed and enabled, otherwise the lights and sirens won't work.")
            UiPop()
        end
    end
end
