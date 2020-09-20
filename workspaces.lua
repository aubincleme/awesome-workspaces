-- {{{ Required deps
local awesome, tag = awesome, screen

local awful         = require("awful")
-- }}}

-- {
--   workspace {
--     screen {
--       tag1, tag2, ...
--     }
--   }
-- }

local workspaces = {
  workspaces = {},
  current_workspace = 1
}

local workspace_tags = {}

function workspaces.next_workspace()
  -- Compute the new workspace number
  if workspaces.current_workspace == #workspaces.workspaces then
    workspaces.switchWorkspace(1)
  else
    workspaces.switchWorkspace(workspaces.current_workspace + 1)
  end
end

function workspaces.previous_workspace()
  if workspaces.current_workspace == 1 then
    workspaces.switchWorkspace(#workspaces.workspaces)
  else
    workspaces.switchWorkspace(workspaces.current_workspace - 1)
  end
end

function workspaces.switchWorkspace(newWorkspace)
  -- Make sure that we have a spot in the workspace_tags
  if workspace_tags[workspaces.current_workspace] == nil then
    workspace_tags[workspaces.current_workspace] = {}
  end

  for s in screen do
    -- Current implem is a bit shitty : the address of the screen could change
    local screenId = s

    workspace_tags[workspaces.current_workspace][screenId] = {
      workspaces = {},
      selection = {}
    }

    -- Make sure that we have all the tags of each screen in the current workspace saved
    -- and desactivate all of them
    for k,v in pairs(s.tags) do
      workspace_tags[workspaces.current_workspace][screenId]["workspaces"][v.name] = v
      workspace_tags[workspaces.current_workspace][screenId]["selection"][v.name] = v.selected
      v.activated = false
    end

    -- Either we already have an entry for this screen in the workspace tags
    -- in that case, we restore it
    -- else, we create a new one
    if workspace_tags[newWorkspace] == nil or workspace_tags[newWorkspace][screenId] == nil then
      -- Create something new
      awful.tag(workspaces.all_tags[workspaces.workspaces[newWorkspace]], s, awful.layout.layouts)
    else
      -- Restore
      for k,v in pairs(workspace_tags[newWorkspace][screenId]["workspaces"]) do
        v.activated = true
        v.selected = workspace_tags[newWorkspace][screenId]["selection"][v.name]
      end
    end
  end

  workspaces.current_workspace = newWorkspace
end

return workspaces
