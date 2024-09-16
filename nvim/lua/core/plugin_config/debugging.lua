local dap = require('dap')
local dapui = require('dapui')

require("dapui").setup()

dap.adapters.python = {
  type = 'executable',
  command = 'python3',
  args = {'-m', 'debugpy.adapter'},
}


dap.configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = 'Launch file',
    program = '${file}',
    pythonPath = function()
      local conda_prefix = vim.fn.getenv('CONDA_PREFIX')
      if conda_prefix ~= vim.NIL and conda_prefix ~= '' then
        local conda_python = conda_prefix .. '/bin/python'
        if vim.fn.executable(conda_python) then
          return conda_python
        end
      end
      if vim.fn.executable('python3') then
        return 'python3'
      else
        return 'python'
      end
    end,
  },
}

-- keybindings
vim.fn.sign_define('DapBreakpoint',
                   {text = '🔴', texthl = '', linehl = '', numhl = ''})
vim.fn.sign_define('DapBreakpointRejected',
                   {text = '🟦', texthl = '', linehl = '', numhl = ''})
vim.fn.sign_define('DapStopped',
                   {text = '🟢', texthl = '', linehl = '', numhl = ''})

vim.keymap.set('n', '<leader>dc', function() require("dap").continue() end, {})
vim.keymap.set('n', '<leader>dn', function() require("dap").step_over() end, {})
vim.keymap.set('n', '<leader>di', function() require("dap").step_into() end, {})
vim.keymap.set('n', '<leader>do', function() require("dap").step_out() end, {})
vim.keymap.set('n', '<leader>dp', function() require("dap").pause.toggle() end, {})
vim.keymap.set('n', '<leader>db', function() require("dap").toggle_breakpoint() end, {})
vim.keymap.set('n', '<leader>dr', function() require("dap").repl.open() end, {})

vim.keymap.set('n', '<leader>dw', function() require"dap.ui.widgets".hover() end)
vim.keymap.set('n', '<leader>du', function() require("dapui").toggle() end, {})
vim.keymap.set('n', '<leader>d?', function()
    local widgets = require "dap.ui.widgets";
    widgets.centered_float(widgets.scopes)
end)

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
