require "player"
require "enemy"


player = Player(100, 100)
timer = 0
bullets = {}
enemies = {}

waveTimer = 10 -- time between waves
waveCount = 1 -- number of enemies to spawn

function love.load()
	love.window.setTitle("Hello world!")
	love.window.setMode(1200, 800)
	love.graphics.setBackgroundColor(100, 100, 200)
end

function love.update(dt)
	timer = timer + dt
	player:update(dt)
	for i, bullet in ipairs(bullets) do
		bullet:update(dt)
	end
	for i, enemy in ipairs(enemies) do
		enemy:update(dt)
	end

	for i = #bullets, 1, -1 do
		for k, enemy in ipairs(enemies) do
			if bullets[i]:checkCollision(enemy) then
				table.remove(bullets, i)
				if enemy.health <= 0 then
					table.remove(enemies, k)
				end
				break
			end
		end
	end

	if waveTimer <= 0 then
		-- spawn the enemies
		for i = 1, waveCount, 1 do
			table.insert(enemies,
				Enemy(math.random()*love.graphics.getWidth(),
					math.random()*love.graphics.getHeight(), player))
		end
		waveTimer = 10
		waveCount = waveCount * 2
	elseif #enemies == 0 then
		-- count down to next wave
		waveTimer = waveTimer - dt
	end
end

function love.draw()
	love.graphics.printf(timer, 10, 20, 100)
	player:draw()
	for i, bullet in ipairs(bullets) do
		bullet:draw()
	end
	for i, enemy in ipairs(enemies) do
		enemy:draw()
	end
end

function rectCollisionCheck(x1, y1, w1, h1, x2, y2, w2, h2)
	if x1 + w1 > x2 and x1 < x2 + w2 then
		if y1 + h1 > y2 and y1 < y2 + h2 then
			return true
		end
	end
	return false
end