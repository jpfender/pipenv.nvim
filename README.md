# pipenv.nvim

A tiny neovim plugin for automatically switching to the correct [pipenv](https://pipenv.pypa.io/en/latest/) for the open buffer.

## Installation

Using [`packer`](https://github.com/wbthomason/packer.nvim):

```lua
use({
    "jpfender/pipenv.nvim",
    requires = "nvim-lua/plenary.nvim",
})
```

## Usage

Call

```lua
require("pipenv").set_pipenv()
```

to set the venv of the current buffer to the associated pipenv (according to the output of `pipenv --venv` in the buffer's CWD).

To switch venvs automatically whenever you open or switch to a buffer, use an autocmd:

```lua
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		require("pipenv").set_pipenv()
	end,
})
```

To show the venv for the current buffer, call:

```lua
require("pipenv").get_current_venv()
```

This plugin includes a [`lualine`](https://github.com/nvim-lualine/lualine.nvim) component called
`pipenv` which echoes the current venv. Sample usage:

```lua
lualine_x = { { "pipenv", icon = "" }, "encoding", "fileformat", "filetype" },
```

## Requirements

- [plenary.nvim](https://github.com/nvim-lua/plenary.nvim)
- [pipenv](https://pipenv.pypa.io/en/latest/) if you want this plugin to do anything useful ;)
