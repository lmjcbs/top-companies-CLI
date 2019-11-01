class Company

  attr_accessor :name, :location, :industry, :profile_url, :employee_satisfaction_percentage, :company_bio, :employee_count, :reviews

  @@all = Array.new

  def initialize(company_hash)
    @name = company_hash[:name]
    @profile_url = company_hash[:profile_url]
    @employee_satisfaction_percentage = company_hash[:employee_satisfaction_percentage]
    @company_bio = company_hash[:company_bio]
    @employee_count = company_hash[:employee_count]
    @review = company_hash[:reviews]

    #add_object(company_hash)
    #@location =  object
    #@industry =  object
  end

  def self.create_from_collection(companies_array)
    companies_array.each do |comapany_hash|
      self.new(comapany_hash)
    end
  end

  def self.all
    @@all
  end

end