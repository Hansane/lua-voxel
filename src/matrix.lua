---@class matrix

local vector3 = require('src.vector3')

---@return matrix
function create_matrix_orthogonal()
    local matrix = {
        {1,0,0},
        {0,1,0}
    }

    return matrix
end

---@return matrix
---@param distance number
---@param rotatedZ number
function create_matrix_perspective(distance, rotatedZ)
    local z = 1 / (distance - rotatedZ)

    local matrix = {
        {z,0,0},
        {0,z,0}
    }

    return matrix
end

function create_matrix_projection(fovDeg, aspectRatio, near, far)
    local fovRad = math.rad(fovDeg)

    local matrix = {
        {aspectRatio * fovRad, 0, 0, 0},
        {0, fovRad, 0, 0},
        {0, 0, far / (far - near), 1},
        {0, 0, (-far * near) / (far - near), 0}
    }

    return matrix
end

---@return matrix
---@param angle number
function create_matrix_rotation_x(angle)
    local matrix = {
        {1, 0, 0},
        {0, math.cos(angle), -math.sin(angle)},
        {0, math.sin(angle), math.cos(angle)},
    }

    return matrix
end

---@return matrix
---@param angle number
function create_matrix_rotation_y(angle)
    local matrix = {
        {math.cos(angle), 0, math.sin(angle)},
        {0, 1, 0},
        {-math.sin(angle), 0, math.cos(angle)},
    }

    return matrix
end

---@return matrix
---@param angle number
function create_matrix_rotation_z(angle)
    local matrix = {
        {math.cos(angle), -math.sin(angle), 0},
        {math.sin(angle), math.cos(angle), 0},
        {0, 0, 1},
    }

    return matrix
end

---@return matrix
---@param vector vector3
function vector_to_matrix(vector)
    local matrix = {
        {vector.x},
        {vector.y},
        {vector.z},
    }

    return matrix
end

---@return matrix | vector3
---@param a matrix
---@param b matrix | vector3
function matrix_multiply(a, b)
    if type(b) == "vector" then
        return matrix_multiply_vector(a, b)
    end

    local colsA = table.getn(a[1])
    local rowsA = table.getn(a)
    local colsB = table.getn(b[1])
    local rowsB = table.getn(b)

    if colsA ~= rowsB then
        error("Columns of A must match rows of B")
    end

    local result = {}
    for j = 1, rowsA, 1 do
        result[j] = {}
        for i = 1, colsB, 1 do
            local sum = 0
            for n = 1, colsA, 1 do
                sum = sum + (a[j][n] * b[n][i])
            end
            result[j][i] = sum
        end
    end
    
    return result
end

---@return vector3
---@param matrix matrix
---@param vector vector3
function matrix_multiply_vector(matrix, vector)
    local vector_matrix = vector_to_matrix(vector)
    local result = matrix_multiply(matrix, vector_matrix)
    return matrix_to_vector(result)
end

---@return vector3
---@param matrix matrix
function matrix_to_vector(matrix)
    return vector3.new(matrix[1][1], matrix[2][1], table.getn(matrix) > 2 and matrix[3][1] or 0)
end