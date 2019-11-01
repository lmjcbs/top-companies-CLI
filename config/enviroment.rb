#require 'bundler'
#Bundler.require
# require 'require_all'
# require_all 'lib'

require 'nokogiri'
require 'colorize'
require 'open-uri'
require 'pry'
require 'colorize'

require_relative "../lib/top_companies_CLI/scraper.rb"
require_relative "../lib/top_companies_CLI/company.rb"
require_relative "../lib/top_companies_CLI/location.rb"
require_relative "../lib/top_companies_CLI/industry.rb"
require_relative "../lib/top_companies_CLI/scraper.rb"
require_relative "../lib/top_companies_CLI/version.rb"
require_relative "../lib/top_companies_CLI/command_line_interface.rb"





# module Concerns

#   module Findable

#     def find_by_name(name)
#       self.all.find { |element| element.name == name }
#     end

#     def find_or_create_by_name(name)
#       self.find_by_name(name) == nil ? self.create(name) : self.find_by_name(name)
#     end

#   end

#   module Utilities

#     def all
#       @@all
#     end

#     def save
#       @@all << self #needs to save to instance of all for location and industry
#     end

#     def create(name)
#       new_instance = self.new(name)
#       new_instance.save
#       new_instance
#     end

#   end

# end

