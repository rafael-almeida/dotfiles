return {
    'rafael-almeida/pomodoro.nvim',
    def = true,
    dir = '~/development/pomodoro.nvim',
    opt = {
        icons = false
    },
    config = function()
        require('pomodoro').setup()
    end,
}
