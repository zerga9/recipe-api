source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.2'

gem 'rails', '~> 7.0.4'

gem 'active_model_serializers', '~> 0.10.13'
gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', require: false
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'pry', '~> 0.14.1'
  gem 'rspec-rails', '~> 5.1.2'
end

group :test do
  gem 'database_cleaner', '~> 2.0.1'
  gem 'shoulda-matchers', '~> 5.2.0'
end
