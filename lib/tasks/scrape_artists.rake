namespace :search_suggestions do
  desc "Scrape search suggestions from artists"
    task :index => :environment do
      SearchSuggestion.scrape_products
    end
end
