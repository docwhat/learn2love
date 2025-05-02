---@diagnostic disable: duplicate-set-field
local x, y, windowHeight, windowWidth
local charSize = 20
local p1joystick = nil

function love.load()
  love.window.setMode(640, 480, { resizable = true, vsync = 0, minwidth = 640, minheight = 480 })
  love.resize(love.graphics.getWidth(), love.graphics.getHeight())
  love.window.setTitle("Cavies")

  x = 40
  y = 40
  p1joystick = nil
end

function love.joystickadded(joystick)
  if joystick:isGamepad() then
    p1joystick = joystick
  end
end

function love.resize(width, height)
  windowWidth = width
  windowHeight = height
end

function love.draw()
  love.graphics.setColor(1, 0.5, 0.5)
  love.graphics.circle("fill", x, y, charSize)
end

function love.update(dt)
  local mvX = 0
  local mvY = 0
  local key = love.keyboard

  if p1joystick ~= nil then
    if p1joystick:isGamepadDown("start") then
      love.event.quit()
    end
    if p1joystick:isGamepadDown("dpdown") then
      mvY = 1
    end
    if p1joystick:isGamepadDown("dpup") then
      mvY = -1
    end
    if p1joystick:isGamepadDown("dpleft") then
      mvX = -1
    end
    if p1joystick:isGamepadDown("dpright") then
      mvX = 1
    end

    -- figure out leftx/y and rightx/y
    local leftX = p1joystick:getGamepadAxis("leftx")
    local leftY = p1joystick:getGamepadAxis("lefty")
    local rightX = p1joystick:getGamepadAxis("rightx")
    local rightY = p1joystick:getGamepadAxis("righty")
    local deadzone = 0.1

    -- left stick has priority over right stick
    if math.abs(leftX) > deadzone then
      mvX = leftX
    elseif math.abs(rightX) > deadzone then
      mvX = rightX
    end

    -- left stick has priority over right stick
    if math.abs(leftY) > deadzone then
      mvY = leftY
    elseif math.abs(rightY) > deadzone then
      mvY = rightY
    end
  end

  if key.isDown("q", "escape") then
    love.event.quit()
  end

  if key.isDown("right", "d") then
    mvX = 1
  end

  if key.isDown("left", "a") then
    mvX = -1
  end

  if key.isDown("up", "w") then
    mvY = -1
  end

  if key.isDown("down", "s") then
    mvY = 1
  end

  local speed = 200

  local newX = x + (mvX * dt * speed)
  local newY = y + (mvY * dt * speed)

  -- When going diagonal, correct movement to maintain the same speed.
  if mvX ~= 0 and mvY ~= 0 then
    newX = x + (mvX * dt * (math.sqrt(2) / 2) * speed)
    newY = y + (mvY * dt * (math.sqrt(2) / 2) * speed)
  end

  -- Don't allow the character to go off the screen.
  x = math.max(1 + charSize, math.min(newX, windowWidth - charSize))
  y = math.max(1 + charSize, math.min(newY, windowHeight - charSize))
end
