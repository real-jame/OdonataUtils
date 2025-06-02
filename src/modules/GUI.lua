local export = {

}

_G.o:ExportModule(script.Name, export)

--Loop to listen for and update GUI (e.g. centered UI dependent on the current screen size)
if _G.o:GetEnvironment() == "Client" then
    local player = game.Players.LocalPlayer
    local listening = {}
    local customProps = { ["AnchorPoint"] = true }

    local function UpdateGui(gui)
        print("[UpdateGui] Called for:", gui.Name)
        local anchorPoint = gui:FindFirstChild("AnchorPoint")
        if anchorPoint and anchorPoint:IsA("Vector3Value") then
            print("[UpdateGui] Found AnchorPoint:", anchorPoint.Value)
            local anchorPoint = Vector2.new(anchorPoint.Value.X, anchorPoint.Value.Y)
            print("[UpdateGui] Converted AnchorPoint to Vector2:", anchorPoint)
            gui.Position = listening[gui].OriginPosition - UDim2.new(0, gui.AbsoluteSize.X * anchorPoint.X, 0, gui.AbsoluteSize.Y * anchorPoint.Y)
            listening[gui] = { OriginPosition = listening[gui].OriginPosition, AbsolutePosition = gui.AbsolutePosition, AbsoluteSize = gui.AbsoluteSize }
            print("[UpdateGui] Updated gui.Position to:", gui.Position)
        else
            print("[UpdateGui] No valid AnchorPoint found for:", gui.Name)
        end
    end

    local function StartListening(gui)
        if gui and not listening[gui] and (gui:IsA("GuiObject")) then
            print("[StartListening] Listening to:", gui.Name)
            listening[gui] = { OriginPosition = gui.Position, AbsolutePosition = gui.AbsolutePosition, AbsoluteSize = gui.AbsoluteSize }
        end
        if gui:IsA("GuiObject") or gui:IsA("ScreenGui") then
            for _, child in pairs(gui:GetChildren()) do
                StartListening(child)
            end
            gui.ChildAdded:connect(function(child)
                print("[StartListening] Child added to:", gui.Name, "->", child.Name)
                StartListening(child)
            end)
        end
    end

    for _, screenGui in pairs(player.PlayerGui:GetChildren()) do
        if screenGui and (screenGui.className == "ScreenGui" or screenGui.className == "GuiMain") then
            print("[Init] Found ScreenGui/GuiMain:", screenGui.Name)
            StartListening(screenGui)
        end
    end
    player.PlayerGui.ChildAdded:connect(function(screenGui)
        if screenGui and (screenGui.className == "ScreenGui" or screenGui.className == "GuiMain") then
            print("[PlayerGui.ChildAdded] New ScreenGui/GuiMain added:", screenGui.Name)
            StartListening(screenGui)
        end
    end)

    wait()
    while true do
        for gui, lastData in pairs(listening) do
            if gui.AbsolutePosition ~= lastData.AbsolutePosition or gui.AbsoluteSize ~= lastData.AbsoluteSize then
                print("[Loop] Detected change in gui:", gui.Name)
                UpdateGui(gui)
            end
        end
        wait()
    end
end