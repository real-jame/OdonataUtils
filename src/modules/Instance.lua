repeat wait() until _G.o

local Debris = game:GetService("Debris")

local export = {
    ---Calls instance:Destroy() on supported versions (2011+)
    ---On older versions, falls back to :Remove().
    ---Destroy() is preferable to Remove() as it locks the Parent property and disconnects events on all children, preventing memory leaks.
    ---TODO: A custom implementation of Destroy() for older versions.
    ---@param instance userdata --[[Instance]]
    ---@return nil
    Destroy = function(_, instance)
        if _G.o.SupportedFeatures.Instance.Destroy then
            instance:Destroy()
        else
            instance:Remove()
        end
    end
}

_G.o:ExportModule(script.Name, export)