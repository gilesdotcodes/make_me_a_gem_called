require_relative "make_me_a_gem_called/version"

class MakeMeAGemCalled

  attr_reader :name, :command_line, :rspec

  def initialize(name)
    @name = name
  end


  def create_with_bundle
    system("bundle gem #{@name}")
  end

  def create_spec_files
    system("mkdir #{@name}/spec")
    system("touch #{@name}/spec/spec_helper.rb")
    system("touch #{@name}/spec/#{@name}_spec.rb")
  end

  def add_to_spec_files
    system("echo require \\'spec_helper\\' >> #{@name}/spec/#{@name}_spec.rb")
    system("echo require \\'#{@name}_spec\\' >> #{@name}/spec/spec_helper.rb")
  end

  def add_require_relative_to_main_file
    system("sed -i \'\' 1d #{@name}/lib/#{@name}.rb")
    system("echo require_relative \\'#{@name}/version\\' | cat - #{@name}/lib/#{@name}.rb > #{@name}/lib/temp && mv #{@name}/lib/temp #{@name}/lib/#{@name}.rb")
  end

  def command_line_question
    puts "Would you like to run this gem in the command line? Y/N"
    @command_line = STDIN.gets.chomp
  end

  def command_line?
    @command_line == 'Y'||'y'||'yes'
  end

  def rspec_question
    puts "Would you like to use RSpec to test this gem? Y/N"
    @rspec = STDIN.gets.chomp
  end

  def rspec?
    @rspec == 'Y'||'y'||'yes'
  end

  def create_bin_files
    system("mkdir #{@name}/bin")
    system("touch #{@name}/bin/#{@name}")
  end

  def add_to_bin_files
    system("echo \\#\\!/usr/bin/env ruby >> #{@name}/bin/#{@name}")
    system("echo require \\'#{@name}\\' >> #{@name}/bin/#{@name}")
  end

  def create_tasks_files
    system("mkdir #{@name}/tasks")
    system("touch #{@name}/tasks/rspec.rake")
  end

  def add_to_tasks_files
    system("echo require \\'rspec/core/rake_task\\' >> #{@name}/tasks/rspec.rake")
    system("echo \'RSpec::Core::RakeTask.new(:spec)\' >> #{@name}/tasks/rspec.rake")

  end

  def add_to_rake_file
    system("echo \"Dir.glob(\'tasks/**/*.rake\').each(&method(:import))\" >> #{@name}/Rakefile")
  end

  def add_to_gemspec
    system("sed -i \'\' \'23i\\
      \t\tspec.add_development_dependency \"rspec\"\\
      \' #{name}/#{name}.gemspec")
  end

  def instructions
    puts "1. Add   spec.add_development_dependency 'rspec'   to your gemspec"
  end

end
