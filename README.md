# OdonataUtils
A library for old Roblox gamedev that fills some, but not all, of the gaps

## Building

Install Python and clone the repository, then run the Python script to generate a Lua file you can run in Roblox Studio to add the library to your game.

```bash
git clone https://github.com/real-jame/OdonataUtils.git
cd OdonataUtils
python tools/generate_lua.py
```

The Lua file will be generated in the `dist` directory. In Roblox Studio, open the `Tools` dropdown menu from the top bar and select `Execute Script...`, then navigate to the generated file.
Running it will add OdonataUtils to Workspace to run serverside and StarterPack to run clientside. If there is an existing copy, it will be moved to a backup model in the same location.

For versions of Studio without the option to execute Lua files, you can [minify the generated code](https://lua.realja.me/) into a 1-liner you can paste into the [Command Bar](https://rbxlegacy.wiki/index.php/Command_(Toolbar)).