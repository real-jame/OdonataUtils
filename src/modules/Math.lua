repeat wait() until _G.o

local export = {
    ---Rounds a number to the nearest integer.
    ---@param x number
    ---@return number
    Round = function(_, x)
        return math.floor(x + 0.5)
    end,

    ---Returns -1 if x is less than 0, 0 if x equals 0, or 1 if x is greater than 0.
    ---@param x number
    ---@return number
    Sign = function(_, x)
         if x > 0 then
             return 1
         elseif x < 0 then
             return -1
         else
             return 0
         end
    end
}

_G.o:ExportModule(script.Name, export)