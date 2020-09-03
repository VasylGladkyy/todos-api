source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'rails', '~> 6.0.3', '>= 6.0.3.2'

gem 'active_model_serializers', '~> 0.10.0'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'

gem 'bcrypt', '~> 3.1', '>= 3.1.12'
gem 'jwt', '~> 1.5', '>= 1.5.4'

gem 'rubocop-rails', require: false

gem 'factory_bot_rails'
gem 'faker', git: 'https://github.com/faker-ruby/faker.git', branch: 'master'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'rspec-rails', '~> 4.0.1'
end

group :development do
  gem 'annotate'
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'database_cleaner-active_record'
  gem 'shoulda-matchers', '~> 4.0'
  gem 'simplecov', require: false
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
