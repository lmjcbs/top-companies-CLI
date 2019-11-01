class Industry

  attr_accessor :name, :companies

  @@all = Array.new

  def initialize(industry)
    @name = industry
    @companies = Array.new
  end

  def self.all
    @all
  end

  def self.save
    @@all << self
  end

  def self.create = self.new(name)
    new_industry = self.new(name)
    new_industry.save
    new_industry
  end
  
  def companies
    @companies
  end

  def locations
    self.companies.map { |company| company.location }.uniq
  end
  
end