repeat wait() until _G.o

local export = {
    ---A Vector3 with a magnitude of zero.
    zero = Vector3.new(),

    ---A Vector3 with a value of 1 on every axis.
    one = Vector3.new(1, 1, 1),

    ---A Vector3 with a value of 1 on the X axis.
    xAxis = Vector3.new(1, 0, 0),

    ---A Vector3 with a value of 1 on the Y axis.
    yAxis = Vector3.new(0, 1, 0),

    ---A Vector3 with a value of 1 on the Z axis.
    zAxis = Vector3.new(0, 0, 1),

    ---Returns a new vector from the absolute values of the original's components.
    ---For example, a vector of (-2, 4, -6) returns a vector of (2, 4, 6).
    ---@param a userdata --[[Vector3]]
    ---@return userdata --[[Vector3]]
    Abs = function(_, a)
        _G.o.Warn("Unimplemented function", "Vector3")
    end,

    ---Returns a new vector from the ceiling of the original's components.
    ---For example, a vector of (-2.6, 5.1, 8.8) returns a vector of (-2, 6, 9).
    ---@param a userdata --[[Vector3]]
    ---@return userdata --[[Vector3]]
    Ceil = function(_, a)
        _G.o.Warn("Unimplemented function", "Vector3")
    end,

    ---Returns a new vector from the floor of the original's components.
    ---For example, a vector of (-2.6, 5.1, 8.8) returns a vector of (-3, 5, 8).
    ---@param a userdata --[[Vector3]]
    ---@return userdata --[[Vector3]]
    Floor = function(_, a)
        _G.o.Warn("Unimplemented function", "Vector3")
    end,

    ---Returns a new vector from the sign (-1, 0, or 1) of the original's components.
    ---For example, a vector of (-2.6, 5.1, 0) returns a vector of (-1, 1, 0).
    ---@param a userdata --[[Vector3]]
    ---@return userdata --[[Vector3]]
    Sign = function(_, a)
        _G.o.Warn("Unimplemented function", "Vector3")
    end,

    ---Returns the angle in radians between the two vectors.
    ---If you provide an axis, it determines the sign of the angle.
    ---@param other userdata --[[Vector3]]
    ---@param axis? userdata --[[Vector3]]
    ---@return number
    Angle = function(_, other, axis)
        _G.o.Warn("Unimplemented function", "Vector3")
    end,

    ---
    ---@param other userdata --[[Vector3]]
    ---@param epsilon? number
    ---@return boolean
    FuzzyEq = function(_, other, epsilon)
        epsilon = epsilon or 0.00001
        _G.o.Warn("Unimplemented function", "Vector3")
    end,

    ---Returns a Vector3 with each component as the highest among the respective components of both provided Vector3 objects.
    ---@param a userdata --[[Vector3]]
    ---@param b userdata --[[Vector3]]
    ---@return userdata --[[Vector3]]
    Max = function(_, a, b)
        _G.o.Warn("Unimplemented function", "Vector3")
    end,

    ---Returns a Vector3 with each component as the lowest among the respective components of both provided Vector3 objects.
    ---@param a userdata --[[Vector3]]
    ---@param b userdata --[[Vector3]]
    ---@return userdata --[[Vector3]]
    Min = function(_, a, b)
        _G.o.Warn("Unimplemented function", "Vector3")
    end,

    ---Equivalent to math operation Vector3 // Vector3 or Vector3 // number:
    ---Produces a Vector3 by floor dividing each component of the provided vector by the number or the corresponding component of the second Vector3.
    ---@param dividend userdata --[[Vector3]]
    ---@param divisor userdata | number --[[Vector3 | number]]
    ---@return userdata --[[Vector3]]
    FloorDivide = function(_, dividend, divisor)
        _G.o.Warn("Unimplemented function", "Vector3")
    end,

}

_G.o:ExportModule(script.Name, export)
