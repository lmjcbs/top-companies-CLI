class CommandLineInterface

  attr_accessor :user_choice, :user_selection, :user_company_selection

  BASE_PATH = "https://www.greatplacetowork.com/best-workplaces/100-best/2019"

  def initialize
    #Store user choice to search by either location or industry
    @user_choice = nil
    #Store user selection of particular state or industry to further filter by
    @user_selection = nil
    #Store chosen company profile to display
    @user_company_selection = nil
  end
  
  def run 
    puts "Welcome to top-companies-CLI!\nEnter 'search' to begin collecting company profiles.".blue
    user_input = nil
    while user_input != "search" do
      user_input = get_user_input
      puts "Invalid input, please try again.".red unless user_input == "search"
    end
    puts "Gathering data...\nHold tight, this could take a minute or two.".blue
    Scraper.scrape_index_page(BASE_PATH)
    #Company.create_from_collection(TestData.companies_array) TEST
    puts "Data collected!".green
    main_loop
    puts "Exiting top-companies-CLI...".blue
  end

  def filter_results
    Company.all.select do |company| 
      company.instance_variable_get("@"+@user_choice) == @user_selection if company.name != nil
    end
  end

  def list_companies
    results_string = String.new
    filter_results.each_with_index do |company, index|
      if index != filter_results.length - 1
        results_string += "#{company.name}, "
      else
        results_string += "#{company.name}.\nOr enter 'back' to return."
      end
    end
    results_string
  end

  def valid_company?
    filter_results.any? {|company| company.name == @user_company_selection}
  end

  def print_company_profile(company_object)
    company_object.instance_variables.each do |variable|
      if company_object.instance_variable_get(variable) != nil
        if variable.to_s == "@reviews"
          puts "#{variable.to_s.delete("@").capitalize}: ".magenta
          company_object.instance_variable_get(variable).each {|review| puts review}
        else
          puts "#{variable.to_s.delete("@").gsub('_', ' ').capitalize}: ".magenta + "#{company_object.instance_variable_get(variable)}"
        end
      end
    end
  end

  def filtered_companies_loop
    puts list_companies.blue
    while !valid_company? do 
      @user_company_selection = get_user_input
      if @user_company_selection == 'back' 
        @user_selection = nil
        return user_selection_loop
      end
      puts "Invalid input, please try again.".red unless valid_company?
    end
    company = filter_results.find {|company| company.name == @user_company_selection}
    print_company_profile(company)
    puts "Enter 'back' to return to companies list or 'exit' to quit application".blue
    input = nil
    while input != "back" && input != "exit" do
      input = get_user_input
      puts "Invalid input, please try again.".red unless input == "back" || input == "exit"
    end
    case input
    when "back"
      @user_company_selection = nil
      return filtered_companies_loop
    when "exit"
      return
    end
  end

  def user_selection_loop
    eval_user_choice(@user_choice)
    while !user_selection_valid? do
      @user_selection = get_user_input
      if @user_selection == 'back'
        @user_choice = nil
        return main_loop
      end
      puts "Invalid input, please try again.".red unless user_selection_valid?
    end
    return filtered_companies_loop
  end

  def main_loop
    @user_choice = ask_user_choice
    return user_selection_loop
  end

  def ask_user_choice
    puts "Enter either 'location' or 'industry' to filter for companies.".blue
    user_choice = nil
    while user_choice != "location" && user_choice != "industry" do
      user_choice = get_user_input
      puts "Invalid input, please try again.".red unless user_choice == "location" || user_choice == "industry"
    end
    user_choice
  end

  def eval_user_choice(user_choice)
    output_string = String.new
    class_name = Object.const_get(@user_choice.capitalize)
    filtered_results = class_name.names.select {|name| name != nil}
    filtered_results.each_with_index do |name, index| 
      if index != filtered_results.length - 1
        output_string += "#{name}, "
      else
        output_string += "#{name}.\nEnter the #{user_choice} you would like to filter by or 'back' to return."
      end  
    end
    puts output_string.blue
  end

  def user_selection_valid?
    Object.const_get(@user_choice.capitalize).names.include?(@user_selection)
  end

  def get_user_input
    gets.chomp
  end
    
end