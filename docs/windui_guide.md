# WindUI Professional Documentation

WindUI is a high-performance, modern UI library for Roblox Script Hubs.

## 1. Initialization
```lua
local WindUI = loadstring(game:HttpGet("https://tree-house.icu/WindUI.lua"))()
```

## 2. Windows
```lua
local Window = WindUI:CreateWindow({
    Title = "NattHUB | WindUI",
    Author = "by Natt Dev",
    Folder = "NattHUB_Configs",
    Icon = "solar:home-bold-duotone",
    Theme = "Dark", -- Themes: "Dark", "Light", "Mellowsi", "Red", "Aqua", "Amethyst"
    Size = UDim2.fromOffset(580, 460),
    Transparent = true,
    SideBarSize = 200,
    HideSearchBar = false
})
```

## 3. Creating Components

### Tab
```lua
local Tab = Window:Tab({ Title = "Main", Icon = "solar:star-bold" })
```

### Section
```lua
local Sec = Tab:Section({ Title = "Category", TextSize = 18 })
```

### Toggle
```lua
Sec:Toggle({
    Title = "Enable Feature",
    Desc = "Description text here",
    Value = false,
    Callback = function(state) end
})
```

### Button
```lua
Sec:Button({
    Title = "Click Me",
    Callback = function() end
})
```

### Slider
```lua
Sec:Slider({
    Title = "Speed",
    Min = 16, Max = 100, Value = 16,
    Callback = function(v) end
})
```

### Dropdown
```lua
Sec:Dropdown({
    Title = "Choices",
    Values = {"A", "B", "C"},
    Callback = function(v) end
})
```

## 4. Notifications
```lua
WindUI:Notify({ Title = "Success", Content = "Script Loaded", Duration = 3 })
```
