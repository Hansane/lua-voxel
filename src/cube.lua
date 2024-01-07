local triangle = require('src.triangle')
local vector3 = require('src.vector3')
local color = require('src.color')

function create_debug_cube()
    local triangles = {}

    -- Left
    table.insert(triangles, triangle.new(
        vector3.new(-0.5, 0.5, 0.5),
        vector3.new(-0.5, 0.5, -0.5),
        vector3.new(-0.5, -0.5, -0.5),
        color.red
    ))
    table.insert(triangles, triangle.new(
        vector3.new(-0.5, 0.5, 0.5),
        vector3.new(-0.5, -0.5, -0.5),
        vector3.new(-0.5, -0.5, 0.5),
        color.green
    ))

    -- Top
    table.insert(triangles, triangle.new(
        vector3.new(-0.5, -0.5, 0.5),
        vector3.new(-0.5, -0.5, -0.5),
        vector3.new(0.5, -0.5, -0.5),
        color.blue
    ))
    table.insert(triangles, triangle.new(
        vector3.new(-0.5, -0.5, 0.5),
        vector3.new(0.5, -0.5, -0.5),
        vector3.new(0.5, -0.5, 0.5),
        color.cyan
    ))

    -- Front
    table.insert(triangles, triangle.new(
        vector3.new(-0.5, 0.5, 0.5),
        vector3.new(-0.5, -0.5, 0.5),
        vector3.new(0.5, -0.5, 0.5),
        color.yellow
    ))
    table.insert(triangles, triangle.new(
        vector3.new(-0.5, 0.5, 0.5),
        vector3.new(0.5, -0.5, 0.5),
        vector3.new(0.5, 0.5, 0.5),
        color.purple
    ))

    -- Back
    table.insert(triangles, triangle.new(
        vector3.new(0.5, 0.5, -0.5),
        vector3.new(-0.5, -0.5, -0.5),
        vector3.new(-0.5, 0.5, -0.5),
        color.pink
    ))
    table.insert(triangles, triangle.new(
        vector3.new(0.5, 0.5, -0.5),
        vector3.new(0.5, -0.5, -0.5),
        vector3.new(-0.5, -0.5, -0.5),
        color.brown
    ))

    -- Right
    table.insert(triangles, triangle.new(
        vector3.new(0.5, 0.5, -0.5),
        vector3.new(0.5, 0.5, 0.5),
        vector3.new(0.5, -0.5, 0.5),
        color.orange
    ))
    table.insert(triangles, triangle.new(
        vector3.new(0.5, 0.5, -0.5),
        vector3.new(0.5, -0.5, 0.5),
        vector3.new(0.5, -0.5, -0.5),
        color.white
    ))

    -- Bottom
    table.insert(triangles, triangle.new(
        vector3.new(-0.5, 0.5, -0.5),
        vector3.new(-0.5, 0.5, 0.5),
        vector3.new(0.5, 0.5, 0.5),
        color.grey
    ))
    table.insert(triangles, triangle.new(
        vector3.new(-0.5, 0.5, -0.5),
        vector3.new(0.5, 0.5, 0.5),
        vector3.new(0.5, 0.5, -0.5),
        color.wheat
    ))

    return triangles
end
