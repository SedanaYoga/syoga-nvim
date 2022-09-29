local status, comment = pcall(require, "nvim-treesitter.configs")
if (not status) then return end

comment.setup {
  context_commentstring = {
    enable = true,
    enable_autocmd = false
  },
  config = {
    typescript = { __default = '// %s', __multiline = '/* %s */' },
    javascript = {
      __default = '// %s',
      jsx_element = '{/* %s */}',
      jsx_fragment = '{/* %s */}',
      jsx_attribute = '// %s',
      comment = '// %s'
    }
  }
}

require('kommentary.config').configure_language('typescriptreact', {
  single_line_comment_string = 'auto',
  multi_line_comment_strings = 'auto',
  hook_function = function()
    require('ts_context_commentstring.internal').update_commentstring()
  end,
})

require('kommentary.config').configure_language('html', {
  single_line_comment_string = 'auto',
  multi_line_comment_strings = 'auto',
  hook_function = function()
    require('ts_context_commentstring.internal').update_commentstring()
  end,
})

require('ts_context_commentstring.internal').update_commentstring({
  key = '__multiline',
})

