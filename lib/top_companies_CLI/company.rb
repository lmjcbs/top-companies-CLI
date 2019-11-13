class Company

  attr_reader :name, :location, :industry, :employee_satisfaction_percentage, :company_bio, :employee_count, :reviews

  @@all = Array.new

  def initialize(company_hash)
    @name = company_hash[:name]
    @company_bio = company_hash[:company_bio]
    @employee_satisfaction_percentage = company_hash[:employee_satisfaction_percentage]
    @employee_count = company_hash[:employee_count]
    @reviews = company_hash[:reviews]
    self.location = company_hash[:location] if company_hash[:location] != nil
    self.industry = company_hash[:industry] if company_hash[:industry] != nil
    @@all << self
  end

  def self.print_companies_sorted_by_name
    sorted_companies = self.all.sort_by {|company| company.name}
    sorted_companies.each do |company_object|
      company_object.instance_variables.each do |variable|
        if variable.to_s == "@reviews"
          puts "#{variable.to_s.delete("@")}: ".magenta
          company_object.instance_variable_get(variable).each {|review| puts review}
        else
          puts "#{variable.to_s.delete("@")}: ".magenta + "#{company_object.instance_variable_get(variable)}"
        end
      end
    end
  end

  def self.create_from_collection(companies_array)
    companies_array.each do |company_hash| 
      new_company = self.new(company_hash)
    end
  end

  def self.all
    @@all
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
