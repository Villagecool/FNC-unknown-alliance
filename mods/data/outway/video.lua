function onCreate()
	-- background shit
	makeLuaSprite('videoSprite','',0,0)
	scaleObject('videoSprite',1,1)
	addLuaSprite('videoSprite')
	setProperty('videoSprite.visible',false)
setObjectCamera('videoSprite', 'hud');
	makeLuaSprite('flash', '', 0, 0);
        makeGraphic('flash',1280,720,'000000')
        setObjectCamera('flash', 'hud')
	      addLuaSprite('flash', false)
	      
		setProperty('flash.alpha',1)

		

	addHaxeLibrary('MP4Handler','vlc')
	addHaxeLibrary('Event','openfl.events')
	
	
	
	
		
    
end

function onCreatePost()
  setProperty('healthbarUnder.visible', false)
   setProperty('healthbackground.visible', false)
   setProperty('iconP1.alpha', 0)
   setProperty('iconP2.alpha', 0)
   
   setProperty('songLength.visible', false)
   setProperty('timeBarBG.visible', false)
   setProperty('timeBar.visible', false)
   setProperty('scoreTxt.visible', false)
   setProperty('healthbarOver.visible', false)
   setProperty('bg.visible', false)
end

function onResume()
	runHaxeCode([[
		var video = getVar('video');
		video.resume();
	]])
end

function onUpdatePost()

	runHaxeCode([[
		var video = getVar('video');
		game.getLuaObject('videoSprite').loadGraphic(video.bitmapData);
		video.volume = 0;	
		if(game.paused)video.pause();
	]])
end

function onStepHit()
	
	if curStep == 1 then
		
                
                setProperty('videoSprite.visible',true)
runHaxeCode([[
		var filepath = Paths.video('1');		
		var video = new MP4Handler();
		video.playVideo(filepath);
		video.visible = false;
		
		setVar('video',video);
		FlxG.stage.removeEventListener('enterFrame', video.update); 
	]])
   for i=0,3 do
        noteTweenAlpha(i+4, i+4, 0, 1, 'quartInOut')
        noteTweenAlpha(i, i, 0, 1, 'quartInOut')
    end
	end
	
	if curStep == 5 then
		
                setProperty('flash.alpha',0)
             
	end
	
		if curStep == 129 then 
         setProperty('videoSprite.visible',false)
         cameraFlash('other', 'FFFFFF', 1, true)
         for i=0,3 do
        
        noteTweenAlpha(i+4, i+4, 1, 1, 'quartInOut')
        noteTweenAlpha(i, i, 1, 1, 'quartInOut')
        
        
   setProperty('timeBarBG.visible', true)
   setProperty('timeBar.visible', true)
setProperty('songLength.visible', true)
setProperty('scoreTxt.visible', true)
    end
    
         end
         
         if curStep == 246 then
           doTweenAlpha('flash', 'flash', 1, 0.5)
         end
         
         if curStep == 253 then
		
                
                setProperty('videoSprite.visible',true)
runHaxeCode([[
		var filepath = Paths.video('2');		
		var video = new MP4Handler();
		video.playVideo(filepath);
		video.visible = false;
		
		setVar('video',video);
		FlxG.stage.removeEventListener('enterFrame', video.update); 
	]])
             setProperty('flash.visible',false)
             for i=0,3 do
        
        noteTweenAlpha(i+4, i+4, 0.5, 1, 'quartInOut')
        noteTweenAlpha(i, i, 0.5, 1, 'quartInOut')
        
        
    end
	end
	
	if curStep == 257 then
		
                
             
	end
         if curStep == 288 then
                  setProperty('videoSprite.visible',false)
     setProperty('iconP1.alpha', 1)
   setProperty('iconP2.alpha', 1)
   setProperty('scoreTxt.alpha', 1)
   setProperty('healthbarOver.visible', true)
   setProperty('healthbarUnder.visible', true)
   setProperty('healthbackground.visible', true)
   setProperty('bg.visible', true)
   for i=0,3 do
        
        noteTweenAlpha(i+4, i+4, 1, 1, 'quartInOut')
        noteTweenAlpha(i, i, 1, 1, 'quartInOut')
        
        
    end
         end
end



