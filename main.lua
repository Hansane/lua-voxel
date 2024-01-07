require('src.matrix')
require('src.cube')

local triangle = require('src.triangle')
local vector3 = require('src.vector3')
local color = require('src.color')

require('src.debug')

---@type table<number, triangle>
local triangles = {}

local camera = vector3.new(0,0,-100)

function love.load()
    triangles = create_debug_cube();
end

function love.update(dt)
    
end

local angle = 0.01;

local function connect_point(point1, point2)
    love.graphics.line(point1.x + 200, point1.y + 200, point2.x + 200, point2.y + 200)
end

function love.draw()

    ---@type table<number, triangle>
    local translated_triangles = {}

    for key, tri in pairs(triangles) do
        local translated_points = {}
        for key, point in pairs(tri.points) do
            local rotated_point = matrix_multiply(create_matrix_rotation_x(angle), point)
            rotated_point = matrix_multiply(create_matrix_rotation_y(angle), rotated_point)
            rotated_point = matrix_multiply(create_matrix_rotation_z(angle), rotated_point)



            table.insert(translated_points, rotated_point)
        end
        table.insert(translated_triangles, triangle.new(translated_points[1], translated_points[2], translated_points[3], tri.color))
    end

    local projected_triangles = {}

    for key, tri in pairs(translated_triangles) do

        local normal = tri:normal()

        ---vector3.dot_product(normal, tri.points[1] - camera)

        if vector3.dot_product(normal, tri.points[1] - camera) < 0 then


            -- tri.points[1] = matrix_multiply(create_matrix_perspective(2,tri.points[1].z), tri.points[1]) * 200 + vector3.new(200,200,0)
            -- tri.points[2] = matrix_multiply(create_matrix_perspective(2,tri.points[2].z), tri.points[2]) * 200 + vector3.new(200,200,0)
            -- tri.points[3] = matrix_multiply(create_matrix_perspective(2,tri.points[3].z), tri.points[3]) * 200 + vector3.new(200,200,0)

            tri.points[1] = tri.points[1] * 200 + vector3.new(200,200,0)
            tri.points[2] = tri.points[2] * 200 + vector3.new(200,200,0)
            tri.points[3] = tri.points[3] * 200 + vector3.new(200,200,0)
            
            -- local projection = create_matrix_projection(90, 1, 0.1, 1000)

            -- tri.points[1] = matrix_multiply(projection, tri.points[1]) * 200 + vector3.new(200,200,0)
            -- tri.points[2] = matrix_multiply(projection, tri.points[2]) * 200 + vector3.new(200,200,0)
            -- tri.points[3] = matrix_multiply(projection, tri.points[3]) * 200 + vector3.new(200,200,0)

            table.insert(projected_triangles, tri)
        end

    end

    for key, tri in pairs(projected_triangles) do
        tri:draw()
    end

    angle = angle + 0.005
end

