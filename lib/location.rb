class Location

  extend Concerns::Utilities
  extend Concerns::Findable

  attr_reader :name, :companies

  @@all = Array.new

  def initialize(location)
    @name = location
    @companies = Array.new
  end

  def companies
    @companies
  end

  def industries
    self.companies.map { |company| comapany.industry }.uniq
  end

end