return {
  {
    "rcasia/neotest-java",
    ft = "java",
    dependencies = {
      "mfussenegger/nvim-jdtls",
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
    },
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      adapters = {
        ["neotest-java"] = {
          test_directory = "tst",
          root_dir = function()
            -- Force Neotest to recognize Ant by treating it like Maven
            local cwd = vim.fn.getcwd()
            if vim.fn.filereadable(cwd .. "/build.xml") == 1 then
              return cwd
            end
            return require("jdtls.setup").find_root({ "pom.xml", "build.gradle", ".git" }) or cwd
          end,
          ignore_wrapper = true,
          force_test_class = true,
          incremental_build = true,
          extra_args = { "-Dtest=true -Ddomain=test -Djunit.jupiter.execution.parallel.enabled=false" },
        },
      },
    },
  },
}
