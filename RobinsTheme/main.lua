local windowWidth = 640
local windowHeight = 480
local lineWidth = 1

function love.load()
  love.window.setMode(640, 480, { resizable = true, vsync = 0, minwidth = 280, minheight = 192 })
  love.resize(love.graphics.getWidth(), love.graphics.getHeight())
end

function love.resize(w, h)
  windowWidth = w
  windowHeight = h
  lineWidth = math.min(w, h) / 300
  love.window.setTitle("Robin's Theme (" .. lineWidth .. ") - " .. w .. "x" .. h)
end

function love.draw()
  local mid_x = windowWidth / 2
  local mid_y = windowHeight / 2

  local step = 8

  -- love.graphics.setColor(0, 0, 0)
  love.graphics.setLineWidth(lineWidth)
  love.graphics.setLineStyle("rough")

  for x = 0, windowWidth, step do
    for y = 0, windowHeight, step do
      love.graphics.line(mid_x, mid_y, x, y)
    end
  end
end
