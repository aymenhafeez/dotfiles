local present, zen = pcall(require, "zen-mode")
if not present then
  return
end

zen.setup {
  window = {
    backdrop = 1,
    height = 0.95,
    width = 90,
    options = {
      number = false,
      relativenumber = false,
      laststatus = 0,
    }
  }
}
