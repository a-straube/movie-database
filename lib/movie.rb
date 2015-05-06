class Movie
  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_movies = DB.exec("SELECT * FROM movies;")
    movies = []
    returned_movies.each() do |movie|
      name = movie.fetch("name")
      id = movie.fetch("id").to_i()
      movies.push(Movie.new({:name => name, :id => id}))
    end
    movies
  end

  define_method(:save) do
    returned_movie = DB.exec("INSERT INTO movies (name) VALUES ('#{@name}') RETURNING id;")
    @id = returned_movie.first().fetch("id").to_i()
  end

  define_method(:==) do |movie2|
    self.name().==(movie2.name()).&(self.id().==(movie2.id()))
  end

  define_singleton_method(:find) do |id|
    @id = id
    result = DB.exec("SELECT * FROM movies WHERE id = #{@id};")
    @name = result.first.fetch("name")
    Movie.new({:name => @name, :id => @id})
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    DB.exec("UPDATE movies SET name = '#{@name}' WHERE id = #{self.id()};")

    attributes.fetch(:actors_id, []).each() do |x|
      DB.exec("INSERT INTO movies_actors (actors_id, movies_id) VALUES (#{x}, #{self.id()});")
    end
  end

  define_method(:delete) do
    DB.exec("DELETE FROM movies WHERE id = #{self.id()};")
  end

  define_method(:actors) do
    movie_actors = []
    results = DB.exec("SELECT actors_id FROM movies_actors WHERE movies_id = #{self.id()};")
    results.each() do |result|
      actor_id = result.fetch("actors_id").to_i()
      actor = DB.exec("SELECT * FROM actors WHERE id = #{actor_id};")
      name = actor.first().fetch("name")
      movie_actors.push(Actor.new({:name => name, :id => actor_id}))
    end
    movie_actors
  end
end
