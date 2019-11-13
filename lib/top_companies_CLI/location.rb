class Location

  extend Findable

  attr_accessor :companies
  attr_reader :name

  @@all = Array.new

  def initialize(location)
    @name = location
    @companies = Array.new
    @@all << self
  end

  def companies
    @companies
  end

  def self.names
    self.all.map  { |location| location.name }
  end

  def self.all
    @@all
  end

end