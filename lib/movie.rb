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

  define_singleton_method(:find) do

  end

end
