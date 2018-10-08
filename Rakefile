require "pathname"
require "fileutils"
require "rubygems/user_interaction"

module Helper
  extend Gem::UserInteraction
  extend FileUtils

  YES_VALUES = ['', 'y', 'yes']
  
  module_function
  
  def yes?(question)
    YES_VALUES.include? ask("#{question} [Y/n]").to_s.downcase
  end

  def workdir_path
    path_src("~/Workspace")
  end

  def path_src(str)
    Pathname(str).expand_path
  end

  def create_workspace_dir
    mkdir_p(workdir_path)
  end

  def move_project
    mv(path_src("."), workdir_path) 
  end
end

namespace :dotfiles do
  task default: %w[create_workspace_dir move_project add_dot_files]

  task :create_workspace_dir do
    Helper.create_workspace_dir
  end

  task :move_project do
    Helper.move_project
  end

  task :add_dot_files do
    dots_dir = Pathname(File.expand_path("../home/", __FILE__))

    Dir.foreach(dots_dir) do |filename|
      next if "." == filename || ".." == filename
      next unless Helper.yes?("copy #{filename} ?")

      cp dots_dir.join(filename), Pathname("~/#{filename}").expand_path
    end
  end
end

task default: :"dotfiles:default"
