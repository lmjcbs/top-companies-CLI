class Industry

  extend Findable

  attr_accessor :companies
  attr_reader :name

  @@all = Array.new

  def initialize(industry)
    @name = industry
    @companies = Array.new
    @@all << self
  end
  
  def companies
    @companies
  end

  def self.names
    self.all.map { |industry| industry.name }
  end

  def self.all
    @@all
  end

end