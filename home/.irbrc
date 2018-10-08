require 'pathname'
require 'irb/completion'
require 'irb/ext/save-history'

if Pathname('~/Workspace/dotfiles/ruby/helpers.rb').expand_path.exist?
  require '~/Workspace/dotfiles/ruby/helpers.rb'
end

IRB.conf[:BACK_TRACE_LIMIT]=16
IRB.conf[:AUTO_INDENT] = true
IRB.conf[:SAVE_HISTORY] = 1024
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"
