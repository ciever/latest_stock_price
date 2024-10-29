
### Setup

If you don’t already have bundle, then run this in your project directory (where you’d like to use this gem): 

#### 1. Add The Gem 

``` 
bundle init
```

This will add a **Gemfile** to your project directory.

Inside the gem file, add the gem and dependencies like so:

```
gem 'latest_stock_price', ‘1.0.1’        # Ensure to use version 1.0.1 or above.
gem 'dotenv', '~> 3.0.0'                 # Dependency required. 
```

To install the gems, run:

```
bundle install
```

#### 2. Configure Credentials

This gem uses APIs from rapidapi.com. Ensure an account is created and gather your secret key after logging in.

In your project directory, create a `.env` file using the following command:

```
touch .env
```

Open the newly created `.env` file and add:

```
# Rapid API credentials
X_RAPIDAPI_KEY=‘Add_your_rapid_api_key_here’
X_RAPIDAPI_HOST='latest-stock-price.p.rapidapi.com'
```

### Example Usage 

As an example, create a new file in you project directory:

```
touch example.rb
```

There are 3 ways to interact with the gem:

#### 1. Get all the latest stock prices:

```ruby
# example.rb
require 'bundler/setup'
require 'latest_stock_price'

price_all = LatestStockPrice::PriceAll.fetch
puts price_all
```

In your project repository, run the following command to get the prices of all the stocks:

```ruby
ruby example.rb # should return an object with many stock data
```

#### 2. Get the latest price of a specific stock:

```ruby
# example.rb
require 'bundler/setup'
require 'latest_stock_price'

price = LatestStockPrice::Price.fetch("AAATECH.NS")
puts price
```

In your project repository, run the following command to get the price of a specific stock:

```
ruby example.rb # should return an object with one stock.
```

#### 3. Get the latest prices for a specified list of stocks:

```ruby
# example.rb
require 'bundler/setup'
require 'latest_stock_price'

prices = LatestStockPrice::Prices.fetch(['AAATECH.NS', 'AADHHOUS.NS'])
puts prices
```

In your project repository, run the following command for a list of the stocks and their data.

```
ruby example.rb # should return an object with the specified stocks.
```

### Warnings

The `.env` file contains your secret key. Ensure the file does not get committed to remote repositories by adding it to your `.gitignore` file.