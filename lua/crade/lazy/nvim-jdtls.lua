-- /opt/homebrew/Cellar/jdtls/1.44.0
return {
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    config = function()
      local jdtls = require("jdtls")
      local home = os.getenv("HOME")

      -- Find the root directory of your project
      local root_markers = { "gradlew", "pom.xml", ".git" }
      local root_dir = require("jdtls.setup").find_root(root_markers)

      local workspace_dir = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

      -- Fix the jar path (remove double slash)
      local jar_path = vim.fn.glob(
      "/opt/homebrew/Cellar/jdtls/1.44.0/libexec/plugins/org.eclipse.equinox.launcher_*.jar")

      local config = {
        cmd = {
          "java",
          "-Declipse.application=org.eclipse.jdt.ls.core.id1",
          "-Dosgi.bundles.defaultStartLevel=4",
          "-Declipse.product=org.eclipse.jdt.ls.core.product",
          "-Dlog.protocol=true",
          "-Dlog.level=ALL",
          "-Xms1g",
          "--add-modules=ALL-SYSTEM",
          "--add-opens", "java.base/java.util=ALL-UNNAMED",
          "--add-opens", "java.base/java.lang=ALL-UNNAMED",
          "-jar", jar_path,
          "-configuration", "/opt/homebrew/Cellar/jdtls/1.44.0/libexec/config_mac",
          "-data", workspace_dir,
        },
        root_dir = root_dir,
        settings = {
          java = {
            configuration = {
              runtimes = {
                { name = "JavaSE-17", path = "/opt/homebrew/Cellar/openjdk@21/21.0.5/libexec/openjdk.jdk/Contents/Home" }
              }
            }
          }
        },
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      }

      -- Start or attach JDTLS
      jdtls.start_or_attach(config)
    end
  }
}
