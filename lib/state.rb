class State

  attr_accessor :name

  @@all = Array.new

  def initialize(state)
    @name = state
  end

  def self.all
    @all
  end

end