local triangle = require('src.triangle')
local vector3 = require('src.vector3')
local color = require('src.color')

local engine = {}
engine.__index = engine

local width, height = 1,1;

---@type table<number, triangle>
local triangles = {}

local camera = vector3.new(0,0,-10)

local projection_matrix = create_perspective_projection_matrix(90, height/width, 0.1, 1000)

local yaw = 0;
lookDirection = vector3.new(0,0,0)

function engine.moveCamera(vector)
    camera = camera + vector
end

function engine.turnCamera(dx)
    yaw = yaw + dx
end

function engine.setViewSize(w, h)
    width = w
    height = h
    projection_matrix = create_perspective_projection_matrix(90, height/width, 0.1, 1000)
end


function engine.loadTriangles(t)
    triangles = t
end

local angle = 0;




function engine.draw()

    local zRotationMatrix = create_z_rotation_matrix(angle)
    local xRotationMatrix = create_x_rotation_matrix(angle)

    local translationMatrix = create_translation_matrix(0, 0, 5)

    local worldMatrix = matrix_multiply(zRotationMatrix, xRotationMatrix)
    worldMatrix = matrix_multiply(worldMatrix, translationMatrix)

    -- camera matrix
    local upVector = vector3.new(0,1,0)
    local cameraTarget = vector3.new(0,0,1)
    local cameraRotationMatrix = create_y_rotation_matrix(yaw)
    lookDirection = matrix_multiply_vector(cameraRotationMatrix, cameraTarget)
    cameraTarget = lookDirection + camera

    local cameraMatrix = create_point_at_matrix(camera, cameraTarget, upVector)

    local view = quick_inverse_matrix(cameraMatrix)

    ---@type table<number, triangle>
    local trianglesToRaster = {}

    for key, tri in pairs(triangles) do
        local transformed = tri:multiplyByMatrix(worldMatrix)

        local normal = transformed:normal()

        local cameraRay = transformed.points[1] - camera

        if vector3.dot_product(normal, cameraRay) < 0 then
            -- TODO illumination

            -- convert world space -> view space
            local viewed = transformed:multiplyByMatrix(view)

            -- TODO clipping

            local projected = viewed:multiplyByMatrixNormalized(projection_matrix)
            

            -- -- TODO invert axis
            projected.points[1].y = -projected.points[1].y
            projected.points[2].y = -projected.points[2].y
            projected.points[3].y = -projected.points[3].y

            -- offset into visible normalised space
            local offset = vector3.new( 1,  1, 0);

            projected.points[1] = projected.points[1] + offset
            projected.points[2] = projected.points[2] + offset
            projected.points[3] = projected.points[3] + offset

            projected.points[1].x = projected.points[1].x * (width/2)
            projected.points[1].y = projected.points[1].y * (height/2)

            projected.points[2].x = projected.points[2].x * (width/2)
            projected.points[2].y = projected.points[2].y * (height/2)

            projected.points[3].x = projected.points[3].x * (width/2)
            projected.points[3].y = projected.points[3].y * (height/2)

            table.insert(trianglesToRaster, projected)
        end

    end

    for key, tri in pairs(trianglesToRaster) do
        tri:draw()
    end

    -- angle = angle + 0.005
end


return engine