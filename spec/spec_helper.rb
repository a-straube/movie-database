require('rspec')
require('pg')
require('rspec')
require('actor')
require('movie')

DB = PG.connect({:dbname => "movie_database_test"})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM movies *;")
    DB.exec("DELETE FROM actors *;")
    DB.exec("DELETE FROM movies_actors *;")
  end
end
