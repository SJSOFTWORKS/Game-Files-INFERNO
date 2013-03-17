function love.draw()
	if (levelStatus == "inLevel") then
		drawBodies()
		drawBlocks()
	end
end
function love.load()
	bodyArray = {}
	blockArray = {}
	loadLevel("test")
	gravity = 2
end
function love.update()
	updateBlaze()
	checkCollisions()
end
function loadLevel(whichLevel)
	if (whichLevel == "test") then
		blaze = createCharacter(200, 300, 0, -10, "fill")
		bodyArray[1] = createCharacter(400, 300, 0, 0, "line")
		blockArray[1] = createBlock(0, 310, 450, 200, "")

		levelStatus = "inLevel"
	end
end
function createCharacter(posX, posY, dx, dy, type)
	local char = {}
	char.posX = posX
	char.posY = posY
	char.dx = dx
	char.dy = dy
	char.type = type
	return char
end
function createBlock(posX, posY, width, height, type)
	local block = {}
	block.posX = posX
	block.posY = posY
	block.width = width
	block.height = height
	block.type = type
	return block
end
function checkCollisions()
	if (blaze.posX >= love.graphics.getWidth() or blaze.posX <= 0) then
		blaze.dx = blaze.dx*-1
	end
	for i,block in ipairs(blockArray) do
		if (blaze.posY + 11 > block.posY and blaze.posY + 10 < block.posY + block.height and blaze.posX > block.posX and blaze.posX < block.posX + block.width) then
			jump = false
			fall = false
			blaze.dy=-10
		elseif (blaze.posX < block.posX or blaze.posX > block.posX + block.width) then
			fall = true
		end
	end
	for i,body in ipairs(bodyArray) do
		if ((blaze.posX + 20 >= body.posX and blaze.posX <= body.posX + 20) and (blaze.posY + 20 >= body.posY and blaze.posY <= body.posY + 20)) then
			local oldType = blaze.type
			blaze.type = body.type
			body.type = oldType
		end
	end
end
function drawBodies()
	love.graphics.circle(blaze.type, blaze.posX, blaze.posY, 10)
	for i,body in ipairs(bodyArray) do 
		love.graphics.circle(body.type, body.posX, body.posY, 10)
	end
end
function drawBlocks()
	for i,block in ipairs(blockArray) do
		love.graphics.rectangle("fill", block.posX, block.posY, block.width, block.height)
	end
end
function love.keypressed(key)
	if (key == 'w') then
		jump = true
	elseif (key =="a") then
		moveLeft = true
	elseif (key == "d") then
		moveRight = true
	end
end
function love.keyreleased(key)
	if (key == "a") then
		moveLeft = false
	elseif (key == "d") then
		moveRight = false
	end
end
function updateBlaze()
	blaze.posX = blaze.posX + blaze.dx
	if (jump == true) then
		if (blaze.dy<gravity) then
			blaze.posY = blaze.posY + (blaze.dy)
			blaze.dy = blaze.dy + gravity
		else
			fall = true
		end
	end
	if (fall == true) then
		blaze.posY = blaze.posY + gravity
	end
	if (moveRight == true) then
		blaze.posX = blaze.posX + 10
	end
	if (moveLeft == true) then
		blaze.posX = blaze.posX - 10
	end
end





