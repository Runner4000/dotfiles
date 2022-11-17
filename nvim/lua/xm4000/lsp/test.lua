local a = vim.cmd[[!ls]]
for line in vim.filetype.getlines(a) do
  print(line)
end
