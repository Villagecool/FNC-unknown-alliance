function onCreate()
	-- background shit
	makeLuaSprite('sky', 'bgs/street/sky-d1', -950, -400);
	setLuaSpriteScrollFactor('sky', 0.5, 0.5);
	scaleObject('sky', 0.6, 0.6)
	makeLuaSprite('aymipene', '', 0, 0)
	setScrollFactor('aymipene', 0, 0)
	makeGraphic('aymipene', 3840, 2160, 'FFFFFF')
	
	setProperty('aymipene.alpha', 0)
	screenCenter('aymipene', 'xy')
	
	makeAnimatedLuaSprite('bgmo', 'bgs/street/scroll', -950, -400);
	addAnimationByPrefix('bgmo', 'idle', 'bgscroll', 24, true)
	setLuaSpriteScrollFactor('bgmo', 0.5, 0.5);
	scaleObject('bgmo', 5, 5)
    ------nigga pheonix <---------
    
	
	makeLuaSprite('city', 'bgs/street/city', -1200, -400);
	setLuaSpriteScrollFactor('city', 0.8, 0.8)
	scaleObject('city', 0.6, 0.6)
	
	-------ima kill ya all
	makeLuaSprite('street', 'bgs/street/street', -1000, -400);
	scaleObject('street', 0.6, 0.6)


	addLuaSprite('sky', false);
	addLuaSprite('aymipene', false)
	addLuaSprite('bgmo', false)
		   setProperty('bgmo.visible', false)
	addLuaSprite('city', false);
	addLuaSprite('street', false);
	makeAnimatedLuaSprite('sombra', 'bgs/street/bg tonotos', -600, 720)
    addAnimationByPrefix('sombra', 'idle', 'idlea0', 24, true);
   addLuaSprite('sombra', false)
   setProperty('sombra.flipY', true)
   setProperty('sombra.alpha', 0.5)
   setProperty('sombra.color', '000000')
	makeAnimatedLuaSprite('tonotos', 'bgs/street/bg tonotos', -600, 250)
    addAnimationByPrefix('tonotos', 'idle', 'idlea0', 24, true);
   addLuaSprite('tonotos', false)
   
   
   
   
   
	
	
	
	
end

