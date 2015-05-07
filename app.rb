require('sinatra')
require('sinatra/reloader')
require('./lib/movie')
require('./lib/actor')
also_reload('lib/**/*.rb')
require('pg')

DB= PG.connect({:dbname => 'movie_database_test'})

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

post('/actors') do
  name = params.fetch('name')
  actor = Actor.new({:name => name, :id => nil})
  actor.save()
  @actors = Actor.all()
  erb(:actors_form)
end

post('/movies') do
  name = params.fetch('name')
  movie = Movie.new({:name => name, :id => nil})
  movie.save()
  @movies = Movie.all()
  erb(:movies_form)
end

get('/actors/:id') do
  @actor = Actor.find(params.fetch("id").to_i())
  @movies = Movie.all()
  erb(:actor)
end

patch('/actors/:id') do
  actor_id = params.fetch("id").to_i()
  @actor = Actor.find(actor_id)
  movie_id = params.fetch("movie_id")
  @actor.update({:movies_id => movie_id})
  @movies = Movie.all()
  erb(:actor)
end

get('/movies/:id') do
  @movie = Movie.find(params.fetch("id").to_i())
  @actors = Actor.all()
  erb(:movie)
end

patch('/movies/:id') do
  movie_id = params.fetch("id").to_i()
  @movie = Movie.find(movie_id)
  actor_id = params.fetch("actor_id")
  @movie.update({:actors_id => actor_id})
  @actors = Actor.all()
  erb(:movie)
end

delete('/actors/:id') do
  @actor = Actor.find(params.fetch("id").to_i())
  @actor.delete()
  @actors = Actor.all()
  @movies = Movie.all()
  redirect('/')
end

delete('/movies/:id') do
  @movie = Movie.find(params.fetch("id").to_i())
  @movie.delete()
  @actors = Actor.all()
  @movies = Movie.all()
  redirect('/')
end
