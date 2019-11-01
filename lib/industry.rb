class Industry

  extend Concerns::Utilities
  extend Concerns::Findable

  attr_reader :name, :companies

  @@all = Array.new

  def initialize(industry)
    @name = industry
    @companies = Array.new
  end
  
  def companies
    @companies
  end

  def locations
    self.companies.map { |company| company.location }.uniq
  end

end