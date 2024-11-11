function init()
end

function draw()

    UiPush()
        UiColor(0, 0, 0)
        UiAlign("center bottom")
        UiRect(1920,1080)
    UiPop()

	UiTranslate(UiCenter(), 80)
	UiAlign("center middle")

	--Title
	UiFont("regular.ttf", 48)
	UiText("Vida Hospital Menu")

	--Draw buttons
	UiTranslate(150, 200)
	UiFont("regular.ttf", 26)
	UiButtonImageBox("ui/common/box-outline-6.png", 6, 6)
    UiButtonHoverColor(1, 1, 0)
    
    
    UiTranslate(0, 200)
    UiMakeInteractive()
    UiPush()
        
		UiTranslate(-450, 0)
            if UiTextButton("Normal", 200, 0) then
                UiSound("sound/click.ogg")
                StartLevel("", "MOD/map.xml","")
		    end
        
        UiTranslate(0, -200)
        UiImageBox("MOD/scripts/normal.png", 250, 250, 1, 1)
        -- end
		
		
        UiTranslate(300, 200)
		if UiTextButton("Performance", 200, 40) then
            UiSound("sound/click.ogg")
			StartLevel("", "MOD/fps.xml","")
		end

        UiTranslate(0, -200)
        UiImageBox("MOD/scripts/fps.png", 250, 250, 1, 1)
         -- end
		 	
	        UiTranslate(0, 300)
        if UiTextButton("Main Menu", 0, 0) then
            UiSound("sound/click.ogg")
            Menu()
        end
    UiPop()
	-- from italy map by dima edited by EVGSTORE and then by Mr.Random
end