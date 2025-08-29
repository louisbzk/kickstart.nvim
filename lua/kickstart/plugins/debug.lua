-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
    'mfussenegger/nvim-dap-python',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_setup = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        -- 'delve',
      },
    }

    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<F9>', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<F12>', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Breakpoint' })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close
    -- Install golang specific config
    require('dap-go').setup()

    -- configurations
    dap.adapters.cppdbg = {
      id = 'cppdbg',
      type = 'executable',
      command = '/home/louis.b-boulegue/.config/nvim/vscode_cpptools_dbg_ext/debugAdapters/bin/OpenDebugAD7',
    }
    dap.configurations.c = {
      {
        name = 'navlinux_file',
        type = 'cppdbg',
        request = 'launch',
        program = '/home/louis.b-boulegue/repos/pr1016-01/navlinux/outputs/bin/amd64/sysnav-pr1093-navlinux',
        cwd = '/home/louis.b-boulegue/repos/pr1093/preparation/',
        stopOnEntry = false,
        args = {
          'ATR/navlinux_file.json',
        },
      },
      {
        name = 'test-navcore',
        type = 'cppdbg',
        request = 'launch',
        program = '/home/louis.b-boulegue/repos/pr1016-01/navlinux/outputs/bin/amd64/tests/test-navcore',
        cwd = '/home/louis.b-boulegue/repos/pr1016-01/navlinux',
        stopOnEntry = false,
        args = {
          'tests/test_modules/dependencies/config_test.json',
        },
      },
      {
        name = 'navlinux_file_uc',
        type = 'cppdbg',
        request = 'launch',
        program = '/home/louis.b-boulegue/repos/pr1016-01/navlinux/outputs/bin/amd64/sysnav-pr1093-navlinux-uc',
        cwd = '/home/louis.b-boulegue/repos/pr1093/preparation/',
        stopOnEntry = false,
        args = {
          'ATR/navlinux_file_uc.json',
        },
      },
      {
        name = 'navlinux_file_simu',
        type = 'cppdbg',
        request = 'launch',
        program = '/home/louis.b-boulegue/repos/pr1016-01/navlinux/outputs/bin/amd64/sysnav-pr1093-navlinux',
        cwd = '/home/louis.b-boulegue/repos/pr1093/preparation/',
        stopOnEntry = false,
        args = {
          'ATR/navlinux_file_simu.json',
        },
      },
      {
        name = 'mimu_lbb',
        type = 'cppdbg',
        request = 'launch',
        program = '/home/louis.b-boulegue/repos/commonrestricted/mimu/tests/bin/lbb',
        cwd = '/home/louis.b-boulegue/',
        stopOnEntry = false,
      },
      {
        name = 'fitPositionDR.test-constant-bias',
        type = 'cppdbg',
        request = 'launch',
        program = '/home/louis.b-boulegue/repos/pr1016-01/navlinux/outputs/bin/amd64/tests/fitPositionDR/test-constant-bias',
        cwd = '/home/louis.b-boulegue/repos/pr1016-01/navlinux/',
        stopOnEntry = false,
      },
    }
    dap.configurations.cpp = {
      {
        name = 'microprocessing',
        type = 'cppdbg',
        request = 'launch',
        program = '/home/louis.b-boulegue/repos/pr1094/microprocessing/outputs/bin/amd64/sysnav-pr1094-microprocessing',
        args = {
          '--config',
          '/home/louis.b-boulegue/repos/pr1093/preparation/ATR/microprocessing_config_central.json',
          '--params',
          '/home/louis.b-boulegue/repos/pr1093/preparation/ATR/microprocessing_m6.json',
          '--file-in',
          '/home/louis.b-boulegue/repos/pr1093/preparation/local_data/m6_raw/20241009/20241009_CAPT8B404E15CE02_01_log_raw.txt',
          '--file-out',
          '/dev/null',
        },
        cwd = '/home/louis.b-boulegue/repos/pr1094/microprocessing/',
        stopOnEntry = false,
      },
      {
        name = 'microprocessing_sort',
        type = 'cppdbg',
        request = 'launch',
        program = '/home/louis.b-boulegue/repos/pr1094/microprocessing/outputs/bin/amd64/sysnav-pr1094-microprocessing',
        args = {
          '--config',
          '/home/louis.b-boulegue/repos/pr1093/preparation/ATR/microprocessing_config_central.json',
          '--params',
          '/home/louis.b-boulegue/repos/pr1093/preparation/ATR/microprocessing_m6.json',
          '--file-in',
          '/home/louis.b-boulegue/repos/pr1093/preparation/local_data/m6_raw/20241009/20241009_CAPT8B404E15CE02_01_log_raw.txt',
          '--file-out',
          '/dev/null',
        },
        cwd = '/home/louis.b-boulegue/repos/pr1094/microprocessing/',
        stopOnEntry = false,
      },
    }

    local dap_python = require 'dap-python'
    dap_python.setup '~/.venvs/debugpy/bin/python'
    dap_python.test_runner = 'pytest'
    table.insert(dap.configurations.python, {
      name = 'sysnav_pr1016_04_sysroad_simu.main',
      type = 'debugpy',
      request = 'launch',
      program = '/home/louis.b-boulegue/repos/pr1016-04/navlinuxsimulations/sysnav_pr1016_04_sysroad_simu/sysnav_pr1016_04_navlinux_simu/main.py',
      cwd = '/home/louis.b-boulegue/repos/pr1016-04/navlinuxsimulations/sysnav_pr1016_04_sysroad_simu/',
      args = {
        '../Files/config_simu.json',
      },
      justMyCode = false,
    })
    table.insert(dap.configurations.python, {
      name = 'decode_simu',
      type = 'debugpy',
      request = 'launch',
      program = '/home/louis.b-boulegue/repos/pr1016-04/navlinuxsimulations/sysnav_pr1016_04_sysroad_simu/sysnav_pr1016_04_navlinux_simu/nov_utils/decode_simu2.py',
      cwd = '/home/louis.b-boulegue/repos/pr1016-04/navlinuxsimulations/sysnav_pr1016_04_sysroad_simu/',
      args = {
        '--to-navlinux',
        '/home/louis.b-boulegue/repos/pr1016-04/navlinuxsimulations/Output/new_unit_tests/data/5000m_left_to_navlinux.txt',
        '--ref',
        '/home/louis.b-boulegue/repos/pr1016-04/navlinuxsimulations/Output/new_unit_tests/complete_traj/5000m_left.h5',
        '--out-path',
        '/home/louis.b-boulegue/repos/pr1016-01/navlinux/tests/test_modules/data_nav/',
      },
      justMyCode = false,
    })
    table.insert(dap.configurations.python, {
      name = 'toto',
      type = 'debugpy',
      request = 'launch',
      program = '/home/louis.b-boulegue/repos/pr1093/exploitation/tracktician/tests/utils/test_toto.py',
      justMyCode = false,
    })
    table.insert(dap.configurations.python, {
      name = 'sysnav_pr1093_tracktician',
      type = 'debugpy',
      request = 'launch',
      module = 'sysnav_pr1093_tracktician',
      cwd = '/home/louis.b-boulegue/repos/pr1093/exploitation/tracktician/',
      args = {
        '--ref',
        '/home/louis.b-boulegue/repos/pr1093/exploitation/tracktician/data/simulated_trajectories/complete_trajectory/5000m_straight.h5',
        '--trajectories',
        '/home/louis.b-boulegue/repos/pr1093/exploitation/tracktician/data/validation_process/test/complete_traj_b64/master/master_5000m_straight_complete_trajectory_b64.txt',
        '--out-path',
        '/tmp/tracktician_dbg',
      },
      justMyCode = false,
    })
    table.insert(dap.configurations.python, {
      name = 'test_dev_5',
      type = 'debugpy',
      request = 'launch',
      program = '/home/louis.b-boulegue/repos/test_dev_5/src/main.py',
      args = {
        '/home/louis.b-boulegue/repos/test_dev_5/grid1.txt',
      },
    })
    table.insert(dap.configurations.python, {
      name = 'sysnav_pr1093_analysis',
      type = 'debugpy',
      request = 'launch',
      program = '/home/louis.b-boulegue/repos/pr1093/exploitation/analyses/run_analysis.py',
      cwd = '/home/louis.b-boulegue/repos/pr1093/preparation',
      args = {
        '--input-files',
        'local_data/preprocessed_replay/20240927/20240927_CAPT8B404E15CE02_02_log_preprocessed_replay_cut_begin.txt',
        '--init-playback-files',
        'none',
        '--out-dir',
        'local_data/analyses/20240927/check',
        '--core-number',
        '4',
        '--no-carto',
        '--nav-uc',
      },
    })
  end,
}
