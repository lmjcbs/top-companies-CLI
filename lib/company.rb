class Company

  attr_accessor :name, :location, :industry, :profile_url

  @@all = Array.new

  def initialize(company_hash)
    @name = company_hash[:name]
    @profile_url = company_hash[:profile_url]
    @employee_satisfaction_percentage = company_hash[:employee_satisfaction_percentage]
    @comapny_bio = company_hash[:comapny_bio]
    @employee_count = comapny_hash[:employee_count]
    @review = comapny_hash[:reviews]

    #add_object_property(company_hash)
    #@location =  object
    #@industry =  object
  end

  def self.all
    @@all
  end

end