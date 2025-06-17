repeat wait() until _G.o

local export = {
    ---Equivalent to CFrame.RightVector: gets the X / right-drection component of the CFrame's orientation.
    ---@param cframe userdata --[[CFrame]]
    ---@return userdata --[[Vector3]]
    RightVector = function(_, cframe)
        local x, y, z, R00, R01, R02, R10, R11, R12, R20, R21, R22 = cframe:components()
        return Vector3.new(R00, R10, R20)
    end,
    
    ---Equivalent to CFrame.UpVector: gets the Y / up-direction component of the CFrame's orientation.
    ---@param cframe userdata --[[CFrame]]
    ---@return userdata --[[Vector3]]
    UpVector = function(_, cframe)
        local x, y, z, R00, R01, R02, R10, R11, R12, R20, R21, R22 = cframe:components()
        return Vector3.new(R01, R11, R21)
    end,
    
    ---Equivalent to CFrame.XVector: gets the X / right-direction component of the CFrame's orientation.
    ---@param cframe userdata --[[CFrame]]
    ---@return userdata --[[Vector3]]
    XVector = function(_, cframe)
        return export.RightVector(_, cframe)
    end,
    
    ---Equivalent to CFrame.YVector: gets the up-direction component of the CFrame's orientation.
    ---@param cframe userdata --[[CFrame]]
    ---@return userdata --[[Vector3]]
    YVector = function(_, cframe)
        return export.UpVector(_, cframe)
    end,
    
    ---Equivalent to CFrame.ZVector: gets the Z / forward-direction component of the CFrame's orientation, the negated LookVector.
    ---@param cframe userdata --[[CFrame]]
    ---@return userdata --[[Vector3]]
    ZVector = function(_, cframe)
        local x, y, z, R00, R01, R02, R10, R11, R12, R20, R21, R22 = cframe:components()
        return Vector3.new(R02, R12, R22)
    end,
}

_G.o:ExportModule(script.Name, export)