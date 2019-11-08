class Company

  attr_reader :name, :location, :industry, :employee_satisfaction_percentage, :company_bio, :employee_count, :reviews

  @@all = Array.new

  def initialize(company_hash)
    @name = company_hash[:name]
    @company_bio = company_hash[:company_bio]
    @employee_satisfaction_percentage = company_hash[:employee_satisfaction_percentage]
    @employee_count = company_hash[:employee_count]
    @reviews = company_hash[:reviews]
    self.location = company_hash[:location]
    self.industry = company_hash[:industry]
  end

  def self.create(name)
    new_instance = self.new(name)
    new_instance.save
    new_instance
  end

  def self.create_from_collection(companies_array)
    companies_array.each do |company_hash| 
      new_company = self.new(company_hash)
      new_company.save
    end
  end

  def self.all
    @@all
  end

  def save
    @@all << self 
  end

  def location=(location_name)
    location = Location.find_or_create_by_name(location_name)
    @location = location.name
    location.companies << self
  end

  def industry=(industry_name)
    industry = Industry.find_or_create_by_name(industry_name)
    @industry = industry.name
    industry.companies << self
  end

end
