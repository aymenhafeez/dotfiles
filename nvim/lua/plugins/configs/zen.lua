local present, zen = pcall(require, "zen-mode")
if not present then
  return
end

zen.setup {
  window = {
    options = {
      number = false,
      relativenumber = false
    }
  }
}
