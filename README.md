# awesome-workspaces
Implements the notion of workspaces within Awesome WM

## Description

This module allows you to define different groups of tags within your Awesome configuration, and switch between theses tags seamlessly, as you would switch between different workspaces.

## Usage

* Clone this repository
* In the requirements definition of your `rc.lua`, add a require to the module : 

```
local workspaces    = require("workspaces.workspaces")
```

* Once this is done, you will need to configure your workspaces, here is the configuration that I'm using as an example :

```
--- Define 2 workspaces, one for work and one for personal stuff. Each workspace has 9 tags.
workspaces.workspaces = {"work", "personal"}
workspaces.all_tags = {
  work = { "w1", "w2", "w3", "w4", "w5", "w6", "w7", "w8", "w9"},
  personal = { "p1", "p2", "p3", "p4", "p5", "p6", "p7", "p8", "p9"}
}
--- Start with the "work" worspace by default
workspaces.current_workspace = 1
```

Note that workspaces can have different amounts of tags, and that each tag can be freely named.

* You will also need to bind keys to switch from one workspace to another. For that, the module exposes two methods `next_workspace()` and `previous_workspace()` :

```
--- The up arrow goes to the previous workspace, the down arrow goes to the next workspace
awful.key({ modkey,           }, "Up", function() workspaces.previous_workspace() end,
          { description = "move to the previous workspace", group = "workspaces"}),
awful.key({ modkey,           }, "Down", function() workspaces.next_workspace() end,
          { description = "move to the next workspace", group = "workspaces"}),
```

* Reload your Awesome, and you should be good to go !
