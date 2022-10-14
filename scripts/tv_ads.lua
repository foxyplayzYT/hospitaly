#include "game.lua"


function justPassed(t)
	return gTime >= t and gTimeLast < t
end


function getFirst(str,split)
	split = split or " "
	i = string.find(str, split)
	if i then
		return string.sub(str, 1, i-1)
	else 
		return str
	end
end

function getSecond(str, split)
	split = split or " "
	i = string.find(str, split)
	if i then
		return string.sub(str, i+1, string.len(str))
	end
	return ""
end

function split (inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={}
        --print("****************\n")
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        		--print("str: " .. str .. " | " .. sep)
                table.insert(t, str)
        end
        --print("****************\n")
        return t
end



--------------------------------------------------------------------------------------------------------------------


function pause(dt, params)
	return gTime < params.length
end


--------------------------------------------------------------------------------------------------------------------

function newsIntro(dt, params)
	if gTime == 0 then
		logo = 0
		breaking = -400
		news = 400
		white = 0
		UiSound("tv/news-intro.ogg")
	end

	if justPassed(0.2) then
		SetValue("logo", 8, "bounce", 1)
	end
	if justPassed(1.3) then
		SetValue("breaking", 30, "easeout", 0.4)
	end
	if justPassed(1.5) then
		SetValue("news", 30, "easeout", 0.4)
	end
	if justPassed(1.9) then
		white = 0.5
		SetValue("white", 0, "linear", 1.4)
	end

	UiPush()
		UiTranslate(UiCenter(), UiMiddle())
		UiFont("bold.ttf", 24)
		UiColor(0.5,0,0)
		UiPush()
			UiTranslate(0, -50)
			UiScale(logo)
			UiAlign("center middle")
			UiText("LCN")
		UiPop()
		UiPush()
			UiTranslate(breaking, 70)
			UiScale(3.0)
			UiAlign("right")
			UiText("Breaking")
		UiPop()
		UiPush()
			UiTranslate(news, 70)
			UiScale(3.0)
			UiAlign("left")
			UiText("News")
		UiPop()
	UiPop()
	UiColor(1,1,1,white)
	UiRect(640, 480)
	
	return gTime < 4.0
end

function newsOutro(dt, params)
	host = "Host - Catlyn Sandstream"

	if gTime == 0 then
		logo = 0
		breaking = -400
		news = 400
		white = 0
		UiSound("tv/news-outro.ogg")
	end

	UiImage("tv/news_end.jpg")

	UiPush()
		UiFont("bold.ttf", 24)
		UiAlign("left middle")
		UiTranslate(0, 380)
		UiColor(1,1,1, 0.5)
		UiRect(330, 30)
		UiColor(0,0,0)
		UiTranslate(10, 0)
		UiText(host)
	UiPop()

	if justPassed(0.2) then
		SetValue("logo", 8, "bounce", 1)
	end
	
	UiPush()
		UiTranslate(UiCenter(), UiMiddle())
		UiFont("bold.ttf", 24)
		UiColor(0.5,0,0)
		UiPush()
			UiTranslate(0, -50)
			UiScale(logo)
			UiAlign("center middle")
			UiText("LCN")
		UiPop()
	UiPop()
	UiColor(1,1,1,white)
	UiRect(640, 480)
	
	return gTime < 4.0
end


--------------------------------------------------------------------------------------------------------------------

function mysteryIntro(dt, params)
	local lengthTime = 8
	
	if gTime == 0 then
		creep = 500
		SetValue("creep", 0, "easeout", 1.4)
		UiSound("tv/mystery.ogg")
		sia1 = 0
		sia2 = 0
		sia3 = 0
		sia4 = 0
		sis1 = 0
		sis2 = 0
		sis3 = 0
		sis4 = 0
	end


	--subimage1
	if justPassed(0.5) then
		SetValue("sia1", 1, "easein", 1)
		SetValue("sis1", 4, "linear", 4)
	end
	if justPassed(2.5) then
		SetValue("sia1", 0, "easeout", 3)
	end

	--subimage2
	if justPassed(1.5) then
		SetValue("sia2", 1, "easein", 1)
		SetValue("sis2", 4, "linear", 4)
	end
	if justPassed(3.5) then
		SetValue("sia2", 0, "easeout", 3)
	end

	--subimage3
	if justPassed(2.5) then
		SetValue("sia3", 1, "easein", 1)
		SetValue("sis3", 4, "linear", 4)
	end
	if justPassed(4.5) then
		SetValue("sia3", 0, "easeout", 3)
	end

	--subimage4
	if justPassed(3.5) then
		SetValue("sia4", 1, "easein", 1)
		SetValue("sis4", 4, "linear", 4)
	end
	if justPassed(5.5) then
		SetValue("sia4", 0, "easeout", 3)
	end

	UiPush()
		local subImageSizeFactor = 0.5
		local subImageMoveFactor = 0.25
		local subImageMoveLength = UiWidth() / (lengthTime*2)

		-- BG eye
		UiPush()
			UiAlign("center middle")
			UiTranslate(UiCenter(), UiMiddle())
			UiColorFilter(1,1,1,gTime)
			UiScale(1+gTime*0.1)
			UiImage("tv/mystery-eye.jpg")
		UiPop()
		-- Subimage1
		UiPush()
			UiAlign("center middle")
			UiTranslate(UiCenter() + sis1*subImageMoveLength, UiMiddle() + sis1*subImageMoveLength)
			UiColorFilter(1,1,1,sia1)
			UiScale(sis1*subImageSizeFactor)
			UiImage("tv/mystery-ankh.png")
		UiPop()
		-- Subimage1
		UiPush()
			UiAlign("center middle")
			UiTranslate(UiCenter() + sis2*subImageMoveLength, UiMiddle() - sis2*subImageMoveLength)
			UiColorFilter(1,1,1,sia2)
			UiScale(sis2*subImageSizeFactor)
			UiImage("tv/mystery-ufo.png")
		UiPop()
		-- Subimage3
		UiPush()
			UiAlign("center middle")
			UiTranslate(UiCenter() - sis3*subImageMoveLength, UiMiddle() - sis3*subImageMoveLength)
			UiColorFilter(1,1,1,sia3)
			UiScale(sis3*subImageSizeFactor)
			UiImage("tv/mystery-ufonews.png")
		UiPop()
		-- Subimage4
		UiPush()
			UiAlign("center middle")
			UiTranslate(UiCenter() - sis4*subImageMoveLength, UiMiddle() + sis4*subImageMoveLength)
			UiColorFilter(1,1,1,sia4)
			UiScale(sis4*subImageSizeFactor)
			UiImage("tv/mystery-pyramids.png")
		UiPop()

		UiColor(0.5, 0, 0, 1)
		UiFont("bold.ttf", 96)
		UiTranslate(0, creep)
		UiPush()
			UiTranslate(UiCenter() - 160 + math.sin(gTime*2.2) * 12, UiMiddle() - 120 + math.sin(gTime*2) * 20)
			UiText("T")
		UiPop()
		UiPush()
			UiTranslate(UiCenter() - 80 - math.sin(gTime*1.8) * 16, UiMiddle() - 120 - math.sin(gTime*2.4) * 14)
			UiText("H")
		UiPop()
		UiPush()
			UiTranslate(UiCenter() + 0 + math.sin(gTime*2.6) * 18, UiMiddle() - 120 + math.sin(gTime*1.8) * 16)
			UiText("E")
		UiPop()

		UiPush()
			UiTranslate(UiCenter() - 280 + math.sin(gTime*2.2) * 12, UiMiddle() + math.sin(gTime*2) * 20)
			UiText("M")
		UiPop()
		UiPush()
			UiTranslate(UiCenter() - 160 - math.sin(gTime*1.8) * 12, UiMiddle() - math.sin(gTime*2.4) * 14)
			UiText("Y")
		UiPop()
		UiPush()
			UiTranslate(UiCenter() - 80 + math.sin(gTime*2.6) * 20, UiMiddle() + math.sin(gTime*1.8) * 14)
			UiText("S")
		UiPop()
		UiPush()
			UiTranslate(UiCenter() - 0 - math.sin(gTime*2.8) * 8, UiMiddle() - math.sin(gTime*3) * 10)
			UiText("T")
		UiPop()
		UiPush()
			UiTranslate(UiCenter() + 80 + math.sin(gTime*1.1) * 13, UiMiddle() + math.sin(gTime*1.5) * 18)
			UiText("E")
		UiPop()
		UiPush()
			UiTranslate(UiCenter() + 160 - math.sin(gTime*3.2) * 18, UiMiddle() - math.sin(gTime*2.2) * 12)
			UiText("R")
		UiPop()
		UiPush()
			UiTranslate(UiCenter() + 240 + math.sin(gTime*2.3) * 14, UiMiddle() + math.sin(gTime*2.8) * 6)
			UiText("Y")
		UiPop()

		UiPush()
			UiTranslate(UiCenter() - 80 + math.sin(gTime*2.2) * 12, UiMiddle() + 120 + math.sin(gTime*2) * 18)
			UiText("S")
		UiPop()
		UiPush()
			UiTranslate(UiCenter() - 0 - math.sin(gTime*1.8) * 10, UiMiddle() + 120 - math.sin(gTime*2.4) * 14)
			UiText("H")
		UiPop()
		UiPush()
			UiTranslate(UiCenter() + 80 + math.sin(gTime*2.6) * 16, UiMiddle() + 120 + math.sin(gTime*1.8) * 20)
			UiText("O")
		UiPop()
		UiPush()
			UiTranslate(UiCenter() + 160 + math.sin(gTime*2.6) * 14, UiMiddle() + 120 + math.sin(gTime*1.8) * 12)
			UiText("W")
		UiPop()
	UiPop()
	
	return gTime < lengthTime
end


--------------------------------------------------------------------------------------------------------------------

function diyIntro(dt, params)
	local lengthTime = 8
	
	if gTime == 0 then
		creep = 500
		SetValue("creep", 0, "easeout", 1.4)
		UiSound("tv/diy-intro.ogg")
		sia1 = 0
		sia2 = 0
		sia3 = 0
		sia4 = 0
		sis1 = 0
		sis2 = 0
		sis3 = 0
		sis4 = 0
	end


	--subimage1
	if justPassed(0.5) then
		SetValue("sia1", 1, "easein", 1)
		SetValue("sis1", 4, "linear", 4)
	end
	if justPassed(2.5) then
		SetValue("sia1", 0, "easeout", 3)
	end

	--subimage2
	if justPassed(1.5) then
		SetValue("sia2", 1, "easein", 1)
		SetValue("sis2", 4, "linear", 4)
	end
	if justPassed(3.5) then
		SetValue("sia2", 0, "easeout", 3)
	end

	--subimage3
	if justPassed(2.5) then
		SetValue("sia3", 1, "easein", 1)
		SetValue("sis3", 4, "linear", 4)
	end
	if justPassed(4.5) then
		SetValue("sia3", 0, "easeout", 3)
	end

	--subimage4
	if justPassed(3.5) then
		SetValue("sia4", 1, "easein", 1)
		SetValue("sis4", 4, "linear", 4)
	end
	if justPassed(5.5) then
		SetValue("sia4", 0, "easeout", 3)
	end

	UiPush()
		local subImageSizeFactor = 0.5
		local subImageMoveFactor = 0.25
		local subImageMoveLength = UiWidth() / (lengthTime*2)

		-- BG eye
		UiPush()
			UiAlign("center middle")
			UiTranslate(UiCenter(), UiMiddle())
			UiColorFilter(1,1,1,gTime)
			UiScale(1+gTime*0.1)
			UiImage("tv/diybg.jpg")
		UiPop()
		-- Subimage1
		UiPush()
			UiAlign("center middle")
			UiTranslate(UiCenter() + sis1*subImageMoveLength, UiMiddle() + sis1*subImageMoveLength)
			UiColorFilter(1,1,1,sia1)
			UiScale(sis1*subImageSizeFactor)
			UiImage("tv/diy1.png")
		UiPop()
		-- Subimage1
		UiPush()
			UiAlign("center middle")
			UiTranslate(UiCenter() + sis2*subImageMoveLength, UiMiddle() - sis2*subImageMoveLength)
			UiColorFilter(1,1,1,sia2)
			UiScale(sis2*subImageSizeFactor)
			UiImage("tv/diy2.png")
		UiPop()
		-- Subimage3
		UiPush()
			UiAlign("center middle")
			UiTranslate(UiCenter() - sis3*subImageMoveLength, UiMiddle() - sis3*subImageMoveLength)
			UiColorFilter(1,1,1,sia3)
			UiScale(sis3*subImageSizeFactor)
			UiImage("tv/diy3.png")
		UiPop()
		-- Subimage4
		UiPush()
			UiAlign("center middle")
			UiTranslate(UiCenter() - sis4*subImageMoveLength, UiMiddle() + sis4*subImageMoveLength)
			UiColorFilter(1,1,1,sia4)
			UiScale(sis4*subImageSizeFactor)
			UiImage("tv/diy4.png")
		UiPop()
	UiPop()
	
	return gTime < lengthTime
end


--------------------------------------------------------------------------------------------------------------------


function news(dt, params)
	reporter = params.reporter or "reporter"
	public = params.public or "man"

	if gTime == 0 then
		tickerPos = 900
		done = false
		hideticker = 1
		event = 0
		eventTimer = 0.0
		eventTime = 0.0
		endSound = false
				
		randomStudio = math.random(0,3)
		randomReporter = math.random(0,3)

	end

	if justPassed(1.0) then
		SetValue("hideticker", 0, "easeout", 0.4)
	end

	if eventTimer <= 0.0 then
		event = event + 1
		if event > #params.events then
			event = 1
		end
		eventTimer = 5.0
		eventTime = 0.0
	end
	
	if event > 0 then
		local prevFirst = ""
		local prevSecond = ""
		if event > 1 then
			prevFirst = getFirst(params.events[event-1])
			prevSecond = getSecond(params.events[event-1])
		end

		local nextFirst = ""
		local nextSecond = ""
		if event < #params.events-1 then
			nextFirst = getFirst(params.events[event+1])
			nextSecond = getSecond(params.events[event+1])
		end

		if prevFirst == "reporter" or prevFirst == "interview" then prevSecond = "" end
		if nextFirst == "reporter" or nextFirst == "interview" then nextSecond = "" end

		local e = params.events[event]
		local first = getFirst(e)
		local second = getSecond(e)
		if first == "studio" then
			if blink then
				UiImage("tv/news_blink.jpg")
			else
				if talk then
					UiImage("tv/news_talk.jpg")
				else
					UiImage("tv/news.jpg")
				end
			end
			if second ~= "" then
				UiPush()
					local t = 1.0
					if second == prevSecond and eventTime < 0.5 then
						t = eventTime*2.0
					end
					if second == nextSecond and eventTimer < 0.5 then
						t = eventTimer*2.0
					end
					UiTranslate(320*t, 70*t)
					UiScale(1.0-0.6*t)
					UiImage(second)
				UiPop()
			end
		elseif first == "still" then
			UiImage(second)
		elseif first == "zoom" then
			UiPush()
				UiAlign("center middle")
				UiTranslate(UiCenter(), UiMiddle())
				UiScale(1 + eventTime*0.03)
				UiImage(second)
			UiPop()
		elseif first == "shake" then
			UiPush()
				UiTranslate(UiCenter() + shakeX*10, UiMiddle() + shakeY*10)
				UiAlign("center middle")
				UiScale(1.05)
				UiPush()
					UiRotate(math.deg((shakeX+shakeY)*0.005))
					UiImage(second)
				UiPop()
				UiTranslate(-shakeX*5, -shakeY*5)
				UiRotate(math.deg((shakeX+shakeY)*0.002))
				if gFrame%130 < 5 then
					UiImage("tv/" .. reporter .. "_blink.png")
				else
					if talk then
						UiImage("tv/" .. reporter .. "_talk.png")
					else
						UiImage("tv/" .. reporter .. ".png")
					end
				end
			UiPop()
		elseif first == "reporter" then
			UiPush()				
				UiTranslate(UiCenter() + shakeX*10, UiMiddle() + shakeY*10)
				UiAlign("center middle")
				UiScale(1.05)
				UiPush()
					UiRotate(math.deg((shakeX+shakeY)*0.005))
					UiImage(second)
				UiPop()
				UiTranslate(-shakeX*5, -shakeY*5)
				UiRotate(math.deg((shakeX+shakeY)*0.002))
				if reporter ~= "" then
					if blink then
						UiImage("tv/" .. reporter .. "_blink.png")
					else
						if talk then
							UiImage("tv/" .. reporter .. "_talk.png")
						else
							UiImage("tv/" .. reporter .. ".png")
						end
					end
				end
			UiPop()
		elseif first == "interview" then
			UiPush()				
				UiTranslate(UiCenter() + shakeX*10, UiMiddle() + shakeY*10)
				UiAlign("center middle")
				UiScale(1.05)
				UiPush()
					UiRotate(math.deg((shakeX+shakeY)*0.005))
					UiImage(second)
				UiPop()
				UiTranslate(-shakeX*5, -shakeY*5)
				UiImage("tv/" .. public .. ".png")
				UiTranslate(-shakeX*5, -shakeY*5)
				UiRotate(math.deg((shakeX+shakeY)*0.002))
				if reporter ~= "" then
					if blink then
						UiImage("tv/" .. reporter .. "_blink.png")
					else
						if talk then
							UiImage("tv/" .. reporter .. "_talk.png")
						else
							UiImage("tv/" .. reporter .. ".png")
						end
					end
				end
			UiPop()
		end
		
		if first == "reporter" or first == "interview" then
			UiSoundLoop("tv/reporter" .. randomReporter .. ".ogg", .5)
		else
			UiSoundLoop("tv/studio" .. randomStudio .. ".ogg", .5)
		end
	end
	
	eventTimer = eventTimer - dt
	eventTime = eventTime + dt
	
	UiPush()
		UiTranslate(0, 390 + 120*hideticker)
		UiColor(0.3, 0.0, 0.0)
		UiRect(640, 60)

		UiPush()
			UiFont("bold.ttf", 24)
			UiAlign("left middle")
			UiTranslate(0, -15)
			UiColor(1,1,1, 0.5)
			UiRect(330, 30)
			UiColor(0,0,0)
			UiTranslate(10, 0)
			UiText(params.title)
		UiPop()
		
		UiColor(1,1,1)
		UiTranslate(tickerPos, 30)
		tickerPos = tickerPos - dt*170
		UiFont("bold.ttf", 24)
		UiScale(2.0)
		UiAlign("left middle")
		local w, h = UiText(params.ticker)
		if tickerPos + w*2.0 < 0 then
			done = true
		end
	UiPop()

	UiPush()
		UiTranslate(580, 12)
		UiColor(1, 1, 1, 0.5)
		UiRect(60, 26)

		UiTranslate(10, 20)
		UiColor(0.5, 0, 0, 1)
		UiFont("bold.ttf", 24)
		UiText("LCN")
	UiPop()

	return not done
end

--------------------------------------------------------------------------------------------------------------------


function mystery(dt, params)
	if gTime == 0 then
		done = false
		event = 0
		subs = false
		eventTimer = 0.0
		eventTime = 0.0
		alpha = 3
		eventLength = params.eventlength
		bgimage = params.bgimage
		bgsound = params.bgsound
	end
	UiPush()

	if eventTimer <= 0.0 then
		event = event + 1
		if event > #params.events then
			done = true
			event = #params.events
		end

			eventLength = getSecond(getFirst(params.events[event],"|"),"*")
			if eventLength == nil then
				eventLength = 4.0
			end
			eventTimer = eventLength
			eventTime = 0.0

	end
	
	if event > 0 and event <= #params.events then
		UiSoundLoop(bgsound)
		local e = params.events[event]
		local first = getFirst(getFirst(e,"|"),"*")
		local second = getSecond(e,"|")
		local images = split(second)
		if first == "title" then
			UiPush()
				UiPush()
					UiAlign("center middle")
					UiTranslate(UiCenter(), UiMiddle())
					if params.bgzoom > 0 then
						UiScale(1 + gTime*0.05)
					end
					UiImage(bgimage)
				UiPop()
				UiAlign("center middle")
				UiTranslate(UiWidth()/2,UiHeight()/2)
				UiScale(1+eventTime*0.1)
				UiFont("bold.ttf", 48)
				UiText(second)
			UiPop()
		elseif first == "outro" then
			alpha = alpha - dt
			UiColorFilter(1,1,1,alpha)
			UiPush()
				UiPush()
					UiAlign("center middle")
					UiTranslate(UiCenter(), UiMiddle())
					if params.bgzoom > 0 then
						UiScale(1 + gTime*0.05)
					end
					UiImage(bgimage)
				UiPop()
				UiAlign("center middle")
				UiTranslate(UiWidth()/2,UiHeight()/2)
				UiScale(1+eventTime*0.1)
				UiFont("bold.ttf", 48)
				UiText(second)
			UiPop()
		else
			UiPush()
				UiAlign("center middle")
				UiTranslate(UiCenter(), UiMiddle())
				if params.bgzoom > 0 then
					UiScale(1 + gTime*0.05)
				end
				UiImage(bgimage)
			UiPop()
			

			if #images > 1 then
				local timePerImage = eventLength/(#images)
				for i= 0, math.floor(eventTime/(timePerImage)),1 do
					UiPush()
						--if i == 0 then
						--	UiColorFilter(1,1,1,1)
						--else
							UiColorFilter(1,1,1,eventTime-timePerImage*i)
						--end
						
						--UiColorFilter(1,1,1,eventTimer)
						UiAlign("center middle")
						UiTranslate(UiWidth()/2,UiHeight()/2)
						UiImage(images[i+1])
					UiPop()
				end
			else
				UiPush()
					UiAlign("center middle")
					UiTranslate(UiWidth()/2,UiHeight()/2)
					if #images == 1 then
						UiScale(1+eventTime*0.1)
					end
					UiImage(images[1])
				UiPop()	
			end
			if eventTime > 0.5 and eventTime < eventLength-0.5 then
				subs = true
			else
				subs = false
			end
			if subs then
				UiPush()
					UiColor(0, 0, 0, 1)
					UiAlign("top left")
					UiFont("bold.ttf", 32)
					local textw, texth = UiGetTextSize(first)
					UiTranslate(UiWidth()/2 - textw/2 - 10,UiHeight()-100 - 10)
					UiRect(textw + 10, texth + 10)
					UiColor(1, 1, 1, 1)
					UiTranslate(5,5)
					UiText(first)
				UiPop()
			end
		end
		UiPop()
	end
	
	eventTimer = eventTimer - dt
	eventTime = eventTime + dt
	
	return not done
end


--------------------------------------------------------------------------------------------------------------------



function commercial1(dt, params)
	if gTime == 0 then
		UiSound("tv/auction.ogg")
		top = 0
		middle = 0
		bottom = 0
	end

	if justPassed(1.0) then
		SetValue("top", 1, "linear", 0.3)
	end
	if justPassed(2.0) then
		SetValue("middle", 1, "linear", 0.3)
	end
	if justPassed(3.0) then
		SetValue("bottom", 1, "linear", 0.3)
	end

	UiImage(params.image)

	UiAlign("center middle")
	UiFont("bold.ttf", 24)

	if params.top then
		UiPush()
			local a = top
			UiTranslate(UiCenter(), UiMiddle()-100 - (1.0-a)*200)
			UiScale(2.0)
			UiTextOutline(0, 0, 0, a, 0.2)
			UiColor(1, 1, 1, a)
			UiText(params.top)
		UiPop()
	end
	if params.middle then
		UiPush()
			local a = middle
			UiTranslate(UiCenter(), 240)
			UiScale(3.0*a)
			UiTextOutline(0, 0, 0, a, 0.2)
			UiColor(0.5, 1, 1, a)
			UiText(params.middle)
		UiPop()
	end
	if params.bottom then
		UiPush()
			local a = bottom
			UiTranslate(UiCenter(), UiMiddle()+100 + (1.0-a)*200)
			UiScale(2.0)
			UiTextOutline(0, 0, 0, a, 0.2)
			UiColor(1, 1, 0, a)
			UiText(params.bottom)
		UiPop()
	end

	return gTime < 8
end


--------------------------------------------------------------------------------------------------------------------



function commercial(dt, params)
	if gTime == 0 then
		UiSound(params.audio)
		top1 = 0
		bottom1 = 0
		top2 = 0
		bottom2 = 0
		image2 = 0
		fade = 1

		color1 = params.color1 or {r=1, g=1, b=1}
		color2 = params.color2 or {r=1, g=1, b=1}
		color3 = params.color3 or {r=1, g=1, b=1}
		color4 = params.color4 or {r=1, g=1, b=1}

		font1 = params.font1 or "bold.ttf"
		font2 = params.font2 or "bold.ttf"
		font3 = params.font3 or "bold.ttf"
		font4 = params.font4 or "bold.ttf"

		size1 = params.size1 or 24
		size2 = params.size2 or 24
		size3 = params.size3 or 24
		size4 = params.size4 or 24
	end

	if justPassed(1.0) then
		SetValue("top1", 1, "linear", 0.3)
	end
	if justPassed(2.0) then
		SetValue("bottom1", 1, "linear", 0.3)
	end
	
	if justPassed(4.8) then
		SetValue("fade", 0, "easeout", 0)
	end

	if justPassed(5.0) then
		SetValue("top2", 1, "linear", 0.3)
	end
	if justPassed(6.0) then
		SetValue("bottom2", 1, "linear", 0.3)
	end

	if gTime >= 5.0 then
		UiPush()
			if params.zoom2 then
				UiAlign("center middle")
				UiTranslate(UiCenter(), UiMiddle())
				UiScale(1 + gTime*0.03)
			end
			UiImage(params.image2)
		UiPop()
		UiAlign("center middle")
	end

	if params.text3 then
		UiPush()
			local a = top2
			UiFont(font3, size3)
			UiTranslate(UiCenter(), UiMiddle()-150 - (1.0-a)*200)
			UiScale(2.5)
			UiTextOutline(0, 0, 0, a, 0.3)
			UiColor(color3.r, color3.g, color3.b, a)
			UiText(params.text3)
		UiPop()
	end
	if params.text4 then
		UiPush()
			local a = bottom2
			UiFont(font4, size4)
			UiTranslate(UiCenter(), UiMiddle()+150 + (1.0-a)*200)
			UiScale(2.5)
			UiTextOutline(0, 0, 0, a, 0.3)
			UiColor(color4.r, color4.g, color4.b, a)
			UiText(params.text4)
		UiPop()
	end

	if gTime < 5.0 then
		UiPush()
			if params.zoom1 then
				UiAlign("center middle")
				UiTranslate(UiCenter(), UiMiddle())
				UiScale(1 + gTime*0.03)
			end
			UiImage(params.image1)
		UiPop()
		
		UiAlign("center middle")

		if params.text1 then
			UiPush()
				local a = top1
				UiFont(font1, size1)	
				UiTranslate(UiCenter(), UiMiddle()-150 - (1.0-a)*200)
				UiScale(2.5)
				UiTextOutline(0, 0, 0, a, 0.3)
				UiColor(color1.r, color1.g, color1.b, a)
				UiText(params.text1)
			UiPop()
		end
		if params.text2 then
			UiPush()
				local a = bottom1
				UiFont(font2, size2)
				UiTranslate(UiCenter(), UiMiddle()+150 + (1.0-a)*200)
				UiScale(2.5)
				UiTextOutline(0, 0, 0, a, 0.3)
				UiColor(color2.r, color2.g, color2.b, a)
				UiText(params.text2)
			UiPop()
		end
	end
	
	return gTime < 11
end


--------------------------------------------------------------------------------------------------------------------


function addShow(showFunc, showParams)
	gShows[#gShows+1] = {func = showFunc, params = showParams}
end


function isMissionCompleted(missionId)
	return GetInt("savegame.mission."..missionId..".score") > 0
end


function init()
	gTime = 0
	gTimeLast = 0
	gFrame = 0
	gFadeToBlack = 0

	gShows = {}
	addShow(pause, {length = 1})

	local lastCompleted = GetString("savegame.lastcompleted")

		addShow(commercial1, {image="tv/auction.jpg", top="Black River", middle="Classic car auction", bottom="  This Wednesday\nCall 555-188-2789"})
		addShow(commercial,
			{
				audio = "tv/gubbgrill.ogg",
				image1 = "tv/ad-gubbgrill1.jpg",
				zoom1 = true,
				text1 = "Decent food",
				text2 = "Decent prices",
				image2 = "tv/ad-gubbgrill2.jpg",
				text3 = "In Westpoint marina",
				text4 = "Try our special!",
				size1 = 18,
				size2 = 18,
				size3 = 18,
				size4 = 18,
				color1 = {r=1, g=0, b=0},
				color2 = {r=1, g=1, b=0},
				color3 = {r=1, g=0, b=0},
				color4 = {r=1, g=1, b=0},
			}	
		)
		addShow(commercial,
			{
				audio = "tv/expensive-kitchenware.ogg",
				image1 = "tv/ad-knife1.jpg",
				zoom1 = true,
				text1 = "Sharp.",
				text2 = "Simple.",
				image2 = "tv/ad-knife2.jpg",
				text3 = "Expensive.",
				text4 = "Knives.",
				color1= {r=0, g=0, b=0},
				color2= {r=0, g=0, b=0},
				color3= {r=0, g=0, b=0},
				color4= {r=0, g=0, b=0},
			}	
		)
		addShow(commercial,
			{
				audio = "tv/parade.ogg",
				text1 = "Löckelle celebrations!",
				image1 = "tv/ad-parade1.jpg",
				text2 = "Home guard parade",
				image2 = "tv/ad-parade2.jpg",
				zoom2 = true,
				text3 = "Live music and fireworks!",
				size4 = 20,
				text4 = "See you at Evertides Mall!",
			}	
		)
		addShow(commercial,
			{
				audio = "tv/bayran.ogg",
				image1 = "tv/ad-bayrans1.jpg",
				zoom1 = true,
				text1 = "When you are looking for",
				text2 = "a bright future",
				image2 = "tv/ad-bayrans2.jpg",
				text3 = "Choose",
				color3= {r=0, g=0, b=0},
				text4 = "Bayrans",
				size4 = 42,
				color4= {r=0, g=0, b=0},
			}	
		)
		addShow(commercial,
			{
				audio = "tv/bluetide.ogg",
				image1 = "tv/ad-bluetide1.jpg",
				image2 = "tv/ad-bluetide3.jpg",
				zoom1 = true,
				text1 = "BlueTide",
				size1 = 36,
				text2 = "It's a lifestyle",
			}	
		)
		addShow(commercial,
			{
				audio = "tv/russian-caviar.ogg",
				image1 = "tv/ad-caviar1.jpg",
				zoom1 = true,
				text1 = "Want to impress?",
				text2 = "Want to flash cash?",
				image2 = "tv/ad-caviar2.jpg",
				text3 = "Russian caviar",
				color3= {r=1, g=0, b=0},
				text4 = "Goes well with\n fishy business",
			}	
		)
		addShow(commercial,
			{
				audio = "tv/expensive-kitchenware.ogg",
				image1 = "tv/ad-foodprocessor1.jpg",
				zoom1 = true,
				text1 = "Mix.",
				text2 = "Blend.",
				image2 = "tv/ad-foodprocessor2.jpg",
				text3 = "Expensive.",
				text4 = "Food processor.",
				color1= {r=0, g=0, b=0},
				color2= {r=0, g=0, b=0},
				color3= {r=0, g=0, b=0},
				color4= {r=0, g=0, b=0},
			}	
		)
		addShow(commercial,
			{
				audio = "tv/bluetide.ogg",
				image1 = "tv/ad-bluetide2.jpg",
				text2 = "It's a lifestyle",
				image2 = "tv/ad-bluetide4.jpg",
				zoom2 = true,
				text3 = "BlueTide Extra Strong",
				text4 = "limited edition - $75",
			}	
		)
		addShow(commercial,
			{
				audio = "tv/bayran.ogg",
				image1 = "tv/sunnymax2.jpg",
				zoom1 = true,
				zoom2 = true,
				text1 = "Sun in mind",
				text2 = "Electric kind",
				image2 = "tv/sunnymax3.jpg",
				text3 = "SunnyMax solarium",
				text4 = "Like the real deal. Almost.",
				color1= {r=214/255, g=208/255, b=53/255},
				color2= {r=214/255, g=208/255, b=53/255},
				color3= {r=214/255, g=208/255, b=53/255},
				color4= {r=214/255, g=208/255, b=53/255},
			}	
		)
		addShow(commercial,
			{
				audio = "tv/bayran.ogg",
				image1 = "tv/evertides-christmas1.jpg",
				zoom1 = true,
				zoom2 = true,
				text1 = "Excited for the holidays?",
				text2 = "So are we!",
				image2 = "tv/evertides-christmas2.jpg",
				text3 = "Get in the spirit",
				text4 = "at Evertides Mall!",
				color2= {r=169/255, g=57/255, b=62/255},
				color1= {r=62/255, g=149/255, b=62/255},
				color4= {r=169/255, g=57/255, b=62/255},
				color3= {r=62/255, g=149/255, b=62/255},
			}	
		)
		addShow(commercial,
			{
				audio = "tv/bayran.ogg",
				image1 = "tv/visit-woonderland3.jpg",
				zoom1 = true,
				zoom2 = true,
				text1 = "Speed, excitement, fun!",
				text2 = "Grand opening! Wroom!",
				image2 = "tv/visit-woonderland4.jpg",
				text3 = "Treat yourselves,",
				text4 = "visit Woonderland!",
				color1= {r=149/255, g=57/255, b=62/255},
				color2= {r=196/255, g=196/255, b=196/255},
				color3= {r=149/255, g=57/255, b=62/255},
				color4= {r=196/255, g=196/255, b=196/255},
			}	
		)
		addShow(commercial,
			{
				audio = "tv/bayran.ogg",
				image1 = "tv/robot-ad2.jpg",
				zoom1 = true,
				text1 = "You have 20 seconds..",
				image2 = "tv/robot-ad1.jpg",
				text3 = "To recieve 10% off your",
				text4 = "new Quilez model 245!",
				color1= {r=149/255, g=40/255, b=40/255},
				color3= {r=1, g=1, b=1},
				color4= {r=1, g=1, b=1},
			}	
		)

	gCurrentShow = 1
	
	shakeX = 0
	shakeY = 0
	shakeDx = 0
	shakeDy = 0

	talk = false
	talkTimer = 10
	
end


function update()
	gFrame = gFrame + 1
	shakeDx = (shakeDx + math.random(-100,100)*0.0003) * 0.9
	shakeDy = (shakeDy + math.random(-100,100)*0.0003) * 0.9
	shakeX = (shakeX + shakeDx) * 0.99
	shakeY = (shakeY + shakeDy) * 0.99
	if shakeX > 1.0 then shakeX = 1.0 shakeDx = 0.0 end
	if shakeX < -1.0 then shakeX = -1.0 shakeDx = 0.0 end
	if shakeY > 1.0 then shakeY = 1.0 shakeDy = 0.0 end
	if shakeY < -1.0 then shakeY = -1.0 shakeDy = 0.0 end

	talkTimer = talkTimer - 1
	if talkTimer <= 0 then
		talk = not talk
		talkTimer = math.random(2, 10)
	end
	
	blink = (gFrame%130) < 5
end


function draw()
	if UiHeight() ~= 480 then
		UiPush()
			UiColor(0.2, 0.2, 0.2)
			UiRect(UiWidth(), UiHeight())
		UiPop()
		UiTranslate(UiCenter(), UiMiddle())
		UiAlign("center middle")
		UiWindow(640, 480, true)
		UiAlign("left")
		UiPush()
			UiColor(0,0,0)
			UiRect(UiWidth(), UiHeight())
		UiPop()
	end
	local dt = GetTimeStep()
	UiPush()
		local done = not gShows[gCurrentShow].func(dt, gShows[gCurrentShow].params)
	UiPop()

	if done then
		gFadeToBlack = gFadeToBlack + dt*3.0
		if gFadeToBlack >= 1.0 then
			gCurrentShow = gCurrentShow + 1
			if gCurrentShow > #gShows then
				gCurrentShow = 1
			end
			gTime = 0.0
			gTimeLast = 0.0
		end
	else
		if gFadeToBlack > 0.0 then
			gFadeToBlack = gFadeToBlack - dt*3.0
			if gFadeToBlack < 0.0 then gFadeToBlack = 0 end
		end
		gTimeLast = gTime
		gTime = gTime + dt
	end

	if gFadeToBlack > 0.0 then
		UiColor(0, 0, 0, gFadeToBlack)
		UiRect(640, 480)
	end
end


