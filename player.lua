--[[
A simple player class that is controlled via keyboard and mouse
Some obvious problems:
- you walk faster diagonally than straight
- there's no way to determine what health you're at
- there's no way to determine whether your weapons are reloaded
]]--

Class = require "class"
require "bullet"

Player = Class{}


function Player:init(health)
	self.health = 100--health or 100
	self.speed = 200
	self.x = 0
	self.y = 0

	self.color = {200, 255, 100, 255} -- if you don't have the fourth number it defaults to 255 alpha
	self.width = 50
	self.height = 100

	self.swordCooldown = .25
	self.gunCooldown = .1
	self.swordTimer = 0
	self.gunTimer = 0
end

function Player:update(dt)
	local boolVal = {[true] = 1, [false] = 0}
	-- the square brackets around the boolean values signify that they are the keys
	-- for strings you could just type them in there like t = { hello = 5 }, but if you wanted it to start with a
	-- control character you may have to do the following: t = { [.weird] = false }


	-- handle movement:
	local dx = boolVal[love.keyboard.isDown("d")] - boolVal[love.keyboard.isDown("a")]
	local dy = boolVal[love.keyboard.isDown("s")] - boolVal[love.keyboard.isDown("w")]
	self.x = self.x + dx * self.speed * dt -- make sure you use dt (delta time) to ensure you move the same
	self.y = self.y + dy * self.speed * dt -- speed no matter the framerate


	-- then check if the player is attacking and attack!
	local f = math.atan2(love.mouse.getY() - self.y, love.mouse.getX() - self.x)
	if love.mouse.isDown(1) then
		-- the left mouse is down, fire bullets
		if self.gunTimer <= 0 then
			-- make a bullet
			local b = Bullet(self.x, self.y, f)
			addBullet(b) -- this is a function in the main file which just adds a bullet to the table
			self.gunTimer = self.gunCooldown
		end
	elseif love.mouse.isDown(2) then
		-- sword thing
		self.swordTimer = self.swordCooldown
	end
	if self.gunTimer > 0 then
		self.gunTimer = self.gunTimer - dt
	end
	if self.swordTimer > 0 then
		self.swordTimer = self.swordTimer - dt
	end
end

function Player:draw()
	love.graphics.setColor(self.color)
	love.graphics.rectangle("fill", self.x - self.width/2, self.y - self.height/2, self.width, self.height)
end