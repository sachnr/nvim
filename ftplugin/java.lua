local present, jdtls = pcall(require, "jdtls")
if not present then
	return
end

local capabilities = require("config.plugins.lsp.settings").capabilities
local on_attach = require("config.plugins.lsp.settings").on_attach
local plugin_folder = vim.fn.stdpath("data")
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = plugin_folder .. "/workspace/" .. project_name
local jdtls_folder = plugin_folder .. "/mason/packages/jdtls/"

local bundles = {
	vim.fn.glob(
		plugin_folder .. "/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"
	),
}

vim.list_extend(
	bundles,
	vim.split(vim.fn.glob(plugin_folder .. "/mason/packages/java-test/extension/server/*.jar"), "\n")
)

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

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
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-jar",
		jdtls_folder .. "plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",
		"-configuration",
		jdtls_folder .. "config_linux",
		"-data",
		workspace_dir,
	},
	on_attach = on_attach,
	capabilities = capabilities,
	root_dir = require("jdtls.setup").find_root({
		"build.xml", -- Ant
		"pom.xml", -- Maven
		"settings.gradle", -- Gradle
		"settings.gradle.kts", -- Gradle
	}),
	settings = {
		java = {
			signatureHelp = { enabled = true },
			contentProvider = { preferred = "fernflower" },
			completion = {
				favoriteStaticMembers = {
					"org.hamcrest.MatcherAssert.assertThat",
					"org.hamcrest.Matchers.*",
					"org.hamcrest.CoreMatchers.*",
					"org.junit.jupiter.api.Assertions.*",
					"java.util.Objects.requireNonNull",
					"java.util.Objects.requireNonNullElse",
					"org.mockito.Mockito.*",
				},
				filteredTypes = {
					"com.sun.*",
					"io.micrometer.shaded.*",
					"java.awt.*",
					"jdk.*",
					"sun.*",
				},
			},
			sources = {
				organizeImports = {
					starThreshold = 9999,
					staticStarThreshold = 9999,
				},
			},
			codeGeneration = {
				toString = {
					template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
				},
				hashCodeEquals = {
					useJava7Objects = true,
				},
				useBlocks = true,
			},
		},
		configuration = {
			updateBuildConfiguration = "interactive",
			runtimes = {
				{
					name = "JavaSE-19",
					path = vim.fn.expand("$JAVA_HOME"),
				},
			},
		},
		flags = {
			allow_incremental_sync = true,
		},
		init_options = {
			bundles = bundles,
			extendedClientCapabilities = extendedClientCapabilities,
		},
		eclipse = {
			downloadSources = true,
		},
		maven = {
			downloadSources = true,
		},
		implementationsCodeLens = {
			enabled = true,
		},
		referencesCodeLens = {
			enabled = false,
		},
		references = {
			includeDecompiledSources = true,
		},
		format = {
			-- Set this to true to use jdtls as your formatter
			enabled = false,
		},
		handlers = {},
	},
}

jdtls.start_or_attach(config)
