OSHome = nil
if vim.fn.has('macunix') then
   OSHome = os.getenv("HOME")
else
    OSHome = os.getenv("USERPROFILE")
end

local rgignore_path = OSHome .. "/.rgignore"
local rgignore_file = io.open(rgignore_path, "r")

if not rgignore_file then
  rgignore_file = io.open(rgignore_path, "w")
  if rgignore_file then
    rgignore_file:write "!.env*\n"
    rgignore_file:close()
  end
else
  rgignore_file:close()
end
