class Scraper

  def self.scrape_index_page(index_url)
    html = Nokogiri::HTML(open(index_url))
    html.css("div.col-md-5.col-xs-12.company-text").each do |company|
      company_index_hash = {
        name: company.css("a.link.h5").text.strip,
        industry: company.css("div.industry").text.strip,
        location: company.css("div.location").text.split(',').map(&:strip)[1]
      }
      profile_url = company.css("a.link.h5").attribute("href").value
      company_profile_hash = self.scrape_profile_page(profile_url)
      Company.new(company_index_hash.merge(company_profile_hash))
    end
  end

  def self.scrape_profile_page(profile_url)
    html = Nokogiri::HTML(open(profile_url))
    company_profile_hash = {
      employee_satisfaction_percentage: html.css("div.gptw-percentage-label.weight-medium").text.gsub('%', ''),
      company_bio: html.css("div#about-the-company-content p").text,
      employee_count: html.css("p.small.company-size-number").text.split(" ")[0],
      reviews: html.css("div.text").text.scan(/[^\.!?]+[\.!?]/).map(&:strip)
    }
  end

end
