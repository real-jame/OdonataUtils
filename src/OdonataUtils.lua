--OdonataUtils by realjame
local VERSION = script.VERSION.Value --(https://pridever.org/)

--A library for old Roblox development that fills in some, but not all, of the gaps in the functions provided by classic Roblox's engine. It backports stuff you've probably seen in Luau.
--This started as a repackaging of the utility functions I've made for my game prototypes in the past, so additions are on an "as-needed" basis.

--OdonataUtils comes with several modules, you can disable child scripts of this script as necessary to not load them.
--[[
	-Instance
	-Player (includes team stuff) 
	-String
	-Table
	-Math (includes lerp stuff)
	-JSON
	-Sound
	-BGM (Background Music), this provides an easy way for scripts to set and update background music for players.
	-MAYBE Data (Data Types), including BrickColor, CFrame, Color3, UDim2, Vector3
	-Color: BrickColor, Color3, RGB
	-Position: CFrame, Vector3
	-Visual: UDim2, 3D effects
]]

--OdonataUtils is also copied to players through a LocalScript, so tool and GUI LocalScripts can use it too.

--OdonataUtils is accessible at _G.o, with modules directly parented to it.
--For example, WaitForChild is accessed with _G.o.Instance:WaitForChild(parent, childName)

--But a more convenient way, that would enable you to simply call it as WaitForChild(), is to "import" the module into your script with _G.o:Import(_G.o.Instance), or just the function with _G.o:Import(_G.o.Instance.WaitForChild)
--The import function will effectively alias the content of the module, or a single thing within it, to local variables/functions in your script context.

print(string.format("Initializing OdonataUtils %s", VERSION))
_G.o = nil

for _, child in pairs(script:GetChildren()) do
    if child.className == "Script" then
        child.Disabled = true
    end
end

_G.o = {
    --Child scripts use this to add their code to the library.
    --To write a module, variables and functions are thrown into the exported table.
    --A separate "meta" table will be handled by OdonataUtils itself. Currently, there is only one thing. A function named "BackgroundService" will be ran in the background by this script.
    --This allows the GUI script to actively detect and center UI, for example.
    ExportModule = function(_, moduleName, export, meta)
        if moduleName and export and type(moduleName) == "string" and type(export) == "table" and not _G.o[moduleName] then
            _G.o[moduleName] = export
            print(string.format("Imported Odonata module %s", moduleName))
        else
            print(string.format("Importing Odonata module %s failed", tostring(moduleName)))
            return
        end

        --Process meta contents
        if meta and meta["BackgroundService"] and type(exportedMeta.BackgroundService) == "function" then
            print("Starting background service for Odonata module " .. moduleName)
            Spawn(meta)
        end
    end,

    SupportedFeatures = {
        warn = pcall(warn, "OdonataUtils test warning") and true or false,
    },

    GetEnvironment = function(_)
        return game.Players.LocalPlayer == nil and "Server" or "Client"
    end,

    Error = function(_, message)
        error(string.format("OdonataUtils Error: %s", tostring(message)), 2)
    end,

    Warn = function(_, message)
        if _G.o.SupportedFeatures.warn then
            warn(string.format("OdonataUtils Warning: %s", tostring(message)))
        else
            print(string.format("OdonataUtils Warning: %s", tostring(message)))
        end
    end,
}

for _, child in pairs(script:GetChildren()) do
    if child.className == "Script" then
        child.Disabled = false
    end
end

print("Loaded OdonataUtils!")
