require "player"
require "enemy"

player = Player()
enemies = {}
bullets = {}
timeBetweenWaves = 5
waveCountdown = timeBetweenWaves
waveNumber = 0
maxWaveNumber = 0

function love.load(args)
	love.window.setFullscreen(true)
	love.graphics.setBackgroundColor(50, 50, 50)
end


function love.update(dt)
	-- update the wave of zombies:
	if #enemies == 0 then
		waveCountdown = waveCountdown - dt
	end
	if waveCountdown <= 0 then
		waveNumber = waveNumber + 1
		maxWaveNumber = math.max(waveNumber, maxWaveNumber)
		waveCountdown = timeBetweenWaves
		for i = 1, math.pow(2, waveNumber-1) do
			-- spawn enemies for the wave randomly in a circle
			local f = math.random() * 2 * math.pi
			local r = love.graphics.getWidth() + .5*love.graphics.getWidth()*math.random()
			local x = math.cos(f) * r
			local y = math.sin(f) * r
			table.insert(enemies, Enemy(x, y, player))
		end
	end
	player:update(dt)
	for i = #enemies, 1, -1 do
		enemies[i]:update(dt)
		if enemies[i].health <= 0 then
			table.remove(enemies, i) -- remove dead enemies
		end
	end
	for i = #bullets, 1, -1 do
		bullets[i]:update(dt)
		for k, enemy in ipairs(enemies) do
			bullets[i]:checkEnemyCollision(enemy) -- check to see if they hit an enemy
		end
		if not bullets[i].active then
			table.remove(bullets, i) -- remove finished bullets
		end
	end

	-- check if the player is dead, if so, reset everything:
	if player.health <= 0 then
		waveNumber = 0
		waveCountdown = timeBetweenWaves
		player.health = 100
		enemies = {}
		bullets = {}
	end
end

function love.draw()
	player:draw()
	for k, v in ipairs(enemies) do
		v:draw()
	end
	for k, v in ipairs(bullets) do
		v:draw()
	end
	love.graphics.setColor(255, 255, 255)
	love.graphics.printf("Wave: "..waveNumber, 20, 20, 1000)
	love.graphics.printf("Best: "..maxWaveNumber, 220, 20, 1000)
	love.graphics.printf("Enemies left: "..#enemies, 420, 20, 1000)
end

function love.keypressed(key, unicode)
	if key == "escape" then
		love.event.quit()
	end
end

function addBullet(b)
	table.insert(bullets, b)
end

function rectangleCollisionCheck(x1, y1, w1, h1, x2, y2, w2, h2)
	-- returns whether the two rectangles are touching
	-- the x and y coordinates are the centers of the rectangles
	if x1 + w1/2 > x2 - w2/2 and x1 - w1/2 < x2 + w2/2 then
		if y1 + h1/2 > y2 - h2/2 and y1 - h1/2 < y2 + h2/2 then
			return true -- they're colliding
		end
	end
	return false
end