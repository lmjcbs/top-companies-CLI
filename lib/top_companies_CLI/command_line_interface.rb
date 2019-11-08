class CommandLineInterface

  BASE_PATH = "https://www.greatplacetowork.com/best-workplaces/100-best/2019"
  
  def run 
    display_welcome_message
    user_input = nil
    while user_input != "search" do
      user_input = get_user_input
    end
    display_gathering_message
    company_profiles_array = Company.create_from_collection(TestData.companies_array)
    #company_profiles_array = Company.create_from_collection(Scraper.scrape_index_page(BASE_PATH))
    puts "Data collected!".green

    main_loop
      user_choice = nil
      user_selection = nil
      user_navigation_command = nil
      user_company_selection = nil

      user_choice = ask_user_choice
      eval_user_choice(user_choice)

      while !is_user_selection_valid? do 
        user_selection = get_user_input
      end

      display_companies
        filter_results

        select_company
          display_company_profile
          get_user_navigation
            if back display_companies, 
      


    # remembers input to go back, takes user input and then displays the relevant companies
    # user can type in company name to see more info 
    # go back a level to view other companies, 
    # types home to exit to top level.
  end

  def display_welcome_message
    puts "Welcome to top-companies-CLI!".light_blue
    puts "Enter 'search' to begin collecting company profiles.".light_blue
  end

  def display_gathering_message
    puts "Gathering data...".light_blue
    puts "Hold tight, this could take a minute or two.".light_blue
  end

  def get_user_input
    input = nil
    input = gets.downcase.chomp
  end

  def ask_user_choice
    puts "Enter either 'location' or 'industry' to filter for companies".blue
    user_choice = nil
    while user_choice != "location" && user_choice != "industry" do
      user_choice = get_user_input
    end
    user_choice
  end

  def eval_user_choice(user_choice)
    case user_choice
    when "location"
      locations_string = String.new
      Location.names.each { |name| locations_string += "#{name}, " }
      puts locations_string
      puts "Enter the location you would like to filter by"
    when "industry"
      industries_string = String.new
      Industry.names.each { |name| industries_string += "#{name}, " }
      puts industries_string
      puts "Enter the industry you would like to filter by"
    end

  end

  def is_user_selection_valid?
    valid? = false
    case user_selection
    when "location"
      valid? = Location.names.include?(user_selection)
    when "industry"
      valid? = Industry.names.include?(user_selection)
    end
    valid? 
  end

  def filter_results

  end
  
end