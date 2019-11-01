class Company

  extend Concerns::Utilities

  attr_reader :name, :location, :industry, :profile_url, :employee_satisfaction_percentage, :company_bio, :employee_count, :reviews

  @@all = Array.new

  def initialize(company_hash)
    @name = company_hash[:name]
    @profile_url = company_hash[:profile_url]
    @employee_satisfaction_percentage = company_hash[:employee_satisfaction_percentage]
    @company_bio = company_hash[:company_bio]
    @employee_count = company_hash[:employee_count]
    @reviews = company_hash[:reviews]
    @location = Location.find_or_create_by_name(company_hash[:location])
    @industry = Industry.find_or_create_by_name(company_hash[:industry])
  end

  def self.create_from_collection(companies_array)
    companies_array.each do |company_hash| 
      new_company = self.new(company_hash)
      new_company.save
    end
  end

end