-- Code by Shadow Mario
function onCreate()
	precacheSound('train_passes')

	-- background shit
	if not lowQuality then

		makeLuaSprite('sky', 'bgs/week 3/sky', -250, -130);
		setScrollFactor('sky', 0.1, 0.1);
	                   scaleObject('sky', 1.25, 1.25);
	end

		makeLuaSprite('Clouds', 'bgs/week 3/Clouds', math.random(100, -1950), math.random(-20, 20));
		setLuaSpriteScrollFactor('Clouds', 0.1, 0.1);
		setProperty('Clouds.velocity.x', math.random(5, 20));

makeLuaSprite('background city', 'bgs/week 3/background city', -200, -40);
	setScrollFactor('background city', 0.3, 0.3);

makeLuaSprite('city2', 'bgs/week 3/city2', -195, -45);
	setScrollFactor('city2', 0.3, 0.3);
	scaleObject('city2', 1.0, 1.0);
	
	makeLuaSprite('train', 'bgs/week 3//train', 3000, 360);

	makeLuaSprite('street2', 'bgs/week 3/street2', -200, 20);
                   scaleObject('street2', 1.2, 1.2);
	
	addLuaSprite('sky', false);
                   addLuaSprite('Clouds', false);
                   addLuaSprite('background city', false);
                   addLuaSprite('city2', false);

	--windows
	for i = 0, 4 do
		makeLuaSprite('win'..i, 'bgs/week 3/win'..i, -195, -45);
		setScrollFactor('win'..i, 0.3, 0.3);
		scaleObject('win'..i, 1.0, 1.0);
		setProperty('win'..i..'.visible', false)
		addLuaSprite('win'..i, false);
	end
	addLuaSprite('behindTrain', false);
	addLuaSprite('train', false);
	addLuaSprite('street2', false);

precacheImage('bgs/week 3/Clouds');
precacheImage('bgs/week 3/background city');
precacheImage('bgs/week 3/city2');
precacheImage('bgs/week 3/street2');
precacheImage('bgs/week 3/win0');
precacheImage('bgs/week 3/win1');
precacheImage('bgs/week 3/win2');
precacheImage('bgs/week 3/win3');
precacheImage('bgs/week 3/win4');

end

function onEvent(n, v1, v2) -- Blammed Lights Recreation
	if n == 'Blammed Lights' then
		for i = 0, 5 do
			makeLuaSprite('light'..i, 'bgs/week 3/win'..i,-195, -45);
			setScrollFactor('light'..i, 0.3, 0.3);
			scaleObject('light'..i, 1.0, 1.0);
			setProperty('light'..i..'.visible', false)
			addLuaSprite('light'..i, false);
			setObjectOrder('light', getObjectOrder('gfGroup') - 1)
		end
		curL = getProperty('curLightEvent') - 1
		setProperty('light'..curL..'.visible', true)
	end
end

trainMoving = false;
trainFrameTiming = 0;
startedMoving = false;

trainCars = 8;
trainFinishing = false;
trainCooldown = 0;

curLight = 0;
function onUpdate(elapsed)
	if trainMoving then
		trainFrameTiming = trainFrameTiming + elapsed;

		if trainFrameTiming >= 1 / 24 then
			updateTrainPos();
			trainFrameTiming = 0;
		end
	end
	setProperty('win'..curLight..'.alpha', getProperty('win'..curLight..'.alpha') - (crochet / 1000) * elapsed * 1.5);
end

function onBeatHit()
	if not trainMoving then
		trainCooldown = trainCooldown + 1;
	end

	if curBeat % 4 == 0 then
		for i = 0, 4 do
			setProperty('win'..i..'.visible', false)
		end

		curLight = math.random(0, 4);
		setProperty('win'..curLight..'.visible', true)
		setProperty('win'..curLight..'.alpha', 1)
	end

	if curBeat % 8 == 4 and math.random(0, 9) <= 3 and not trainMoving and trainCooldown > 8 then
		trainCooldown = math.random(-4, 0);
		trainStart();
	end
end

function trainStart()
	trainMoving = true;
	playSound('train_passes', 1, 'trainSound');
end

function updateTrainPos()
	if getSoundTime('trainSound') >= 4700 then
		startedMoving = true;
		characterPlayAnim('gf', 'hairBlow');
		setProperty('gf.specialAnim', true);
	end

	if (startedMoving) then
		trainX = getProperty('train.x') - 400;
		setProperty('train.x', trainX);

		if trainX < -2000 and not trainFinishing then
			setProperty('train.x', -1150);
			trainX = -1150;
			trainCars = trainCars - 1;

			if trainCars <= 0 then
				trainFinishing = true;
			end
		end

		if trainX < -4000 and trainFinishing then
			trainReset();
		end
	end
end

function trainReset()
	setProperty('gf.danced', false); --Sets head to the correct position once the animation ends
	characterPlayAnim('gf', 'hairFall');
	setProperty('gf.specialAnim', true);
	setProperty('train.x', screenWidth + 500);
	trainMoving = false;
	trainCars = 8;
	trainFinishing = false;
	startedMoving = false;
end