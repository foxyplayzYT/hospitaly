BUTTON_SIZE = 75
BUTTON_PADDING = 9
BUTTON_Y = 480

FloorLabels = {"G","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30",}
alPlaying = false

function tick()	
	screen = UiGetScreen()
	carID = GetTagValue(screen, "CarID")
end

function draw()
	if screen == 0 then
		return
	end
	
	UiTranslate(0, 0)
	UiImage("MOD/elevator/panel-long.png")
	
	UiAlign("center middle")
	
	UiButtonHoverColor(1, 1, 1)
	UiButtonPressColor(1, 1, 1)

	-- Buttons
	UiPush()
	UiTranslate(UiCenter() - BUTTON_SIZE - BUTTON_PADDING, BUTTON_Y)
	UiFont("regular.ttf", 50)
	UiColor(0.5, 0.5, 0.5)

	local sizeAndPadding = BUTTON_SIZE + BUTTON_PADDING
	
	UiTranslate(0, sizeAndPadding*2) -- Offset from indicator

	-- Draw set of 3 buttons on 1 row
	btn = 10
	if GetBool("level.EV"..carID.."call"..btn) == true then
		UiButtonImageBox("MOD/elevator/buttonActive.png", 25, 25)
	else
		UiButtonImageBox("MOD/elevator/button.png", 25, 25)
	end
	if button(btn) then
		SetBool("level.EV"..carID.."call"..btn, true)
	end
	--
	UiTranslate(sizeAndPadding, 0)
	--
	btn = 11
	if GetBool("level.EV"..carID.."call"..btn) == true then
		UiButtonImageBox("MOD/elevator/buttonActive.png", 25, 25)
	else
		UiButtonImageBox("MOD/elevator/button.png", 25, 25)
	end
	if button(btn) then
		SetBool("level.EV"..carID.."call"..btn, true)
	end
	--
	UiTranslate(sizeAndPadding, 0)
	--
	btn = 12
	if GetBool("level.EV"..carID.."call"..btn) == true then
		UiButtonImageBox("MOD/elevator/buttonActive.png", 25, 25)
	else
		UiButtonImageBox("MOD/elevator/button.png", 25, 25)
	end
	if button(btn) then
		SetBool("level.EV"..carID.."call"..btn, true)
	end
	-- Translating back to the beginning and down and drawing next row of 3
	UiTranslate(-166, sizeAndPadding)
	--
	btn = 7
	if GetBool("level.EV"..carID.."call"..btn) == true then
		UiButtonImageBox("MOD/elevator/buttonActive.png", 25, 25)
	else
		UiButtonImageBox("MOD/elevator/button.png", 25, 25)
	end
	if button(btn) then
		SetBool("level.EV"..carID.."call"..btn, true)
	end
	--
	UiTranslate(sizeAndPadding, 0)
	--
	btn = 8
	if GetBool("level.EV"..carID.."call"..btn) == true then
		UiButtonImageBox("MOD/elevator/buttonActive.png", 25, 25)
	else
		UiButtonImageBox("MOD/elevator/button.png", 25, 25)
	end
	if button(btn) then
		SetBool("level.EV"..carID.."call"..btn, true)
	end
	--
	UiTranslate(sizeAndPadding, 0)
	--
	btn = 9
	if GetBool("level.EV"..carID.."call"..btn) == true then
		UiButtonImageBox("MOD/elevator/buttonActive.png", 25, 25)
	else
		UiButtonImageBox("MOD/elevator/button.png", 25, 25)
	end
	if button(btn) then
		SetBool("level.EV"..carID.."call"..btn, true)
	end
	--
	UiTranslate(-166, sizeAndPadding)
	--
	btn = 4
	if GetBool("level.EV"..carID.."call"..btn) == true then
		UiButtonImageBox("MOD/elevator/buttonActive.png", 25, 25)
	else
		UiButtonImageBox("MOD/elevator/button.png", 25, 25)
	end
	if button(btn) then
		SetBool("level.EV"..carID.."call"..btn, true)
	end
	--
	UiTranslate(sizeAndPadding, 0)
	--
	btn = 5
	if GetBool("level.EV"..carID.."call"..btn) == true then
		UiButtonImageBox("MOD/elevator/buttonActive.png", 25, 25)
	else
		UiButtonImageBox("MOD/elevator/button.png", 25, 25)
	end
	if button(btn) then
		SetBool("level.EV"..carID.."call"..btn, true)
	end
	--
	UiTranslate(sizeAndPadding, 0)
	--
	btn = 6
	if GetBool("level.EV"..carID.."call"..btn) == true then
		UiButtonImageBox("MOD/elevator/buttonActive.png", 25, 25)
	else
		UiButtonImageBox("MOD/elevator/button.png", 25, 25)
	end
	if button(btn) then
		SetBool("level.EV"..carID.."call"..btn, true)
	end
	--
	UiTranslate(-166, sizeAndPadding)
	--
	btn = 1
	if GetBool("level.EV"..carID.."call"..btn) == true then
		UiButtonImageBox("MOD/elevator/buttonActive.png", 25, 25)
	else
		UiButtonImageBox("MOD/elevator/button.png", 25, 25)
	end
	if button(btn) then
		SetBool("level.EV"..carID.."call"..btn, true)
	end
	--
	UiTranslate(sizeAndPadding, 0)
	--
	btn = 2
	if GetBool("level.EV"..carID.."call"..btn) == true then
		UiButtonImageBox("MOD/elevator/buttonActive.png", 25, 25)
	else
		UiButtonImageBox("MOD/elevator/button.png", 25, 25)
	end
	if button(btn) then
		SetBool("level.EV"..carID.."call"..btn, true)
	end
	--
	UiTranslate(sizeAndPadding, 0)
	--
	btn = 3
	if GetBool("level.EV"..carID.."call"..btn) == true then
		UiButtonImageBox("MOD/elevator/buttonActive.png", 25, 25)
	else
		UiButtonImageBox("MOD/elevator/button.png", 25, 25)
	end
	if button(btn) then
		SetBool("level.EV"..carID.."call"..btn, true)
	end

	UiButtonImageBox("MOD/elevator/button.png", 25, 25)
	UiTranslate(-166, sizeAndPadding+30)
	if specialButton(">|<") then
		SetBool("level.EV"..carID.."DCReq", true)
	end
	UiTranslate(sizeAndPadding, 0)
	if specialButton("!") then
		--
	end
	if UiIsMouseInRect(BUTTON_SIZE, BUTTON_SIZE) and InputDown("lmb") and GetPlayerScreen()==screen then
		PlayLoop(LoadLoop("MOD/elevator/sound/alarm.ogg"))
	end
	UiTranslate(sizeAndPadding, 0)
	if specialButton("<|>") then
		SetBool("level.EV"..carID.."DOReq", true)
	end


	UiPop()
	if GetBool("level.EV"..carID.."IsOn") == true then
	UiAlign("left middle")
	local currentFloor = GetString("level.EV"..carID.."flr")
	local dir = GetInt("level.EV"..carID.."dir")
	UiFont("MOD/elevator/DisplayFont1.ttf", 80)
	UiColor(1.0, 0.0, 0.0)
	UiTranslate(110, 140) --Indicator dimensions: 200 x 150
	if GetBool("level.EV"..carID.."INS") == false and GetBool("level.EV"..carID.."FIRE") == false then
		if dir==1 then
			UiImage("MOD/elevator/arrowU.png")
		elseif dir==-1 then
			UiImage("MOD/elevator/arrowD.png")
		end
	elseif GetBool("level.EV"..carID.."INS") == true then
		UiImage("MOD/elevator/ins.png")
	elseif GetBool("level.EV"..carID.."FIRE") == true then
		UiImage("MOD/elevator/fire.png")
	end
	UiAlign("right middle")
	UiTranslate(185, 0)
	UiText(currentFloor)
	end
end

function button(label)
	return UiTextButton(FloorLabels[label], BUTTON_SIZE, BUTTON_SIZE) or InputPressed(FloorLabels[label])
end
function specialButton(label)
	return UiTextButton(tostring(label), BUTTON_SIZE, BUTTON_SIZE) or InputPressed(tostring(label))
end