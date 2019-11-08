class Industry

  extend Findable

  attr_accessor :companies
  attr_reader :name

  @@all = Array.new

  def initialize(industry)
    @name = industry
    @companies = Array.new
  end
  
  def companies
    @companies
  end

  def self.names
    Industry.all.map { |industry| industry.name }
  end

  def locations
    self.companies.map { |company| company.location }.uniq
  end

  def self.all
    @@all
  end

  def save
    @@all << self #needs to save to instance of all for location and industry
  end

  def self.create(name)
    new_instance = self.new(name)
    new_instance.save
    new_instance
  end

end