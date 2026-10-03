local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<leader>ha", function()
    harpoon:list():add()
end)
vim.keymap.set("n", "<leader>he", function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
end)
-- delete
-- vim.keymap.set("n", "<leader>d", function() harpoon:list():delete() end)

vim.keymap.set("n", "<leader>h1", function()
    harpoon:list():select(1)
end)
vim.keymap.set("n", "<leader>h2", function()
    harpoon:list():select(2)
end)
vim.keymap.set("n", "<leader>h3", function()
    harpoon:list():select(3)
end)
vim.keymap.set("n", "<leader>h4", function()
    harpoon:list():select(4)
end)
-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-g>h", function()
    harpoon:list():prev()
end)
vim.keymap.set("n", "<C-g>l", function()
    harpoon:list():next()
end)

--
-- git specific lists
--
--
--

local function git_branch()
    local result = vim.fn.systemlist("git branch --show-current")

    if vim.v.shell_error ~= 0 or not result[1] or result[1] == "" then
        return nil
    end

    return result[1]
end

BranchName = git_branch()

local function refresh_branch()
    BranchName = git_branch()
end

vim.keymap.set("n", "<leader>e", function()
    refresh_branch()
    if BranchName then
        harpoon.ui:toggle_quick_menu(harpoon:list(BranchName))
    else
        vim.notify("Not in a git repository")
    end
end)

vim.keymap.set("n", "<leader>a", function()
    if BranchName then
        harpoon:list(BranchName):add()
    else
        vim.notify("Not in a git repository")
    end
end)

vim.keymap.set("n", "<leader>1", function()
    if BranchName then
        harpoon:list(BranchName):select(1)
    else
        vim.notify("Not in a git repository")
    end
end)
vim.keymap.set("n", "<leader>2", function()
    if BranchName then
        harpoon:list(BranchName):select(2)
    else
        vim.notify("Not in a git repository")
    end
end)
vim.keymap.set("n", "<leader>3", function()
    if BranchName then
        harpoon:list(BranchName):select(3)
    else
        vim.notify("Not in a git repository")
    end
end)
vim.keymap.set("n", "<leader>4", function()
    if BranchName then
        harpoon:list(BranchName):select(4)
    else
        vim.notify("Not in a git repository")
    end
end)

vim.keymap.set("n", "<C-h>", function()
    if BranchName then
        harpoon:list(BranchName):prev()
    else
        vim.notify("Not in a git repository")
    end
end)
vim.keymap.set("n", "<C-l>", function()
    if BranchName then
        harpoon:list(BranchName):next()
    else
        vim.notify("Not in a git repository")
    end
end)
