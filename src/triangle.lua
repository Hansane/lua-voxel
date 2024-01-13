---@class triangle
---@field points table<vector3>
---@field color color

require('src.debug')
local vector3 = require('src.vector3')
local c = require('src.color')
local matrix = require('src.matrix')

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

---@return triangle
---@param t triangle
function triangle.copy(t)
    local self = setmetatable({}, triangle)


    self.points = {vector3.copy(t.points[1]), vector3.copy(t.points[2]), vector3.copy(t.points[3])}
    self.color = c.new(t.color.r, t.color.g, t.color.b)

    return self
end


---@return triangle
function triangle.newDefault()
    local self = setmetatable({}, triangle)


    self.points = {}
    self.color = c.white

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

---@return triangle
---@param m matrix4x4
function triangle:multiplyByMatrix(m)
    return triangle.new(
        matrix_multiply_vector(m, self.points[1]),
        matrix_multiply_vector(m, self.points[2]),
        matrix_multiply_vector(m, self.points[3]),
        self.color
    )
end

---@return triangle
---@param m matrix4x4
function triangle:multiplyByMatrixNormalized(m)
    return triangle.new(
        matrix_multiply_vector_normalized(m, self.points[1]),
        matrix_multiply_vector_normalized(m, self.points[2]),
        matrix_multiply_vector_normalized(m, self.points[3]),
        self.color
    )
end



return triangle