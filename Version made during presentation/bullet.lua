Class = require "class"

Bullet = Class()

function Bullet:init(x, y, facing)
	self.x = x
	self.y = y
	self.f = facing
	self.speed = 50
	self.attack = 50
	self.r = 10 -- the radius of the circle
end

function Bullet:update(dt)
	self.x = self.x + math.cos(self.f)*self.speed
	self.y = self.y + math.sin(self.f)*self.speed
end

function Bullet:draw()
	love.graphics.ellipse("fill", self.x, self.y, self.r, self.r)
end

function Bullet:checkCollision(enemy)
	if rectCollisionCheck(self.x - self.r, self.y - self.r, 2*self.r, 2*self.r,
		enemy.x, enemy.y, enemy.width, enemy.height) then
		enemy.health = enemy.health - self.attack
		return true
	end
	return false
end