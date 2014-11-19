require_relative "make_me_a_gem_called/version"

class MakeMeAGemCalled

  attr_reader :name, :command_line, :rspec

  def initialize(name)
    @name = name
  end


  def create_with_bundle
    system("bundle gem #{@name}")
  end

  def change_into_directory
    system("cd #{name}")
  end

  def create_spec_files
    system("mkdir spec")
    system("touch spec/spec_helper.rb")
    system("touch spec/#{name}_spec.rb")
  end

  def add_to_spec_files
    system("echo require 'spec_helper' >> spec/#{name}_spec.rb")
    system("echo require '#{name}_spec' >> spec/spec_helper.rb")
  end

  def add_require_relative_to_main_file
    system("echo require_relative '#{name}/version' >> lib/#{name}.rb")
  end

  def command_line_question
    "Would you like to run this gem in the command line? Y/N"
    @command_line = gets.chomp
  end

  def command_line?
    @command_line == 'Y'||'y'||'yes'
  end

  def rspec_question
    "Would you like to use RSpec to test this gem? Y/N"
    @rspec = gets.chomp
  end

  def rspec?
    @rspec == 'Y'||'y'||'yes'
  end

  def create_bin_files
    system("mkdir bin")
    system("touch bin/#{name}")
  end

  def add_to_bin_files
    system("echo #!/usr/bin/env ruby >> bin/#{name}")
    system("echo require '#{name}' >> bin/#{name}")
  end

  def create_tasks_files
    system("mkdir tasks")
    system("touch tasks/rspec.rake")
  end

  def add_to_tasks_files
    system("echo require 'rspec/core/rake_task' >> tasks/rspec.rake")
    system("echo RSpec::Core::RakeTask.new(:spec) >> tasks/rspec.rake")

  end

  def add_to_rake_file
    system("echo Dir.glob('tasks/**/*.rake').each(&method(:import)) >> Rakefile")
  end

  def instructions
    "1. Add   spec.add_development_dependency 'rspec'   to your gemspec"
  end

end
