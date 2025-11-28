-- TODO: send commands/command output to a specific window

local on_exit = function(obj)
  print(obj.code)
  print(obj.signal)
  print(obj.stdout)
  print(obj.stderr)
end

-- vim.system({ "echo", "hello" }, { text = true }, on_exit)
