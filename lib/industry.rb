class Industry

  attr_accessor :name

  @@all = Array.new

  def initialize(industry)
    @name = industry
  end

  def self.all
    @all
  end
  
end