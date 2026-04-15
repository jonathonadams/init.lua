return {
  has_words_before = function()
    if vim.api.nvim_get_option_value("buftype", { buf = 0 }) == "prompt" then return false end
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
  end,

  get_python_path = function(workspace)
    -- Use activated virtualenv.
    if vim.env.VIRTUAL_ENV then
      return vim.fs.joinpath(vim.env.VIRTUAL_ENV, 'bin', 'python')
    end

    -- Find and use virtualenv via poetry in workspace directory.
    local poetry = vim.fn.glob(vim.fs.joinpath(workspace, 'poetry.lock'))
    if poetry ~= '' then
      local venv = vim.fn.trim(vim.fn.system('poetry env info -p'))
      return vim.fs.joinpath(venv, 'bin', 'python')
    end

    -- Find and use virtualenv via uv in workspace directory.
    local uv = vim.fn.glob(vim.fs.joinpath(workspace, 'uv.lock'))
    if uv ~= '' then
      local venv = vim.fn.trim(vim.fn.system('uv python find'))
      return venv
    end

    -- Fallback to system Python.
    return vim.fn.exepath('python3') or vim.fn.exepath('python') or 'python'
  end

}
