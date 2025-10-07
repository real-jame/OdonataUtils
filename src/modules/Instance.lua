repeat wait() until _G.o

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
    end,

    ---Returns the child of the Instance with the given name. If the child does not exist, it will yield the current thread until it does.
    ---If the timeOut parameter is specified, this method will time out after the specified number of seconds and return nil.
    ---@param instance userdata --[[Instance]]
    ---@param name string
    ---@param timeOut? number
    ---@return userdata | nil --[[Instance | nil]]
    WaitForChild = function(_, instance, name, timeOut)
        if false then --_G.o.SupportedFeatures.Instance.WaitForChild then
            --Disabled because doesn't support timeOut in 2013.
            --TODO: could expand the testing function to check for this.
            return instance:WaitForChild(name, timeOut)
        else
            local startTick = tick()
            if timeOut then
                --Less efficient implementation but allows aborting after some time has passed
                while not instance:FindFirstChild(name) and tick() - startTick < timeOut do
                    wait() --Can be adjusted if creates lag
                end
            else
                local endlessWarned = false
                while not instance:FindFirstChild(name) do
                    wait() --Ok it has to be this way, childadded is unreliable (child is renamed to desired name, or just simply not triggering) --instance.ChildAdded:wait()
                    if not endlessWarned and tick() - startTick > 5 then
                        _G.o:Warn("Infinite yield possible on WaitForChild", "Instance") --Due to yielding until ChildAdded rather than constantly polling, this isn't guaranteed to show up on time. But it's also not a critical thing, just a repro of Roblox behavior.
                        endlessWarned = true
                    end
                end
            end
            return instance:FindFirstChild(name)
        end
    end
}

_G.o:ExportModule(script.Name, export)