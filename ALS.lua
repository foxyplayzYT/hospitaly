#include "ALSlibrary.lua"

function init()
    --DebugPrint("text")
    --normal lights
    findvehicle = FindShape("ALShorn")
    lightShapes = FindShapes("ALSlight")
    ALSVehicle = FindVehicle("ALS")
    ALSVehicles = FindVehicles("Passanger")
    ALSdoors = FindBodies("ALSdoor")
    alarmlight = FindShapes("alarmlight")
    
    for i = 1, #alarmlight do SetShapeEmissiveScale(alarmlight[i], 0) end
    

    gethealthdoor = {}

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

    --turn all the lights off when spawned
    for i = 1, #lightShapes do SetShapeEmissiveScale(lightShapes[i], 0) end

    currentKmh = 0
    correntKmh = 0
    counter=0
    frame1 = 0
    frame2 = 0

    reset = {}
    reset[#reset+1] = {false}
    reset[#reset+1] = {false}

    em = {0,0,0,0,0,0,0,0,0}

    --emergency lights
    if HasTag(ALSVehicle, "emergency") then
        lightShapesEM = FindShapes("ALSem")
        GiroflexLight = FindShapes("ALSGF")
        click = LoadSound("sound/click.ogg")
        frame = 0
        for i = 1, #lightShapesEM do SetShapeEmissiveScale(lightShapesEM[i], 0) end

        if HasTag(ALSVehicle, "GF") then
            GiroflexLight = FindShapes("ALSGF")
            for i = 1, #GiroflexLight do SetShapeEmissiveScale(GiroflexLight[i], 0) end
        end

        if HasTag(ALSVehicle, "directional") then
            if GetTagValue(ALSVehicle,"directional") == "" then
                SetTag(ALSVehicle, "directional", "4")
            end
        end

        if HasTag(ALSVehicle, "pry") then
            pry = {
                tonumber(string.sub(GetTagValue(ALSVehicle, "pry"), 1,2)),
                tonumber(string.sub(GetTagValue(ALSVehicle, "pry"), 3,4)),
                tonumber(string.sub(GetTagValue(ALSVehicle, "pry"), 5,6)),
                tonumber(string.sub(GetTagValue(ALSVehicle, "pry"), 7,8)),
                tonumber(string.sub(GetTagValue(ALSVehicle, "pry"), 9,10)),
                tonumber(string.sub(GetTagValue(ALSVehicle, "pry"), 11,12)),
                tonumber(string.sub(GetTagValue(ALSVehicle, "pry"), 13,14)),
                tonumber(string.sub(GetTagValue(ALSVehicle, "pry"), 15,16)),
                tonumber(string.sub(GetTagValue(ALSVehicle, "pry"), 17,18)),
            }
        else
            pry = {2,1,0,1,1,0,0,0,0}
            SetTag(ALSVehicle, "pry", string.format("%02d", pry[1])..string.format("%02d", pry[2])..string.format("%02d", pry[3])..string.format("%02d", pry[4])..string.format("%02d", pry[5])..string.format("%02d", pry[6])..string.format("%02d", pry[7])..string.format("%02d", pry[8])..string.format("%02d", pry[9]))
        end

        if HasTag(ALSVehicle, "sec") then
            sec = {
                tonumber(string.sub(GetTagValue(ALSVehicle, "sec"), 1,2)),
                tonumber(string.sub(GetTagValue(ALSVehicle, "sec"), 3,4)),
                tonumber(string.sub(GetTagValue(ALSVehicle, "sec"), 5,6)),
                tonumber(string.sub(GetTagValue(ALSVehicle, "sec"), 7,8)),
                tonumber(string.sub(GetTagValue(ALSVehicle, "sec"), 9,10)),
                tonumber(string.sub(GetTagValue(ALSVehicle, "sec"), 11,12)),
                tonumber(string.sub(GetTagValue(ALSVehicle, "sec"), 13,14)),
                tonumber(string.sub(GetTagValue(ALSVehicle, "sec"), 15,16)),
                tonumber(string.sub(GetTagValue(ALSVehicle, "sec"), 17,18)),
            }
        else
            sec = {3,2,1,2,2,4,1,1,1}
            SetTag(ALSVehicle, "sec", string.format("%02d", sec[1])..string.format("%02d", sec[2])..string.format("%02d", sec[3])..string.format("%02d", sec[4])..string.format("%02d", sec[5])..string.format("%02d", sec[6])..string.format("%02d", sec[7])..string.format("%02d", sec[8])..string.format("%02d", sec[9]))
        end

        if HasTag(ALSVehicle, "ter") then
            ter = {
                tonumber(string.sub(GetTagValue(ALSVehicle, "ter"), 1,2)),
                tonumber(string.sub(GetTagValue(ALSVehicle, "ter"), 3,4)),
                tonumber(string.sub(GetTagValue(ALSVehicle, "ter"), 5,6)),
                tonumber(string.sub(GetTagValue(ALSVehicle, "ter"), 7,8)),
                tonumber(string.sub(GetTagValue(ALSVehicle, "ter"), 9,10)),
                tonumber(string.sub(GetTagValue(ALSVehicle, "ter"), 11,12)),
                tonumber(string.sub(GetTagValue(ALSVehicle, "ter"), 13,14)),
                tonumber(string.sub(GetTagValue(ALSVehicle, "ter"), 15,16)),
                tonumber(string.sub(GetTagValue(ALSVehicle, "ter"), 17,18)),
            }
        else
            ter = {5,5,4,5,4,5,2,5,5}
            SetTag(ALSVehicle, "ter", string.format("%02d", ter[1])..string.format("%02d", ter[2])..string.format("%02d", ter[3])..string.format("%02d", ter[4])..string.format("%02d", ter[5])..string.format("%02d", ter[6])..string.format("%02d", ter[7])..string.format("%02d", ter[8])..string.format("%02d", ter[9]))
        end
        
    end
end

function tick(dt)
    if not destroyed and GetBool("level.ALS.enabled") then
               --car alarm
               local Shape = GetShapeWorldTransform(findvehicle)
               if not HasTag(findvehicle,"quantdoor") then
                   SetTag(findvehicle,"quantdoor","0")
                   SetTag(findvehicle,"quantad","0")
               end
               if HasTag(findvehicle,"lock") and notlock == false then

                for i = 1, #alarmlight do 
                    local hinge = GetShapeJoints(alarmlight[i])
                    for u = 1, #hinge do hinges = hinge[u] end

                    if IsShapeBroken(alarmlight[i]) or IsJointBroken(hinges) then
                        Delete(alarmlight[i])
                    end
                end

   
                   frame1 = frame1 + dt*60
                   if alarmcar then
                       period1 = 20
                   else
                       period1 = 120
                   end
                   local t1 = math.ceil(frame1) % period1
                   if frame1 > period1 then
                       frame1 = 0
                   end
                   
                   if t1 <= period1/4 then
                    for i = 1, #alarmlight do 
                        SetShapeEmissiveScale(alarmlight[i], 1)
                    end
                       
                   else
                    for i = 1, #alarmlight do 
                        SetShapeEmissiveScale(alarmlight[i], 0)
                    end
                   end
                   
                   if HasTag(findvehicle,"PlayOn") then
                       local alarmsound = tonumber(string.sub(GetTagValue(findvehicle, "lock"), 0, 1))
                       PlaySound(alarmOnList[alarmsound], Shape.pos, 0.5)
                       RemoveTag(findvehicle,"PlayOn")
                       turnofflights = true
                       piscatemp = true
                       frame1 = 0
                       SetTag(ALSVehicle, "p", 3)
                       gethealth = GetVehicleHealth(ALSVehicle)
                       for i = 1, #ALSdoors do
                           gethealthdoor[i] = IsBodyBroken(ALSdoors[i])
                       end
                   end
   
                   for i = 1, #ALSVehicles do
                       if GetPlayerVehicle() == ALSVehicles[i] then
                           SetTag(ALSVehicle, "alarm")
                           SetTag(ALSVehicle, "p", 3)
                       end
                   end
   
                   for i = 1, #ALSdoors do
                       if IsBodyBroken(ALSdoors[i]) ~= gethealthdoor[i] then
                           SetTag(ALSVehicle, "alarm")
                           SetTag(ALSVehicle, "p", 3)
                       end
                   end
   
   
                   if HasTag(findvehicle,"quantdoor") or GetPlayerVehicle() == ALSVehicle then
                       local quantdoor = tonumber(string.sub(GetTagValue(findvehicle, "quantdoor"), 0, 1))
                       if quantdoor > 0 or GetPlayerVehicle() == ALSVehicle then
                           SetTag(ALSVehicle, "alarm")
                           SetTag(ALSVehicle, "p", 3)
                       end
                   end
                   if HasTag(findvehicle,"quantad") or GetPlayerVehicle() == ALSVehicle or GetPlayerVehicle() == ALSVehicles then
                       local quantad = tonumber(string.sub(GetTagValue(findvehicle, "quantad"), 0, 1))
                       if quantad > 0 or GetPlayerVehicle() == ALSVehicle then
                           SetTag(ALSVehicle, "alarm")
                           SetTag(ALSVehicle, "p", 3)
                       end
                   end
                   if GetVehicleHealth(ALSVehicle) ~= gethealth then
                       SetTag(ALSVehicle, "alarm")
                       SetTag(ALSVehicle, "p", 3)
                   end
               elseif HasTag(findvehicle,"quantdoor") or HasTag(findvehicle,"quantad") then
                   local quantdoor = tonumber(string.sub(GetTagValue(findvehicle, "quantdoor"), 0, 1))
                   local quantad = tonumber(string.sub(GetTagValue(findvehicle, "quantad"), 0, 1))
                   if quantdoor > 0 or quantad > 0 then
                       notlock = true
                       RemoveTag(findvehicle,"lock")
                   else
                       notlock = false
                   end
               end
   
               if not HasTag(findvehicle,"lock") then
                   if HasTag(findvehicle,"PlayOff") then
                       local alarmsound = tonumber(string.sub(GetTagValue(findvehicle, "PlayOff"), 0, 1))
                       PlaySound(alarmOffList[alarmsound], Shape.pos, 0.5)
                       RemoveTag(findvehicle,"PlayOff")
                       turnofflights = false
                       piscatemp2 = true
                       frame2 = 0
                       SetTag(ALSVehicle, "p", 3)
                       for i = 1, #alarmlight do 
                        SetShapeEmissiveScale(alarmlight[i], 0)
                        end
                   end
                   if alarmcar then
                       RemoveTag(ALSVehicle, "alarm")
                   end
               end
   
               --car chime
               if luz or luzAT or ad or GetPlayerVehicle() == ALSVehicle then    
                   if HasTag(findvehicle,"quantdoor") then
                       local quantdoor = tonumber(string.sub(GetTagValue(findvehicle, "quantdoor"), 0, 1))
                       if quantdoor > 0 then
                           local chime = tonumber(string.sub(GetTagValue(findvehicle,"chime"), 0, 1))
                           PlayLoop(chimeList[chime], Shape.pos, 0.5)
                       end
                   end
               end
               --alarmsound
               if alarmcar then
                   local alarm = tonumber(string.sub(GetTagValue(findvehicle, "lock"), 0, 1))
                   PlayLoop(alarmList[alarm], Shape.pos, 0.5)
               end
            end
   
end

--fix the lights so call the function only one time when changing mode
--every time it calls clean the normal lights not the emergency lights
--only clean the emergency lights when turned off
--call every update if it has an animation (blinkers and emergency lights)
function update(dt)

    if not destroyed and GetBool("level.ALS.enabled") then
            blinker = HasTag(ALSVehicle, "p")
            di = GetTagValue(ALSVehicle, "p") == "1"
            esq = GetTagValue(ALSVehicle, "p") == "2"
            alerta = GetTagValue(ALSVehicle, "p") == "3"
            luz = HasTag(ALSVehicle, "l")
            luzA = HasTag(ALSVehicle, "la")
            luzAT = HasTag(ALSVehicle, "lat")
            fadm = HasTag(ALSVehicle, "fa")
            ad = HasTag(ALSVehicle, "ad")
            alarmcar = HasTag(ALSVehicle, "alarm")


            if GetPlayerVehicle() == ALSVehicle then
                brake = InputDown("down")
                brake2 = InputDown("up")
                brake3= InputDown("handbrake")
                brakerelease = InputReleased("down") or InputReleased("up") or InputReleased("handbrake")

                if InputPressed("down") then
                    counter=counter+1
                end

                if InputPressed("r") then
                    SetTag(ALSVehicle, "update")
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
            else
                forceback=false
                brake=false
                brake2=false
                brake3=false
            end

            

            --emergency lights
            if HasTag(ALSVehicle, "emergency") then
                reset[1]=lightsOn
                reset[2]=direcional

                lightsOn = HasTag(ALSVehicle, "em")
                lights1 = GetTagValue(ALSVehicle, "em") == "1"
                lights2 = GetTagValue(ALSVehicle, "em") == "2"
                lights3 = GetTagValue(ALSVehicle, "em") == "3"
                direcional = HasTag(ALSVehicle, "di")

                if reset[1]~=lightsOn and not lightsOn or reset[2]~=direcional and not direcional then
                    resetEM=true
                end

                if lightsOn or direcional then

                    if HasTag(ALSVehicle, "update") then
                        pry = {
                            tonumber(string.sub(GetTagValue(ALSVehicle, "pry"), 1,2)),
                            tonumber(string.sub(GetTagValue(ALSVehicle, "pry"), 3,4)),
                            tonumber(string.sub(GetTagValue(ALSVehicle, "pry"), 5,6)),
                            tonumber(string.sub(GetTagValue(ALSVehicle, "pry"), 7,8)),
                            tonumber(string.sub(GetTagValue(ALSVehicle, "pry"), 9,10)),
                            tonumber(string.sub(GetTagValue(ALSVehicle, "pry"), 11,12)),
                            tonumber(string.sub(GetTagValue(ALSVehicle, "pry"), 13,14)),
                            tonumber(string.sub(GetTagValue(ALSVehicle, "pry"), 15,16)),
                            tonumber(string.sub(GetTagValue(ALSVehicle, "pry"), 17,18)),
                        } 
                        sec = {
                            tonumber(string.sub(GetTagValue(ALSVehicle, "sec"), 1,2)),
                            tonumber(string.sub(GetTagValue(ALSVehicle, "sec"), 3,4)),
                            tonumber(string.sub(GetTagValue(ALSVehicle, "sec"), 5,6)),
                            tonumber(string.sub(GetTagValue(ALSVehicle, "sec"), 7,8)),
                            tonumber(string.sub(GetTagValue(ALSVehicle, "sec"), 9,10)),
                            tonumber(string.sub(GetTagValue(ALSVehicle, "sec"), 11,12)),
                            tonumber(string.sub(GetTagValue(ALSVehicle, "sec"), 13,14)),
                            tonumber(string.sub(GetTagValue(ALSVehicle, "sec"), 15,16)),
                            tonumber(string.sub(GetTagValue(ALSVehicle, "sec"), 17,18)),
                        }
                        ter = {
                            tonumber(string.sub(GetTagValue(ALSVehicle, "ter"), 1,2)),
                            tonumber(string.sub(GetTagValue(ALSVehicle, "ter"), 3,4)),
                            tonumber(string.sub(GetTagValue(ALSVehicle, "ter"), 5,6)),
                            tonumber(string.sub(GetTagValue(ALSVehicle, "ter"), 7,8)),
                            tonumber(string.sub(GetTagValue(ALSVehicle, "ter"), 9,10)),
                            tonumber(string.sub(GetTagValue(ALSVehicle, "ter"), 11,12)),
                            tonumber(string.sub(GetTagValue(ALSVehicle, "ter"), 13,14)),
                            tonumber(string.sub(GetTagValue(ALSVehicle, "ter"), 15,16)),
                            tonumber(string.sub(GetTagValue(ALSVehicle, "ter"), 17,18)),
                        }
                        RemoveTag(ALSVehicle, "update")
                    end
                        

                    lightsOptions()
                    
                    frame = frame + dt*60
                    local period = 120
                    local t = math.ceil(frame) % period
                    patter(t)
                    if frame > period then
                        frame = 0
                    end
                end
        
                if  HasTag(ALSVehicle, "GF") then
                    giroflexemergencia()
                end

                if resetEM then
                    for i = 1, #lightShapesEM do
                        SetShapeEmissiveScale(lightShapesEM[i], 0)
                    end
                    resetEM=false
                end

            end
            --end emergency lights

        if not lightsOn then
            for i = 1, #lightShapes do
                    SetShapeEmissiveScale(lightShapes[i], 0)
            end
        end

 


            --normal lights
            --fix this call only one time when changing mode

            if blinker or luz or luzAT or ad or brake or forceback or brake or brake2 or brake3 or alarmcar then

                if blinker then
                    frame2 = frame2 + dt*60
                    if alarmcar then
                        period2 = 30
                    elseif piscatemp or piscatemp2 then
                        period2 = 16
                    else
                        period2 = 50
                    end
                    
                    local t2 = math.ceil(frame2) % period2
                    NormalLights(t2)
                    if alarmcar then
                        if frame2 > period2 then
                            frame2 = 0
                        end
                    elseif piscatemp or piscatemp2 then
                        if frame2 > 3*period2 then
                            frame2 = 0
                            piscatemp = false
                            piscatemp2 = false
                            RemoveTag(ALSVehicle, "p")
                        end
                    else
                        if frame2 > period2 then
                            frame2 = 0
                        end
                    end


                elseif not turnofflights then
                    NormalLights() 
                end
            end

            
            --pop up headlights
            --call one time when turning lights on and off
            if HasTag(ALSVehicle, "UP") then
                    popupheadlights()
            end


        --if the life reach 0
        if GetVehicleHealth(ALSVehicle) == 0 then
            destroyed = true
            for i = 1, #lightShapes do
                SetShapeEmissiveScale(lightShapes[i], 0)
                Delete(lightShapes[i])
            end

            lightShapes = FindShapes("ALSlight")
            if HasTag(ALSVehicle, "emergency") then
                for i = 1, #lightShapesEM do
                    SetShapeEmissiveScale(lightShapesEM[i], 0)
                    Delete(lightShapesEM[i])
                    lightShapesEM = FindShapes("ALSem")
                end
                lightShapesEM = FindShapes("ALSem")
            end

            if HasTag(ALSVehicle, "GF") then
                for i = 1, #GiroflexLight do 
                    SetShapeEmissiveScale(GiroflexLight[i], 0) 
                    Delete(GiroflexLight[i])
                end

                GiroflexLight = FindShapes("ALSGF")
            end

        end
    end
end
