return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        jdtls = {
          cmd = (function()
            local home = os.getenv("HOME")
            local jdtls_path = home .. "/.local/share/nvim/mason/packages/jdtls"
            local workspace = home .. "/.local/share/jdtls-workspace"

            -- ✅ Function to always pick latest gtk.linux.aarch64 launcher JAR
            local function get_launcher_jar()
              local pattern = jdtls_path .. "/plugins/org.eclipse.equinox.launcher.gtk.linux.aarch64_*.jar"
              local jar = vim.fn.glob(pattern)
              return jar
            end

            return {
              "java",
              "-Declipse.application=org.eclipse.jdt.ls.core.id1",
              "-Dosgi.bundles.defaultStartLevel=4",
              "-Declipse.product=org.eclipse.jdt.ls.core.product",
              "-Dlog.level=ALL",
              "-noverify",
              "-Xms1g",
              "--add-modules=ALL-SYSTEM",
              "--add-opens", "java.base/java.util=ALL-UNNAMED",
              "--add-opens", "java.base/java.lang=ALL-UNNAMED",
              "-jar", get_launcher_jar(),
              "-configuration", jdtls_path .. "/config_linux_arm",
              "-data", workspace,
            }
          end)(),
          root_dir = require('lspconfig.util').root_pattern('.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle'),
        },
      },
    },
  },
}
