local function set_theme_from_gnome()
  local handle = io.popen(
    "gsettings get org.gnome.desktop.interface color-scheme"
  )
  if not handle then return end

  local result = handle:read("*a")
  handle:close()

  if result:match("prefer%-dark") then
    vim.cmd [[
      set background=dark
    ]]
  else
    vim.cmd [[
      set background=light
    ]]
  end
end

set_theme_from_gnome()

vim.api.nvim_create_user_command("GnomeThemeSync", set_theme_from_gnome, {})
