-----------------------------------------------------------------------------------------
--
-- ron.lua
--
-----------------------------------------------------------------------------------------

require "math"
--create display
display.setStatusBar(display.HiddenStatusBar)


orientation = {
	default = "portrait",
	supported = { "portrait", "landscapeLeft", "landscapeRight"}
}


--declare variables

parties 	= {"Neighbors lawn","Daylight Saving 1","Lea party 2017","Babin huge party","SBD","Ryan BD","Saturnalia (Ryan)","Party Noel Emily","Cuba","Rockclimbing ShinDig","Festibiere","St Pats","Shin-Dig 2.0","Shin-Dig 3.0"}
ron 		= {true,false,true,false,false,true,true,false,true,false,false,true,true,false}
attendees 	= {7,10,20,30,8,12,13,22,6,6,6,6,9,5}
ronnees		= {"Kev","","Tony, SimonD, SimonT","","","Bruno","Vanessa","","Alex,Kev","","","Alex","Mel",""}

index 		= 0
ronRate 	= 0
people 		= 1 

font 		= "Britannic Bold"


ronRateDisplay = display.newText(ronRate.. "%", display.contentWidth/2, display.contentHeight/2, font,50)


function menu()
	image 	= display.newImageRect("backgrounds/bg.jpg", display.contentWidth+100, display.contentHeight) 
	image.x = display.contentCenterX
	image.y = display.contentCenterY
	peoplePrint		= display.newText("How many people are at the party?",display.contentWidth/2 + 10, display.contentHeight/5, display.contentWidth - 15 ,0,font,30)
	peopleTextbox 	= native.newTextBox( display.contentWidth/2  , display.contentHeight/5   + 50, 200, 25 )
	
	peopleTextbox.text	= "1"
	
	peopleTextbox:addEventListener( "userInput", peopleListener )
	
	peopleTextbox.isEditable	= true
	
	OkButton   = display.newImageRect("ok button.gif",120,35)
	OkButton.x = display.contentWidth/2
	OkButton.y = display.contentHeight*4/5

	-- Create the touch event handler function 
	local function OkButtonHandler( event )
		
		if (event.phase == "began") then  
			--press down and hold
			OkButton:removeSelf()
			OkButton:removeEventListener("touch", OkButtonHandler)
			OkButton = nil

			OkButton = display.newImageRect("ok button down.gif",120,35)
			OkButton:addEventListener("touch", OkButtonHandler)

			OkButton.xScale = 0.95 -- scale the button on touch release 
			OkButton.yScale = 0.95
			OkButton.x = display.contentWidth/2
			OkButton.y = display.contentHeight*4/5

		elseif (event.phase == "moved" or event.phase == "ended" or event.phase == "cancelled") then
			OkButton:removeSelf()
			OkButton:removeEventListener("touch", OkButtonHandler)
			
			OkButton = display.newImageRect("ok button.gif",120,35)
			OkButton:addEventListener("touch", OkButtonHandler)
			OkButton.xScale = 1 
			OkButton.yScale = 1
			OkButton.x = display.contentWidth/2
			OkButton.y = display.contentHeight*4/5
	 		ronCalculator()
	 		displayRon()
		end
		return true
	end 
	OkButton:addEventListener("touch", OkButtonHandler)
end

function removeMenu()
	peoplePrint		:removeSelf()
	OkButton 		:removeSelf()
	peopleTextbox	:removeSelf()
end

function peopleListener( event )
	if ( event.phase == "editing" ) then
		people = tonumber(event.text) --converts a string to nil
		if people == nil then people = 1 end
		people = math.floor(people + 0.5)
	end --end if edditing
end

function ronCalculator()
	ronRate	= 1 - 1/(1.01 + ((people+5)/25)^3 )
	ronRate = math.floor(ronRate*1000)/10
end

function displayRon()
	ronRateDisplay:removeSelf()
	ronRateDisplay = display.newText(ronRate.. "%", display.contentWidth/2, display.contentHeight/2, font,50)
end


-- Called when the app's view has been resized
local function onResize( event )
	removeMenu()
	displayRon()	
	menu()
end
 
Runtime:addEventListener( "resize", onResize )
menu()