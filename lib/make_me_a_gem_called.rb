require_relative "make_me_a_gem_called/version"

class MakeMeAGemCalled

  attr_reader :name, :command_line, :rspec, :instructions

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
    @command_line == 'Y'||'y'||'yes'||'Yes'
  end

  def rspec_question
    puts "Would you like to use RSpec to test this gem? Y/N"
    @rspec = STDIN.gets.chomp
  end

  def rspec?
    @rspec == 'Y'||'y'||'yes'||'Yes'
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
      \\ \\ spec.add_development_dependency \"rspec\"\\
      \' #{name}/#{name}.gemspec")
  end

  def instructions_question
    puts "Would you like to see Instructions for your next steps? Y/N"
    @instructions = STDIN.gets.chomp
  end

  def instructions?
    @instructions = 'Y'||'y'||'yes'||'Yes'
  end

  def show_instructions
    puts "Basic Instructions"
    puts "1. Change into the directory   $ cd #{name}"
    puts "2. In your gemspec: Replace 'summary' and 'description' sections with a string using double quotations."
    puts "3. Write your code in the lib/#{name}.rb file."
    puts "4. If you decide to change from a Module to a Class, remember to change the version.rb file to a Class too."
    puts "5. The bin/#{name} file is run when your gem is called from the command line. Run your code in this file."
    puts "6. Don't forget to complete your README.md file."
    puts "7. If using GitHub, set up a new repo on GitHub. You do not need to run $git init because Bundle has done that for you."
    puts "8. To run your tests:  $ bundle exec rake spec"
    puts "9. To uploaded to rubygems.org:  $ bundle exec rake release"
    puts "Note: You must change the version number every time to upload any changes."
  end

end
