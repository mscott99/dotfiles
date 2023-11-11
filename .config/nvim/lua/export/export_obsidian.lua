local my_settings = {
  export_folder = "/Users/matthewscott/Documents/auto_exports/",
  template_path = "/Users/matthewscott/.config/export_obsidian/template.tex",
  supporting_docs_dir = "/Users/matthewscott/.config/export_obsidian/supporting_docs/",
  julia_main_file_path = "/Users/matthewscott/Prog/Obsidian-Paper-Export/src/main.jl",
}

function Export_Longform()
  local dir, file_name = string.match(vim.api.nvim_buf_get_name(0), "(.-)([^/]+)%.md$")
  assert(dir ~= nil and file_name ~= nil, "could not resolve file name.")
  local under_file_name = string.gsub(file_name, " ", "_")

  -- make the directory
  local new_dir = my_settings.export_folder .. under_file_name .. "/"
  vim.cmd("!mkdir " .. new_dir)
  local config_file = io.open(new_dir .. "config.yaml", "w+")
  assert(config_file ~= nil, "could not create config.yaml")
  config_file:write(string.format([[
main_doc_template: "%stemplate.tex"
ignore_quotes: true
input_folder_path: "%s"
longform_file_name: "%s"
output_folder_path: "%soutput/"]],
new_dir, dir, file_name, new_dir
  ))
  config_file:close()

  vim.cmd("!cp ".. my_settings.template_path .. " " .. new_dir)
  vim.cmd("!mkdir" .. new_dir .. "output")

  vim.cmd("!cp ".. my_settings.supporting_docs_dir .. "* " .. new_dir .. "output/")

  local export_executable = io.open(new_dir .. "export.zsh", "w+")
  assert(export_executable ~= nil, "could not create export.zsh")
  export_executable:write(string.format(
[[julia %s %sconfig.yaml

if \[\[ $? -eq 1 \]\]; then
    exit 0
fi
  ]],
my_settings.julia_main_file_path, new_dir))

  export_executable:close()
  vim.cmd("!chmod +x " .. new_dir .. "export.zsh")

  local tmpfile = os.tmpname()
  vim.cmd("! " .. new_dir .. "export.zsh > " .. tmpfile)
  -- local output = os.execute(new_dir .. "export.zsh")
  -- print(output)
  local file = io.open(tmpfile, "r")
  assert(file ~= nil)
  print(file:read("*a"))
  file:close()

  os.execute("cp -r " .. new_dir .. "output/ " .. new_dir .. "manual/")

  vim.cmd([[vsplit]])

  -- open and compile the latex
  vim.cmd("e " .. new_dir .. "output/output.tex")

end
