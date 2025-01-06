function onCreatePost()
	makeLuaSprite('whitebg', '', 0, 0)
	setScrollFactor('whitebg', 0, 0)
	makeGraphic('whitebg', 3840, 2160, 'ffffff')
	addLuaSprite('whitebg', false)
	setProperty('whitebg.alpha', 0)
	screenCenter('whitebg', 'xy')
	
	makeLuaSprite('blackbg', '', 0, 0)
	setScrollFactor('blackbg', 0, 0)
	makeGraphic('blackbg', 3840, 2160, '000000')
	addLuaSprite('blackbg', false)
	setProperty('blackbg.alpha', 0)
	screenCenter('blackbg', 'xy')
	
	
end


function onEvent(n, v1, v2)
  ---white
	if n == 'badapplelol' and string.lower(v1) == 'whiteon' then
	  
		doTweenAlpha('applebadxd69', 'whitebg', 1, 0.000005, 'linear')
		doTweenColor('badapplexd', 'boyfriend', '000000', 0.000005, 'linear')
		doTweenColor('badapplexd1', 'dad', '000000', 0.000005, 'linear')
		doTweenColor('badapplexd2', 'gf', '000000', 0.000005, 'linear')
		
	end
	if n == 'badapplelol' and string.lower(v1) == 'whiteoff' then
	
		doTweenAlpha('applebadxd', 'whitebg', 0, 0.000005, 'linear')
		doTweenColor('badapplexd3', 'boyfriend', 'FFFFFF', 0.000005, 'linear')
		doTweenColor('badapplexd4', 'dad', 'FFFFFF', 0.000005, 'linear')
		doTweenColor('badapplexd5', 'gf', 'FFFFFF', 0.000005, 'linear')
		
	end
	
	if n == 'badapplelol' and string.lower(v1) == 'blackon' then
	    makeLuaSprite('blackbg', '', 0, 0)
	setScrollFactor('blackbg', 0, 0)
	makeGraphic('blackbg', 3840, 2160, '000000')
	addLuaSprite('blackbg', false)
	setProperty('blackbg.alpha', 0)
	screenCenter('blackbg', 'xy')
		doTweenAlpha('applebadxd69', 'blackbg', 1, 0.000005, 'linear')
		
		runHaxeCode([[
		
		
			game.dad.setColorTransform(1,1,1,1,255,255,255,0);
		
		
		
			game.boyfriend.setColorTransform(1,1,1,1,255,255,255,0);
		
		
		
			game.gf.setColorTransform(1,1,1,1,255,255,255,0);
		
	    ]])
	   
	end
	if n == 'badapplelol' and string.lower(v1) == 'blackoff' then
		doTweenAlpha('applebadxd', 'blackbg', 0, 0.000005, 'linear')
		runHaxeCode([[
		
			game.dad.setColorTransform(1,1,1,1,0,0,0,0);
		
		
			game.boyfriend.setColorTransform(1,1,1,1,0,0, 0, 0);
		
		
		
			game.gf.setColorTransform(1,1,1,1,0,0, 0, 0);
		
	    ]])
	    
	end
end