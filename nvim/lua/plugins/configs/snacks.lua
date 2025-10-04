local present, snacks = pcall(require, "snacks")
if not present then
  return
end

---@type snacks.Config
local options = {
  bigfile = { enabled = true },
  dashboard = {
    -- section = {
    --   header = [[
    --                                                 _.oo.    
    --                       _-u[[/;:,.         .odMMMMMM'    
    --                    .o888UU[[[/;:-.. .o@P^    MMM^      
    --                   oN88888UU[[[/;::-..       dP^        
    --                  dNMMNN888UU[[[/;:--..  .o@P^          
    --                 ,MMMMMMN888UU[[/;::-..o@^              
    --                 NNMMMNN888UU[[[/~.o@P^                 
    --                 888888888UU[[[/o@^-...                 
    --                oI8888UU[[[/o@P^:--....                 
    --             .@^  YUU[[[/o@^;::---....                  
    --           oMP     ^/o@P^;:::---....                    
    --        .dMMM    .o@^ ^;::---.....                      
    --       dMMMMMMM@^`       `^^^^^                         
    --      YMMMUP^                                           
    --                                                     ]],
    -- },
    sections = {
      { section = "header" },
      {
        pane = 2,
        section = "terminal",
        cmd = "colorscript -e square",
        height = 5,
        padding = 1,
      },
      { section = "keys", gap = 1, padding = 1 },
      { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
      { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
      {
        pane = 2,
        icon = " ",
        title = "Git Status",
        section = "terminal",
        enabled = function()
          return Snacks.git.get_root() ~= nil
        end,
        cmd = "git status --short --branch --renames",
        height = 5,
        padding = 1,
        ttl = 5 * 60,
        indent = 3,
      },
      { section = "startup" },
    },
    explorer = { enabled = false },
    indent = { enabled = false },
    input = { enabled = true },
    picker = { enabled = true },
    notifier = { enabled = false },
    notify = {enabled = false },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = false },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  }
}

return snacks.setup(options)
