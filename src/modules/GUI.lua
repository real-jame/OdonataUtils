repeat wait() until _G.o

local export = {
    CreateUDim2Value = function(_, name, value)
        if not value or type(value) ~= "userdata" then
            _G.o:Error("Invalid UDim2 provided")
        end

        -- UDim2Value doesn't exist yet so this is a workaround with 2 separate Vector3 values storing Scale and Offset separately in a Model. (Vector2Value doesn't exist yet either)
        local container = Instance.new("Model")
        container.Name = name or "UDim2Value"

        local scale = Instance.new("Vector3Value")
        scale.Name = "Scale"
        scale.Value = Vector3.new(value.X.Scale, value.Y.Scale, 0)
        scale.Parent = container

        local offset = Instance.new("Vector3Value")
        offset.Name = "Offset"
        offset.Value = Vector3.new(value.X.Offset, value.Y.Offset, 0)
        offset.Parent = container

        return container
    end,

    --Set the value of a UDim2Value Model
    SetUDim2Value = function(_, udim2Value, value)
        if not udim2Value or not udim2Value:IsA("Model") then
            _G.o:Error("Invalid UDim2Value Model provided")
        end

        local scale = udim2Value:FindFirstChild("Scale")
        local offset = udim2Value:FindFirstChild("Offset")

        if not scale or not offset then
            _G.o:Error("UDim2Value Model must contain Scale and Offset Vector3Values")
        end

        scale.Value = Vector3.new(value.X.Scale, value.Y.Scale, 0)
        offset.Value = Vector3.new(value.X.Offset, value.Y.Offset, 0)
    end,

    --Get a UDim2 object from a UDim2Value Model
    GetUDim2Value = function(_, udim2Value)
        if not udim2Value or not udim2Value:IsA("Model") then
            _G.o:Error("Invalid UDim2Value Model provided")
        end

        local scale = udim2Value:FindFirstChild("Scale")
        local offset = udim2Value:FindFirstChild("Offset")

        if not scale or not offset then
            _G.o:Error("UDim2Value Model must contain Scale and Offset Vector3Values")
        end

        return UDim2.new(scale.Value.X, offset.Value.X, scale.Value.Y, offset.Value.Y)
    end,
}

_G.o:ExportModule(script.Name, export)

--Loop to listen for and update GUI (e.g. centered UI dependent on the current screen size)
if _G.o:GetEnvironment() == "Client" then
    local player = game.Players.LocalPlayer
    local listening = {}

    local function UpdateGui(gui)
        local anchorPoint = gui:FindFirstChild("AnchorPoint")
        if anchorPoint and anchorPoint:IsA("Vector3Value") then
            anchorPoint = Vector2.new(anchorPoint.Value.X, anchorPoint.Value.Y)
            local positionSet = gui:FindFirstChild("PositionSet")
            if positionSet then
                positionSet = _G.o.GUI:GetUDim2Value(positionSet)
            else
                positionSet = UDim2.new()
            end
            gui.Position = positionSet - UDim2.new(0, gui.AbsoluteSize.X * anchorPoint.X, 0, gui.AbsoluteSize.Y * anchorPoint.Y)
            listening[gui] = { AbsolutePosition = gui.AbsolutePosition, AbsoluteSize = gui.AbsoluteSize }
        end
    end

    local function StartListening(gui)
        if gui and not listening[gui] and (gui:IsA("GuiObject")) then
            listening[gui] = { AbsolutePosition = gui.AbsolutePosition, AbsoluteSize = gui.AbsoluteSize }
            --PositionSet = the original GUI position set by the developer before being overridden by OdonataUtils, this can be set in realtime in Play Solo for testing UI placement.
            positionSet = gui:FindFirstChild("PositionSet")
            if not gui:FindFirstChild("PositionSet") then
                positionSet = _G.o.GUI:CreateUDim2Value("PositionSet", gui.Position)
                positionSet.Parent = gui
            end
            _G.o.GUI:SetUDim2Value(positionSet, gui.Position)
            positionSet.Scale.Changed:connect(function()
                UpdateGui(gui)
            end)
            positionSet.Offset.Changed:connect(function()
                UpdateGui(gui)
            end)
        end
        if gui:IsA("GuiObject") or gui:IsA("ScreenGui") then
            for _, child in pairs(gui:GetChildren()) do
                StartListening(child)
            end
            gui.ChildAdded:connect(function(child)
                StartListening(child)
            end)
        end
    end

    for _, screenGui in pairs(player.PlayerGui:GetChildren()) do
        if screenGui and (screenGui.className == "ScreenGui" or screenGui.className == "GuiMain") then
            StartListening(screenGui)
        end
    end
    player.PlayerGui.ChildAdded:connect(function(screenGui)
        if screenGui and (screenGui.className == "ScreenGui" or screenGui.className == "GuiMain") then
            StartListening(screenGui)
        end
    end)

    wait()
    while true do
        for gui, lastData in pairs(listening) do
            if gui.AbsolutePosition ~= lastData.AbsolutePosition or gui.AbsoluteSize ~= lastData.AbsoluteSize then
                UpdateGui(gui)
            end
        end
        wait()
    end
end