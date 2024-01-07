---@class triangle
---@field points table<vector3>
---@field color color

require('src.debug')
local vector3 = require('src.vector3')
local c = require('src.color')

local triangle = {}
triangle.__index = triangle



local z = 100

---@return triangle
---@param p1 vector3
---@param p2 vector3
---@param p3 vector3
---@param color color
function triangle.new(p1,p2,p3, color)
    local self = setmetatable({}, triangle)


    self.points = {p1, p2, p3}
    self.color = color

    return self
end

---@return vector3
function triangle:normal()
    local a = self.points[1] - self.points[2]
    local b = self.points[1] - self.points[3]

    return vector3.cross_product(a, b):normalize()
end

function triangle:draw()
    love.graphics.setColor(self.color.r, self.color.g, self.color.b)



    love.graphics.polygon(
        'fill',
        self.points[1].x, self.points[1].y,
        self.points[2].x, self.points[2].y,
        self.points[3].x, self.points[3].y
    )
end



return triangle