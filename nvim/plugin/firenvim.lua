vim.pack.add({ "https://github.com/glacambre/firenvim" }, { load = false })

vim.api.nvim_create_autocmd("UIEnter", {
  group = vim.api.nvim_create_augroup("config", { clear = false }),
  callback = function()
    vim.cmd [[set guifont=Noto_Sans_Mono:h12]]
    local client = vim.api.nvim_get_chan_info(vim.v.event.chan).client
    if client and client.name == "Firenvim" then
      vim.cmd [[
        set cmdheight=0 shortmess+=W scrolloff=0 laststatus=0 textwidth=999
        nnoremap <C-v> "+p
        inoremap <C-v> <C-o>"+p
      ]]
    end
  end
})
