require('sinatra')
require('sinatra/reloader')
require('./lib/movie')
require('./lib/actor')
also_reload('lib/**/*.rb')
require('pg')

DB= PG.connect({:dbname => 'movies_database_test'})

get('/') do
  @movies = Movie.all()
  @actors = Actor.all()
  erb(:index)
end

get('/movies') do
  @movies = Movie.all()
  erb(:movies_form)
end

get('/actors') do
  @actors = Actor.all()
  erb(:actors_form)
end

post('/movies/list') do
  erb(:movies_list)
end

post('/actors/list') do
  erb(:actors_list)
end
