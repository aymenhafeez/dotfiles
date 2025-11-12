return {
  {
    "L3MON4D3/LuaSnip",
    event = "BufWritePre",
    version = "v2.*",
    build = "make install_jsregexp",
    config = function()
      require("ah.luasnip").setup()
    end,
  },
}
