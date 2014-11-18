require "make_me_a_gem_called/version"

class MakeMeAGemCalled

  attr_reader :name

  def initialize(name)
    @name = name
  end

  def create_with_bundle
    system("bundle gem #{@name}")
  end

end
