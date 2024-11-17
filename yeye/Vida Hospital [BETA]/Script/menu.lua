-- Define a variable to track the button state
local menuMainPressed = false
local button1state = "1st"
local button2state = "2nd"
local button3state = "3rd"
local button4state = "4th"
local button5state = "5th"
local button6state = "6th"
local button7state = "7th"
local button8state = "8th"
local buttonTREEstate = "trees"
local buttonLIFTstate = "lift"
local buttonLIGHTstate = "lights"
local buttonVEHstate = "vehicles"
local buttonGATEstate = "gates"
local buttonSNOWstate = "snowoff"

function draw()
    UiImage("MOD/Script/menu-main.png")

    UiMakeInteractive()
    UiButtonHoverColor(.7, .7, .7)

    UiPush()
    UiAlign("center middle")
    UiScale(1)
    UiFont("bold.ttf", 100)

    UiTranslate(UiCenter() - -300, 200)
    UiPush()
    UiText("Vida Hospital")
    UiPop()

    UiTranslate(-1250, -100)

    UiPush()
    UiAlign("left")

    UiColor(0, 0, 0, 0.7)
    UiRect(540, 600, 0, 0)
    UiTranslate(30, 30)
    UiColor(1, 1, 1, 1)
    UiScale(.25)

    -- Button for main map
    if UiImageButton("MOD/Script/menu-pop.png") then
        -- Toggle the state
        menuMainPressed = not menuMainPressed
    end
    UiTranslate(900, 1000)
    UiAlign("center middle")
    UiText("Vida Hospital - Press here to play")
    UiTranslate(0, 200)
    UiText("Map By: FoxyPlayzYT, Mr.Random")
    UiAlign("left")
    UiTranslate(-900, 200)
    UiText("Credits:")
    UiTranslate(0, 100)
    UiText("Menu by Salad Fries!")
    UiTranslate(0, 100)
    UiText("ALS by Caffeine power!")
    UiTranslate(0, 100)
    UiText("Lift Test Tower 2 by Diamond!")
    UiTranslate(0, 100)
    UiText("Sectional Garage Doors by YuLun!")
    UiTranslate(0, 100)
    UiText("You! For playing the map!")
    UiTranslate(0, -1900)

    -- Configure menu
    if menuMainPressed then
        UiPush()
        UiAlign("left")

        UiScale(4)
        UiTranslate(550, -30)

        UiColor(0, 0, 0, 0.7)
        UiRect(1050, 600, 0, 0)
        UiTranslate(30, 30)
        UiColor(1, 1, 1, 1)

        UiScale(.125)

        -- 1st floor button with toggle functionality
        UiImage("MOD/Script/menu-1.png")
        UiTranslate(0, 800)
        if button1state == "1stoff" then
            if UiImageButton("MOD/Script/ToggleUnFurnished.png") then
                button1state = "1st"
            end
        else
            if UiImageButton("MOD/Script/ToggleFurnished.png") then
                button1state = "1stoff"
            end
        end
        UiTranslate(0,-50)
        UiScale(4)
        UiText("1st Floor")
        UiScale(.25)
        UiTranslate(2000, -750)

        -- 2nd floor button with toggle functionality
        UiImage("MOD/Script/menu-2.png")
        UiTranslate(0, 800)
        if button2state == "2ndoff" then
            if UiImageButton("MOD/Script/ToggleUnFurnished.png") then
                button2state = "2nd"
            end
        else
            if UiImageButton("MOD/Script/ToggleFurnished.png") then
                button2state = "2ndoff"
            end
        end
        UiTranslate(0,-50)
        UiScale(4)
        UiText("2nd Floor")
        UiScale(.25)
        UiTranslate(2000, -750)

        -- 3rd floor button with toggle functionality
        UiImage("MOD/Script/menu-3.png")
        UiTranslate(0, 800)
        if button3state == "3rdoff" then
            if UiImageButton("MOD/Script/ToggleUnFurnished.png") then
                button3state = "3rd"
            end
        else
            if UiImageButton("MOD/Script/ToggleFurnished.png") then
                button3state = "3rdoff"
            end
        end
        UiTranslate(0,-50)
        UiScale(4)
        UiText("3rd Floor")
        UiScale(.25)
        UiTranslate(2000, -750)

        -- 4th floor button with toggle functionality
        UiImage("MOD/Script/menu-4.png")
        UiTranslate(0, 800)
        if button4state == "4thoff" then
            if UiImageButton("MOD/Script/ToggleUnFurnished.png") then
                button4state = "4th"
            end
        else
            if UiImageButton("MOD/Script/ToggleFurnished.png") then
                button4state = "4thoff"
            end
        end
        UiTranslate(0,-50)
        UiScale(4)
        UiText("4th Floor")
        UiScale(.25)
        UiTranslate(-6000, 550)

        -- 5th floor button with toggle functionality
        UiImage("MOD/Script/menu-5.png")
        UiTranslate(0, 800)
        if button5state == "5thoff" then
            if UiImageButton("MOD/Script/ToggleUnFurnished.png") then
                button5state = "5th"
            end
        else
            if UiImageButton("MOD/Script/ToggleFurnished.png") then
                button5state = "5thoff"
            end
        end
        UiTranslate(0,-50)
        UiScale(4)
        UiText("5th Floor")
        UiScale(.25)
        UiTranslate(2000, -750)

        -- 6th floor button with toggle functionality
        UiImage("MOD/Script/menu-6.png")
        UiTranslate(0, 800)
        if button6state == "6thoff" then
            if UiImageButton("MOD/Script/ToggleUnFurnished.png") then
                button6state = "6th"
            end
        else
            if UiImageButton("MOD/Script/ToggleFurnished.png") then
                button6state = "6thoff"
            end
        end
        UiTranslate(0,-50)
        UiScale(4)
        UiText("6th Floor")
        UiScale(.25)
        UiTranslate(2000, -750)


        -- 7th floor button with toggle functionality
        UiImage("MOD/Script/menu-7.png")
        UiTranslate(0, 800)
        if button7state == "7thoff" then
            if UiImageButton("MOD/Script/ToggleUnFurnished.png") then
                button7state = "7th"
            end
        else
            if UiImageButton("MOD/Script/ToggleFurnished.png") then
                button7state = "7thoff"
            end
        end
        UiTranslate(0,-50)
        UiScale(4)
        UiText("7th Floor")
        UiScale(.25)
        UiTranslate(2000, -750)

        -- 8th floor button with toggle functionality
        UiImage("MOD/Script/menu-8.png")
        UiTranslate(0, 800)
        if button8state == "8thoff" then
            if UiImageButton("MOD/Script/ToggleUnFurnished.png") then
                button8state = "8th"
            end
        else
            if UiImageButton("MOD/Script/ToggleFurnished.png") then
                button8state = "8thoff"
            end
        end
        UiTranslate(0,-50)
        UiScale(4)
        UiText("8th Floor")
        UiScale(.25)
        UiTranslate(500, 550)

    

        -- Gates button with toggle functionality
        UiScale(2)
        UiText("Gates")
        UiScale(.66)
        UiTranslate(0, 100)
        UiColor(.8, .8, .8, 1)
        UiText("Toggles Ambulance Gates")
        UiTranslate(0, 100)
        UiText("Possibly reduces lag")
        UiTranslate(0, 50)
        UiScale(1.5151)
        UiScale(.25)
        UiColor(1, 1, 1, 1)
        if buttonGATEstate == "gatesoff" then
            if UiImageButton("MOD/Script/ToggleOff.png") then
                buttonGATEstate = "gates"
            end
        else
            if UiImageButton("MOD/Script/ToggleOn.png") then
                buttonGATEstate = "gatesoff"
            end
        end
        UiTranslate(-2600, -660)

        -- elevators button with toggle functionality
        UiScale(4)
        UiText("Elevators")
        UiScale(.66)
        UiTranslate(0, 100)
        UiColor(.8, .8, .8, 1)
        UiText("Toggles 3 Elevators")
        UiTranslate(0, 100)
        UiText("Keeping OFF reduces lag")
        UiTranslate(0, 50)
        UiScale(1.5151)
        UiScale(.25)
        UiColor(1, 1, 1, 1)
        if buttonLIFTstate == "liftoff" then
            if UiImageButton("MOD/Script/ToggleOff.png") then
                buttonLIFTstate = "lift"
            end
        else
            if UiImageButton("MOD/Script/ToggleOn.png") then
                buttonLIFTstate = "liftoff"
            end
        end
        UiTranslate(-2600, -660)

        -- Vehicle button with toggle functionality
        UiScale(4)
        UiText("Vehicles")
        UiScale(.66)
        UiTranslate(0, 100)
        UiColor(.8, .8, .8, 1)
        UiText("Toggles every vehicle")
        UiTranslate(0, 100)
        UiText("Possibly reduces lag")
        UiTranslate(0, 50)
        UiScale(1.5151)
        UiScale(.25)
        UiColor(1, 1, 1, 1)
        if buttonVEHstate == "vehiclesoff" then
            if UiImageButton("MOD/Script/ToggleOff.png") then
                buttonVEHstate = "vehicles"
            end
        else
            if UiImageButton("MOD/Script/ToggleOn.png") then
                buttonVEHstate = "vehiclesoff"
            end
        end
        UiTranslate(-2600, -660)

        -- Trees button with toggle functionality
        UiScale(4)
        UiText("Trees")
        UiScale(.66)
        UiTranslate(0, 100)
        UiColor(.8, .8, .8, 1)
        UiText("Toggles the Trees")
        UiTranslate(0, 100)
        UiText("Possibly reduces lag")
        UiTranslate(0, 50)
        UiScale(1.5151)
        UiScale(.25)
        UiColor(1, 1, 1, 1)
        if buttonTREEstate == "treesoff" then
            if UiImageButton("MOD/Script/ToggleOff.png") then
                buttonTREEstate = "trees"
            end
        else
            if UiImageButton("MOD/Script/ToggleOn.png") then
                buttonTREEstate = "treesoff"
            end
        end
        UiTranslate(-2600, -660)

        -- Lights button with toggle functionality
        UiScale(4)
        UiText("Lights")
        UiScale(.66)
        UiTranslate(0, 100)
        UiColor(.8, .8, .8, 1)
        UiText("Toggles the Lights")
        UiTranslate(0, 100)
        UiText("Possibly reduces lag")
        UiTranslate(0, 50)
        UiScale(1.5151)
        UiScale(.25)
        UiColor(1, 1, 1, 1)
        if buttonLIGHTstate == "lightsoff" then
            if UiImageButton("MOD/Script/ToggleOff.png") then
                buttonLIGHTstate = "lights"
            end
        else
            if UiImageButton("MOD/Script/ToggleOn.png") then
                buttonLIGHTstate = "lightsoff"
            end
        end
        UiTranslate(-2600, -660)

        -- Snow button with toggle functionality
        UiScale(4)
        UiText("Snow")
        UiScale(.66)
        UiTranslate(0, 100)
        UiColor(.8, .8, .8, 1)
        UiText("Toggles Snow")
        UiTranslate(0, 100)
        UiText("Makes the map snowy")
        UiTranslate(0, 50)
        UiScale(1.5151)
        UiScale(.25)
        UiColor(1, 1, 1, 1)
        if buttonSNOWstate == "snow" then
            if UiImageButton("MOD/Script/ToggleOn.png") then
                buttonSNOWstate = "snowoff"
            end
        else
            if UiImageButton("MOD/Script/ToggleOff.png") then
                buttonSNOWstate = "snow"
            end
        end
        UiScale(2)
        UiTranslate(0, 500)

        if UiImageButton("MOD/Script/menu-Start.png") then
            StartLevel("", "MOD/map.xml", "byounds " .. button1state .. " " .. button2state .. " " .. button3state .. " " .. button4state .. " " .. button5state .. " " .. button6state .. " " .. button7state .. " " .. button8state .. " " .. buttonTREEstate .. " " .. buttonLIFTstate .. " " .. buttonLIGHTstate .. "  " .. buttonVEHstate .. " " .. buttonGATEstate .. " " .. buttonSNOWstate .. "")
        end

        UiPop()
    end

    UiPop()


end
