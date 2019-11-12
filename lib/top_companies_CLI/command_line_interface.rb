class CommandLineInterface

  attr_accessor :user_choice, :user_selection, :user_navigation_command, :user_company_selection, :filter_results
  attr_reader :company_profiles_array

  BASE_PATH = "https://www.greatplacetowork.com/best-workplaces/100-best/2019"

  def initialize
    #Store user choice to search by either location or industry
    @user_choice = nil
    #Store user selection of particular state or industry to further filter by
    @user_selection = String.new #remove nil names
    #Store chosen company profile to display
    @user_company_selection = String.new #remove nil names
    @user_navigation_command = nil
  end
  
  def run 
    puts "Welcome to top-companies-CLI!\nEnter 'search' to begin collecting company profiles.".blue
    user_input = nil
    while user_input != "search" do
      user_input = get_user_input
      puts "Invalid input, please try again.".red unless user_input == "search"
    end
    puts "Gathering data...\nHold tight, this could take a minute or two.".blue
    #@company_profiles_array = Company.create_from_collection(TestData.companies_array)
    @company_profiles_array = Company.create_from_collection(Scraper.scrape_index_page(BASE_PATH))
    puts "Data collected!".green
    main_loop
    puts "Exiting top-companies-CLI...".blue
  end

  def filter_results
    @company_profiles_array.select {|company| company[@user_choice.to_sym] == @user_selection if company[:name] != nil}
  end

  def list_companies
    results_string = String.new
    filter_results.each_with_index do |company, index|
      if index != filter_results.length - 1
        results_string += "#{company[:name]}, "
      else
        results_string += "#{company[:name]}.\nOr enter 'back' to return."
      end
    end
    results_string
  end

  def valid_company?
    !!filter_results.find {|company| company[:name] == @user_company_selection} #TODO better method
  end

  def print_company_profile(company)
    company.each do |key, value|
      if key != "reviews".to_sym 
        puts "#{key.to_s.gsub('_', ' ').capitalize}:".magenta + " #{value}".green if company[key] != nil
      else
        puts "#{key.to_s.capitalize}:".magenta
        company[key].each {|review| puts review.gsub('"', '').green}
      end
    end
  end

  def filtered_companies_loop
    puts list_companies.blue
    while !valid_company? do 
      @user_company_selection = get_user_input
      if @user_company_selection == 'back' 
        @user_selection = String.new #remove nil class
        return user_selection_loop
      end
      puts "Invalid input, please try again.".red unless valid_company?
    end
    company = filter_results.find {|company| company[:name] == @user_company_selection}
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