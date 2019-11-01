require 'nokogiri'
require 'open-uri'
require 'pry'


class Scraper

  def self.scrape_index_page(index_url)
    scraped_companies = Array.new
    html = Nokogiri::HTML(open(index_url))
    html.css("div.col-md-5.col-xs-12.company-text").each do |company|
      company_hash = {
        name: company.css("a.link.h5").text.strip,
        industry: company.css("div.industry").text.strip,
        location: company.css("div.location").text.strip,
        profile_url: company.css("a.link.h5").attribute("href").value
      }
      scraped_companies << company_hash
    end
    scraped_companies
  end

  def self.scrape_profile_page(profile_url)
    html = Nokogiri::HTML(open(profile_url))
    scraped_company = {
      employee_satisfaction_percentage: html.css("div.gptw-percentage-label.weight-medium").text,
      company_bio: html.css("div#about-the-company-content p").text,
      employee_count: html.css("p.small.company-size-number").text.split(" ").first,
      reviews: html.css("div.text").text
    }
    binding.pry
  end

end

#Scraper.scrape_profile_page("https://www.greatplacetowork.com/certified-company/1000367")
#Scraper.scrape_index_page("https://www.greatplacetowork.com/best-workplaces/100-best/2019")