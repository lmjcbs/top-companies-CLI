class Company

  attr_accessor :name, :location, :industry, :profile_url, :employee_satisfaction_percentage, :company_bio, :employee_count, :reviews

  @@all = Array.new

  def initialize(company_hash)
    @name = company_hash[:name]
    @profile_url = company_hash[:profile_url]
    @employee_satisfaction_percentage = company_hash[:employee_satisfaction_percentage]
    @company_bio = company_hash[:company_bio]
    @employee_count = company_hash[:employee_count]
    @reviews = company_hash[:reviews]

    Location.find_or_create_by_name(company_hash)
    
    #add_object(company_hash)
    #@location =  object
    #@industry =  object

    self.save
  end

  def self.create_from_collection(companies_array)
    companies_array.each { |company_hash| self.new(company_hash) }
  end

  def self.all
    @@all
  end

  def self.save
    @@all << all
  end

end