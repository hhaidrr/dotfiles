return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
		"williamboman/mason.nvim",
		"mfussenegger/nvim-dap-python",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		local dap_python = require("dap-python")

		require("dapui").setup({})
		require("nvim-dap-virtual-text").setup({
			commented = true, -- Show virtual text alongside comment
		})

		dap_python.setup("python3")
		-- Automatically open/close DAP UI
		vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
		vim.keymap.set("n", "<leader>gb", dap.run_to_cursor)

		-- Eval under cursor
		vim.keymap.set("n", "<leader>?", function()
			require("dapui").eval(nil, { enter = true })
		end)

		vim.keymap.set("n", "<leader>c", dap.continue)
		vim.keymap.set("n", "<leader>i", dap.step_into)
		vim.keymap.set("n", "<leader>o", dap.step_over)
		vim.keymap.set("n", "<leader>0", dap.step_out)
		vim.keymap.set("n", "<leader>d", dap.step_back)
		vim.keymap.set("n", "<leader>r", dap.restart)

		-- Keymap to terminate debugging
		vim.keymap.set("n", "<leader>dq", function()
			require("dap").terminate()
		end, opts)

		vim.keymap.set("n", "<leader>u", dapui.toggle)

		dap.listeners.before.attatch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end

		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end
	end,
}
