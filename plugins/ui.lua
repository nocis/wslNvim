return {
  {
    "hedyhli/outline.nvim",
  },
  {
    "folke/trouble.nvim",
  },
  -- messages, cmdline and the popupmenu
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "snippet parsing failed",
        },
        opts = { skip = true },
      })
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = " Error detected while processing TextChanged",
        },
        opts = { skip = true },
      })
      opts.lsp.signature = {
        auto_open = { enabled = false },
      } 
      -- local focused = true
      -- vim.api.nvim_create_autocmd("FocusGained", {
      -- 	callback = function()
      -- 		focused = true
      -- 	end,
      -- })
      -- vim.api.nvim_create_autocmd("FocusLost", {
      -- 	callback = function()
      -- 		focused = false
      -- 	end,
      -- })
      -- table.insert(opts.routes, 1, {
      -- 	filter = {
      -- 		cond = function()
      -- 			return not focused
      -- 		end,
      -- 	},
      -- 	view = "notify_send",
      -- 	opts = { stop = false },
      -- })
      --
      opts.commands = {
        all = {
          -- options for the message history that you get with `:Noice`
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {},
        },
      }

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(event)
          vim.schedule(function()
            require("noice.text.markdown").keys(event.buf)
          end)
        end,
      })

      opts.presets.lsp_doc_border = true
    end,
  },

  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 5000,
    },
  },

  --			buffer line
  --{
  --"akinsho/bufferline.nvim",
  --event = "VeryLazy",
  --keys = {
  --{ "<tab>", "<cmd>BufferLineCycleNext<cr>", desc = "Next tab" },
  --{ "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev tab" },
  --},
  --opts = {
  --options = {
  --mode buffers show tabs, tabs show only page
  --mode = "buffers",
  --always_show_bufferline = true,
  --separator_style = "slant",
  --show_buffer_close_icons = false,
  --show_close_icon = false,
  --},
  --},
  --},
}
