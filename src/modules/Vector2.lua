repeat wait() until _G.o

--TODO: actually adapt the vector3 functions
local export = {
    ---A Vector2 with a magnitude of zero.
    zero = Vector2.new(),

    ---A Vector2 with a value of 1 on every axis.
    one = Vector2.new(1, 1),

    ---A Vector2 with a value of 1 on the X axis.
    xAxis = Vector2.new(1, 0),

    ---A Vector2 with a value of 1 on the Y axis.
    yAxis = Vector2.new(0, 1),

    ---Returns a new vector from the absolute values of the original's components.
    ---For example, a vector of (-2, 4, -6) returns a vector of (2, 4, 6).
    ---@param a userdata --[[Vector2]]
    ---@return userdata --[[Vector2]]
    Abs = function(_, a)
        _G.o.Warn("Unimplemented function", "Vector2")
    end,

    ---Returns a new vector from the ceiling of the original's components.
    ---For example, a vector of (-2.6, 5.1, 8.8) returns a vector of (-2, 6, 9).
    ---@param a userdata --[[Vector2]]
    ---@return userdata --[[Vector2]]
    Ceil = function(_, a)
        _G.o.Warn("Unimplemented function", "Vector2")
    end,

    ---Returns a new vector from the floor of the original's components.
    ---For example, a vector of (-2.6, 5.1, 8.8) returns a vector of (-3, 5, 8).
    ---@param a userdata --[[Vector2]]
    ---@return userdata --[[Vector2]]
    Floor = function(_, a)
        _G.o.Warn("Unimplemented function", "Vector2")
    end,

    ---Returns a new vector from the sign (-1, 0, or 1) of the original's components.
    ---For example, a vector of (-2.6, 5.1, 0) returns a vector of (-1, 1, 0).
    ---@param a userdata --[[Vector2]]
    ---@return userdata --[[Vector2]]
    Sign = function(_, a)
        _G.o.Warn("Unimplemented function", "Vector2")
    end,

    ---Returns the angle in radians between the two vectors.
    ---If you provide an axis, it determines the sign of the angle.
    ---@param other userdata --[[Vector2]]
    ---@param axis? userdata --[[Vector2]]
    ---@return number
    Angle = function(_, other, axis)
        _G.o.Warn("Unimplemented function", "Vector2")
    end,

    ---
    ---@param other userdata --[[Vector2]]
    ---@param epsilon? number
    ---@return boolean
    FuzzyEq = function(_, other, epsilon)
        epsilon = epsilon or 0.00001
        _G.o.Warn("Unimplemented function", "Vector2")
    end,

    ---Returns a Vector2 with each component as the highest among the respective components of both provided Vector2 objects.
    ---@param a userdata --[[Vector2]]
    ---@param b userdata --[[Vector2]]
    ---@return userdata --[[Vector2]]
    Max = function(_, a, b)
        _G.o.Warn("Unimplemented function", "Vector2")
    end,

    ---Returns a Vector2 with each component as the lowest among the respective components of both provided Vector2 objects.
    ---@param a userdata --[[Vector2]]
    ---@param b userdata --[[Vector2]]
    ---@return userdata --[[Vector2]]
    Min = function(_, a, b)
        _G.o.Warn("Unimplemented function", "Vector2")
    end,

    ---Equivalent to math operation Vector2 // Vector2 or Vector2 // number:
    ---Produces a Vector2 by floor dividing each component of the provided vector by the number or the corresponding component of the second Vector2.
    ---@param dividend userdata --[[Vector2]]
    ---@param divisor userdata | number --[[Vector2 | number]]
    ---@return userdata --[[Vector2]]
    FloorDivide = function(_, dividend, divisor)
        _G.o.Warn("Unimplemented function", "Vector2")
    end,

}

_G.o:ExportModule(script.Name, export)
