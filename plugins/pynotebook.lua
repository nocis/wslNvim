return {
  {
    "nocis/jupytext.nvim",
    -- enabled = false,
    lazy = false,
    opts = {
      custom_language_formatting = {
        python = {
          extension = "qmd",
          style = "quarto",
          force_ft = "quarto",
        },
        -- r = {
        --   extension = "qmd",
        --   style = "quarto",
        --   force_ft = "quarto",
        -- },
      },
    },
  },
  { "nocis/otter.nvim", ft = { "markdown", "quarto", "norg" } },
  {
    "nocis/quarto-nvim",
    dependencies = {
      "nvim-lspconfig",
      "otter.nvim",
    },
    ft = { "quarto", "markdown", "norg" },
    config = function()
      local quarto = require("quarto")
      quarto.setup({
        lspFeatures = {
          languages = { "python", "rust", "lua" },
          chunks = "all", -- 'curly' or 'all'
          diagnostics = {
            enabled = true,
            triggers = { "BufWritePost" },
          },
          completion = {
            enabled = true,
          },
        },
        codeRunner = {
          enabled = true,
          default_method = "molten",
        },
      })
    end,
    keys = {
      {
        "<leader>mp",
        function()
          require("quarto").quartoPreview()
        end,
        desc = "Preview the Quarto document",
      },
    },
  },
  -- {
  --   -- see the image.nvim readme for more information about configuring this plugin
  --   "nocis/image.nvim",
  --   opts = {
  --     backend = "sixel", -- whatever backend you would like to use
  --     integrations = {
  --       markdown = {
  --         enabled = true,
  --         clear_in_insert_mode = false,
  --         download_remote_images = true,
  --         only_render_image_at_cursor = false,
  --         filetypes = { "markdown", "quarto" }, -- markdown extensions (ie. quarto) can go here
  --       },
  --       neorg = {
  --         enabled = true,
  --         clear_in_insert_mode = false,
  --         download_remote_images = true,
  --         only_render_image_at_cursor = false,
  --         filetypes = { "norg" },
  --       },
  --     },
  --     max_width = 100,
  --     max_height = 8,
  --     max_height_window_percentage = math.huge,
  --     max_width_window_percentage = math.huge,
  --     window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
  --     editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
  --     window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "fidget", "" },
  --   },
  -- },
  -- sudo apt install libmagickwand-dev for magick
  -- sudo apt install libsixel-bin      for sixel BE but this still bad
  {
    "nocis/molten-nvim",
    -- dependencies = { "nocis/image.nvim" },
    build = ":UpdateRemotePlugins",
    init = function()
      vim.g.molten_auto_open_output = false
      vim.g.molten_image_location = "both"
      vim.g.molten_output_win_border = { "", "━", "", "" }
      vim.g.molten_output_win_max_height = 12
      vim.g.molten_virt_text_output = true
      vim.g.molten_use_border_highlights = true
      vim.g.molten_virt_lines_off_by_1 = true
      vim.g.molten_wrap_output = true
      vim.g.molten_tick_rate = 142
      vim.g.molten_image_provider = "none"
      vim.g.molten_auto_image_popup = false

      local runner = require("quarto.runner")
      vim.keymap.set("n", "<leader>mr", runner.run_cell, { desc = "run cell", silent = true })
      vim.keymap.set("n", "<leader>ma", runner.run_above, { desc = "run cell and above", silent = true })
      vim.keymap.set("n", "<leader>mA", runner.run_all, { desc = "run all cells", silent = true })
      vim.keymap.set("n", "<leader>ml", runner.run_line, { desc = "run line", silent = true })
      vim.keymap.set("v", "<leader>mv", runner.run_range, { desc = "run visual range", silent = true })
      vim.keymap.set(
        "n",
        "<leader>mo",
        ":noautocmd MoltenEnterOutput<CR>",
        { desc = "open output window", silent = true }
      )
      vim.keymap.set("n", "<leader>mp", ":MoltenImagePopup<CR>", { silent = true, desc = "open image popup" })
      vim.keymap.set("n", "<leader>mc", ":MoltenInterrupt<CR>", { silent = true, desc = "interrupt/cancel cell" })

      local default_notebook = [[
  {
    "cells": [
     {
      "cell_type": "markdown",
      "metadata": {},
      "source": [
        ""
      ]
     }
    ],
    "metadata": {
     "kernelspec": {
      "display_name": "Python 3",
      "language": "python",
      "name": "python3"
     },
     "language_info": {
      "codemirror_mode": {
        "name": "ipython"
      },
      "file_extension": ".py",
      "mimetype": "text/x-python",
      "name": "python",
      "nbconvert_exporter": "python",
      "pygments_lexer": "ipython3"
     }
    },
    "nbformat": 4,
    "nbformat_minor": 5
  }
]]

      local function new_notebook(filename)
        local path = vim.fn.expand("%:p:h") .. "/" .. filename .. ".ipynb"
        local file = io.open(path, "w")
        if file then
          file:write(default_notebook)
          file:close()
          vim.cmd("edit " .. path)
        else
          print("Error: Could not open new notebook file for writing.")
        end
      end

      vim.api.nvim_create_user_command("NewNotebook", function(opts)
        new_notebook(opts.args)
      end, {
        nargs = 1,
        complete = "file",
      })
    end,
    keys = {
      {
        "<leader>mi",
        function()
          local function ensure_kernel_for_venv_new_name()
            local venv_path = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
            if not venv_path then
              vim.notify("No virtual environment found.", vim.log.levels.WARN)
              return
            end

            -- Canonicalize the venv_path to ensure consistency
            venv_path = vim.fn.fnamemodify(venv_path, ":p")
            vim.notify(venv_path, vim.log.levels.INFO)

            -- Check if the kernel spec already exists
            local handle = io.popen("jupyter kernelspec list --json")
            local existing_kernels = {}
            if handle then
              local result = handle:read("*a")
              handle:close()
              local json = vim.fn.json_decode(result)
              -- Iterate over available kernel specs to find the one for this virtual environment
              for kernel_name, data in pairs(json.kernelspecs) do
                existing_kernels[kernel_name] = true -- Store existing kernel names for validation
                local kernel_path = vim.fn.fnamemodify(data.spec.argv[1], ":p") -- Canonicalize the kernel path
                if kernel_path:find(venv_path, 1, true) then
                  vim.notify("Kernel spec for this virtual environment already exists.", vim.log.levels.INFO)
                  return kernel_name
                end
              end
            end

            -- Prompt the user for a custom kernel name, ensuring it is unique
            local new_kernel_name
            repeat
              new_kernel_name = vim.fn.input("Enter a unique name for the new kernel spec: ")
              if new_kernel_name == "" then
                vim.notify("Please provide a valid kernel name.", vim.log.levels.ERROR)
                return
              elseif existing_kernels[new_kernel_name] then
                vim.notify(
                  "Kernel name '" .. new_kernel_name .. "' already exists. Please choose another name.",
                  vim.log.levels.WARN
                )
                new_kernel_name = nil
              end
            until new_kernel_name

            -- Create the kernel spec with the unique name
            print("Creating a new kernel spec for this virtual environment...")
            local cmd = string.format(
              '%s -m ipykernel install --user --name="%s"',
              vim.fn.shellescape(venv_path .. "/bin/python"),
              new_kernel_name
            )

            os.execute(cmd)
            vim.notify("Kernel spec '" .. new_kernel_name .. "' created successfully.", vim.log.levels.INFO)
            return new_kernel_name
          end

          local function ensure_kernel_for_venv()
            local venv_path = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
            if not venv_path then
              vim.notify("No virtual environment found.", vim.log.levels.WARN)
              return
            end

            -- Canonicalize the venv_path to ensure consistency
            venv_path = vim.fn.fnamemodify(venv_path, ":p")

            -- Check if the kernel spec already exists
            local handle = io.popen("jupyter kernelspec list --json")
            local existing_kernels = {}
            if handle then
              local result = handle:read("*a")
              handle:close()
              local json = vim.fn.json_decode(result)
              -- Iterate over available kernel specs to find the one for this virtual environment
              for kernel_name, data in pairs(json.kernelspecs) do
                local startswith = "python"
                if kernel_name:find(startswith) ~= 1 then
                  existing_kernels[kernel_name] = true -- Store existing kernel names for validation
                  local kernel_path = vim.fn.fnamemodify(data.spec.argv[1], ":p") -- Canonicalize the kernel path
                  if kernel_path:find(venv_path, 1, true) then
                    vim.notify("Kernel spec for this virtual environment already exists.", vim.log.levels.INFO)
                    return kernel_name
                  end
                end
              end
            end

            local new_kernel_name = string.match(venv_path, "/.+/(.+)/.+env/?")

            -- Create the kernel spec with the unique name
            print("Creating a new kernel spec for this virtual environment...")
            local cmd = string.format(
              '%s -m ipykernel install --user --name="%s"',
              vim.fn.shellescape(venv_path .. "/bin/python"),
              new_kernel_name
            )

            os.execute(cmd)
            vim.notify(cmd, vim.log.levels.WARN)
            vim.notify("Kernel spec '" .. new_kernel_name .. "' created successfully.", vim.log.levels.INFO)
            return new_kernel_name
          end

          local kernel_name = ensure_kernel_for_venv()
          if kernel_name then
            vim.cmd(("MoltenInit %s"):format(kernel_name))
            require("quarto").activate()
          else
            vim.notify("No kernel to initialize.", vim.log.levels.WARN)
          end
        end,
        desc = "Jupyter Init",
      },
    },
  },
}

--  pip install jupyter_client ipykernel  jupytext quarto-cli

-- 1. neovim python env + pynvim + vim.g.python3_host_prog for python as neovim provider to load molten correctly
-- 2. proj env + jupyter_client + ipykernel + jupytext
-- 3. create jupyter runtime folder
-- 4. install quarto-cli from pip, this is necessary run cell
-- 5. bug inside pyproject.toml will break jupytext
-- -- cause jupytext load config from pyproject too
-- -- ie. duplicate pyright ignore rules will break jupytext!!!!
-- --
-- -- -- tomllib.TOMLDecodeError: Cannot overwrite a value (at line 11, column 29)
--
