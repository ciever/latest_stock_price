Gem::Specification.new do |s|
    s.name        = "latest_stock_price"
    s.version     = "1.0.3"
    s.summary     = "Latest stock price"
    s.authors     = ["Ciever Hassan"]
    s.description = "A gem for displaying the latest stock price."
    s.email       = "ciever.a.h@hotmail.com"
    s.homepage    = "https://github.com/ciever/latest_stock_price"
    s.license     = "MIT"
    s.required_ruby_version = '>= 3.0'
    
    s.files       = ["lib/http_client.rb", 
                     "lib/latest_stock_price.rb",
                     "lib/price_all.rb",
                     "lib/price.rb",
                     "lib/prices.rb",
                     "lib/version.rb",
                     "spec/http_client_spec.rb",
                     "spec/price_all_spec.rb",
                     "spec/price_spec.rb",
                     "spec/prices_spec.rb",
                     "spec/spec_helper.rb", 
                     "README.md",
                     "CHANGELOG.md",
                     "Gemfile",
                     ".rspec",
                     "latest_stock_price.gemspec"]

    s.add_development_dependency 'dotenv', '~> 3.0.0'
    s.add_development_dependency 'rspec', '~> 3.4.0'
    s.add_development_dependency 'webmock', '~> 3.19.1'

    s.add_dependency 'net-http', '~> 0.4.1'
    s.add_dependency 'uri', '~> 0.10.0'
end