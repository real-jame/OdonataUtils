repeat wait() until _G.o

local export = {}

---Equivalent to CFrame.fromMatrix: Returns a CFrame from a translation and the columns of a rotation matrix.
---If vZ is excluded, the third column is calculated as vX:Cross(vY).Unit.
---@param vX userdata --[[Vector3]]
---@param vY userdata --[[Vector3]]
---@param vZ? userdata --[[Vector3]]
---@return userdata --[[CFrame]]
export.fromMatrix = function(_, pos, vX, vY, vZ)
    vZ = vZ or vX:Cross(vY).Unit

    return CFrame.new(
        pos.X, pos.Y, pos.Z,
        vX.X, vY.X, vZ.X,
        vX.Y, vY.Y, vZ.Y,
        vX.Z, vY.Z, vZ.Z
    )
end

---Equivalent to CFrame.lookAt: returns a new CFrame with the position of at and facing towards lookAt,
---optionally specifiying the upward direction (up) with a default of 0, 1, 0.
---@param at userdata --[[Vector3]]
---@param lookAt userdata --[[Vector3]]
---@param upVector? userdata --[[Vector3]]
---@return userdata --[[CFrame]]
export.lookAt = function(_, at, lookAt, upVector)
    upVector = upVector or Vector3.new(0, 1, 0)

    local forward = (lookAt - at).Unit
    local right = forward:Cross(upVector).Unit
    local up = right:Cross(forward)

    return export:fromMatrix(at, right, up, -forward)
end

---Equivalent to CFrame.RightVector: gets the X / right-drection component of the CFrame's orientation.
---@param cframe userdata --[[CFrame]]
---@return userdata --[[Vector3]]
export.RightVector = function(_, cframe)
    local x, y, z, R00, R01, R02, R10, R11, R12, R20, R21, R22 = cframe:components()
    return Vector3.new(R00, R10, R20)
end

---Equivalent to CFrame.UpVector: gets the Y / up-direction component of the CFrame's orientation.
---@param cframe userdata --[[CFrame]]
---@return userdata --[[Vector3]]
export.UpVector = function(_, cframe)
    local x, y, z, R00, R01, R02, R10, R11, R12, R20, R21, R22 = cframe:components()
    return Vector3.new(R01, R11, R21)
end

---Equivalent to CFrame.XVector: gets the X / right-direction component of the CFrame's orientation.
---@param cframe userdata --[[CFrame]]
---@return userdata --[[Vector3]]
export.XVector = function(_, cframe)
    return export:RightVector(cframe)
end

---Equivalent to CFrame.YVector: gets the up-direction component of the CFrame's orientation.
---@param cframe userdata --[[CFrame]]
---@return userdata --[[Vector3]]
export.YVector = function(_, cframe)
    return export:UpVector(cframe)
end

---Equivalent to CFrame.ZVector: gets the Z / forward-direction component of the CFrame's orientation, the negated LookVector.
---@param cframe userdata --[[CFrame]]
---@return userdata --[[Vector3]]
export.ZVector = function(_, cframe)
    local x, y, z, R00, R01, R02, R10, R11, R12, R20, R21, R22 = cframe:components()
    return Vector3.new(R02, R12, R22)
end


_G.o:ExportModule(script.Name, export)
