# require 'nokogiri'
# require 'open-uri'
# require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    scraped_companies = Array.new
    html = Nokogiri::HTML(open(index_url))
    html.css("div.col-md-5.col-xs-12.company-text").each do |company|
      company_index_hash = {
        name: company.css("a.link.h5").text.strip,
        industry: company.css("div.industry").text.strip,
        location: company.css("div.location").text.split(',').map(&:strip)[1]
      }
      profile_url = company.css("a.link.h5").attribute("href").value
      company_profile_hash = self.scrape_profile_page(profile_url)
      scraped_companies << company_index_hash.merge(company_profile_hash)
    end
    scraped_companies
  end

  def self.scrape_profile_page(profile_url)
    html = Nokogiri::HTML(open(profile_url))
    company_profile_hash = {
      employee_satisfaction_percentage: html.css("div.gptw-percentage-label.weight-medium").text.gsub('%', ''),
      company_bio: html.css("div#about-the-company-content p").text,
      employee_count: html.css("p.small.company-size-number").text.split(" ").first,
      reviews: html.css("div.text").text.scan(/[^\.!?]+[\.!?]/).map(&:strip)
    }
  end

end

#Scraper.scrape_index_page("https://www.greatplacetowork.com/best-workplaces/100-best/2019")