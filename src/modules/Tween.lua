repeat wait() until _G.o

--The math for each style is taken from https://easings.net/ and may not be accurate to modern Roblox!
---Controls the motion of a ease.
---@enum EasingStyle
local EasingStyle = {
    Linear = function(x)
        return x
    end,
    Sine = function(x)
        return 1 - math.cos((x * math.pi) / 2)
    end,
    Quad = function(x)
        return x * x
    end,
    Cubic = function(x)
        return x * x * x
    end,
    Quart = function(x)
        return x * x * x * x
    end,
    Quint = function(x)
        return x * x * x * x * x
    end,
    Exponential = function(x)
        return x == 0 and 0 or 2 ^ (10 * (x - 1))
    end,
    Circular = function(x)
        return 1 - math.sqrt(1 - math.pow(x, 2))
    end,
    Back = function(x)
        local c1 = 1.70158
        local c3 = c1 + 1

        return c3 * x * x * x - c1 * x * x
    end,
    Bounce = function(x)
        --easeOutBounce but I do the Out flipping here so it's In
        local alpha
        local n1 = 7.5625
        local d1 = 2.75
        x = 1 - x

        if x < 1 / d1 then
            alpha = n1 * x * x;
        elseif x < 2 / d1 then
            x = x - 1.5 / d1
            alpha = n1 * x * x + 0.75;
        elseif x < 2.5 / d1 then
            x = x - 2.25 / d1
            alpha = n1 * x * x + 0.9375;
        else
            x = x - 2.625 / d1
            alpha = n1 * x * x + 0.984375;
        end

        return 1 - alpha
    end,
    Elastic = function(x)
        local c4 = (2 * math.pi) / 3

        if x == 0 or x == 1 then
            return x
        else
            return -math.pow(2, 10 * x - 10) * math.sin((x * 10 - 10.75) * c4)
        end
    end
}

---@enum EasingDirection
---Controls the direction of an ease.
local EasingDirection = {
    In = "In",
    Out = "Out",
    InOut = "InOut"
}

---@param x number
---@param style EasingStyle
---@param direction EasingDirection
---@return number
local function ApplyDirection(x, style, direction)
    if direction == "In" then
        return EasingStyle[style](x)
    elseif direction == "Out" then
        return 1 - EasingStyle[style](1 - x)
    elseif direction == "InOut" then
        if x < 0.5 then
            return EasingStyle[style](x * 2) / 2
        else
            return 1 - EasingStyle[style]((1 - x) * 2) / 2
        end
    end
end

local export = {
    --Create = function(_, instance, tweenInfo, propertyTable)
    --    print("TODO: Tween:Create")
    --end

    ---Calculates a new alpha given an easing style and easing direction.
    ---Based on modern TweenService. Used for smooth lerping.
    ---@param alpha number
    ---@param style EasingStyle
    ---@param direction EasingDirection
    ---@return number
    GetValue = function(_, alpha, style, direction)
        return ApplyDirection(alpha, style, direction)
    end
}

_G.o:ExportModule(script.Name, export)
