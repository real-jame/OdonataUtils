import os

src_dir = os.path.join(os.path.dirname(__file__), "..", "src")
dist_dir = os.path.join(os.path.dirname(__file__), "..", "dist")
out_file = os.path.join(dist_dir, "OdonataUtils.lua")

version = os.path.join(os.path.dirname(__file__), "..", "VERSION")
def get_version():
    try:
        with open(version, "r", encoding="utf-8") as f:
            return f.read().strip()
    except:
        return "unknown"

def get_commit():
    try:
        return os.popen("git rev-parse --short HEAD").read().strip()
    except:
        return "unknown"

def read_lua_file(path):
    with open(path, "r", encoding="utf-8") as f:
        return f.read()

def gather_modules():
    modules = []
    for filename in sorted(os.listdir(os.path.join(src_dir, "modules"))):
        if filename.endswith(".lua"):
            modules.append({
                "name": os.path.splitext(filename)[0],
                "source": read_lua_file(os.path.join(src_dir, "modules", filename)),
            })
    return modules

current_version = get_version()
current_commit = get_commit()
main_source = read_lua_file(os.path.join(src_dir, "OdonataUtils.lua"))
modules = gather_modules()

script = f"""--[[
OdonataUtils install/update script
This script is auto-generated, do not edit manually!
]]--

print("Installing OdonataUtils v{get_version()}/{get_commit()} to your place.")

local function HandleOldInstall(parent)
    local install = parent:FindFirstChild("OdonataUtils")
    if install then
        print(string.format("An existing install of OdonataUtils was found in %s, moving to 'OdonataUtils-old' model...", tostring(parent)))
        local oldInstalls = parent:FindFirstChild("OdonataUtils-old")
        if not oldInstalls then
            oldInstalls = Instance.new("Model")
            oldInstalls.Name = "OdonataUtils-old"
            oldInstalls.Parent = parent
        end
        local version = install:FindFirstChild("VERSION")
        if version then
            version = version.Value
        else
            version = "unknown"
        end
        local container = Instance.new("Model")
        container.Name = version
        container.Parent = oldInstalls
        
        install.Disabled = true
        for _, script in pairs(install:GetChildren()) do
            if script:IsA("Script") or script:IsA("LocalScript") then
                script.Disabled = true
            end
        end
        install.Parent = container
    end
end
HandleOldInstall(game.Workspace)
HandleOldInstall(game.StarterPack)

local mainSource = ""
local modules = {{
"""

for m in modules:
    escaped_source = m["source"].replace("\\", "\\\\").replace("\'", "\\\'").replace("\"", "\\\"").replace("\n", "\\n")
    script += f"{{Name = '{m['name']}', Source = '{escaped_source}'}},\n"

escaped_main = main_source.replace("\\", "\\\\").replace("\'", "\\\'").replace("\"", "\\\"").replace("\n", "\\n")

script += f"""}}

local function Install(parent, scriptType)
    local main = Instance.new(scriptType)
    main.Name = "OdonataUtils"
    main.Source = "{escaped_main}"
    
    local version = Instance.new("StringValue")
    version.Name = "VERSION"
    version.Value = "v{current_version}/{current_commit}"
    version.Parent = main
    
    for _, module in pairs(modules) do
        local newModule = Instance.new(scriptType)
        newModule.Name = module.Name
        newModule.Source = module.Source
        newModule.Parent = main
    end
    
    main.Parent = parent
end
Install(game.Workspace, "Script")
Install(game.StarterPack, "LocalScript")
print("OdonataUtils installed successfully!")
print("NOTE: Immediately running the place (not play solo) will undo the install, so please move a part or something to give Studio an action to save before you Run the place.")
"""

os.makedirs(dist_dir, exist_ok=True)

with open(out_file, "w", encoding="utf-8") as f:
    f.write(script)