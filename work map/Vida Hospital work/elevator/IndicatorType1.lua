function tick()	
	screen = UiGetScreen()
    carID = GetTagValue(screen, "CarID")
end

function draw()
	if screen == 0 then
		return
	end	
	UiTranslate(0, 0)
	UiImage("MOD/elevator/indicatorscreen.png")
	UiAlign("left middle")
	if GetBool("level.EV"..carID.."IsOn") == true then
	local currentFloor = GetString("level.EV"..carID.."flr")
	local dir = GetInt("level.EV"..carID.."dir")
	UiFont("MOD/elevator/DisplayFont2.ttf", 100)
	UiColor(1.0, 0.0, 0.0)
	UiTranslate(15, 50) --Indicator dimensions: 150 x 100
	if GetBool("level.EV"..carID.."INS") == false and GetBool("level.EV"..carID.."FIRE") == false then
		if dir==1 then
			UiImage("MOD/elevator/arrowUthin.png")
		elseif dir==-1 then
			UiImage("MOD/elevator/arrowDthin.png")
		end
	elseif GetBool("level.EV"..carID.."INS") == true then
		UiTranslate(-10, 0)
		UiImage("MOD/elevator/ins.png")
		UiTranslate(10, 0)
	elseif GetBool("level.EV"..carID.."FIRE") == true then
		UiTranslate(-10, 0)
		UiImage("MOD/elevator/fire.png")
		UiTranslate(10, 0)
	end
	UiAlign("right middle")
	UiTranslate(125, 0)
	UiText(currentFloor)
	end
end