pico-8 cartridge // http://www.pico-8.com
version 33
__lua__
function _init()
	cls()
	balls = create_balls(50)
	pallo = ball.new(5, 8, 2)
	snd_delay = 0
end

function _update()
 snd_delay += 1
	read_input()
	for b in all(balls) do
		if collcheck(pallo, b) then
			b.col = 8
			if (snd_delay > rnd(20)) sfx(rnd(2)) snd_delay = 0
		else b.col = 12
		end
	end
	
end

function _draw()
	cls(6)
	circfill(pallo.x, pallo.y, pallo.rad, pallo.col)
	circ(pallo.x, pallo.y, pallo.rad, 0)
	for b in all(balls) do
		circfill(b.x, b.y, b.rad, b.col)
		circ(b.x, b.y, b.rad, 0)
	end

end
-->8
--oliot
ball = {}
ball.new = function(radius, colour, speed)
	local self = {}
	self.rad = radius or 5
	self.x = 10 + rnd(100) //+ self.rad
	self.y = 10 + rnd(100) //+ self.rad
	self.col = colour or 12
	self.speed = speed or 1
	
	return self
end
	
-->8
--funktiot
function create_balls(amount)
	balls = {}
	for i=1,amount do
		b = ball.new()
		add(balls, b)
	end
	return balls
end
-->8
function collcheck(ob_a, ob_b)
	x_overlap = false
	y_overlap = false
	collision = false

	if abs(ob_a.x - ob_b.x) < (ob_a.rad+ob_b.rad) then
		x_overlap = true -- X coordinates overlap
		print("X overlaps", 0, 0)
	end
	if abs(ob_a.y - ob_b.y) < (ob_a.rad+ob_b.rad) then
		y_overlap = true -- Y coordinates overlap
		print("Y overlaps", 0, 5)
	end
	if x_overlap and y_overlap then
		collision = true
	end
	return collision
end

function read_input()
	if btn(0) and pallo.x - pallo.rad > 1 then
		pallo.x -= pallo.speed
	end
	if btn(1) and pallo.x + pallo.rad < 127 then
		pallo.x += pallo.speed
	end
	if btn(2) and pallo.y - pallo.rad > 1 then
		pallo.y -= pallo.speed
	end
	if btn(3) and pallo.y + pallo.rad < 127 then
		pallo.y += pallo.speed
	end

	-- Check for collisions after moving the large ball
	for b in all(balls) do
		if collcheck(pallo, b) then
			if (pallo.x < b.x) b.x += b.speed
			if (pallo.x > b.x) b.x -= b.speed
			if (pallo.y < b.y) b.y += b.speed
			if (pallo.y > b.y) b.y -= b.speed
		end
	end
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
00010000120500f0500a0500705008050170501505006000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000100001d0500b0500d0501005000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000100001405005050060500805008050030500305003050030500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
