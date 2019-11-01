class Location

  attr_reader :name, :companies

  @@all = Array.new

  def initialize(location)
    @name = location
    @companies = Array.new
  end

  def self.all
    @all
  end

  def self.save
    @@all << self
  end

  def self.create = self.new(name)
    new_location = self.new(name)
    new_location.save
    new_location
  end

  def companies
    @companies
  end

  def industries
    self.companies.map { |company| comapany.industry }.uniq
  end

end