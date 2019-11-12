class Location

  extend Findable

  attr_accessor :companies
  attr_reader :name

  @@all = Array.new

  def initialize(location)
    @name = location
    @companies = Array.new
  end

  def companies
    @companies
  end

  def self.names
    Location.all.map  { |location| location.name }
  end

  def industries
    self.companies.map { |company| company.industry }.uniq
  end

  def self.all
    @@all
  end

  def save
    @@all << self
  end

  def self.create(name)
    new_instance = self.new(name)
    new_instance.save
    new_instance
  end

end