class Actor
  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_actors = DB.exec("SELECT * FROM actors;")
    actors = []
    returned_actors.each() do |actor|
      name = actor.fetch("name")
      id = actor.fetch("id").to_i()
      actors.push(Actor.new({:name => name, :id => id}))
    end
    actors
  end

  define_method(:==) do |actor2|
    self.name().==(actor2.name()).&(self.id().==(actor2.id()))
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO actors (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_singleton_method(:find) do |id|
    @id = id
    returned_actor = DB.exec("SELECT * FROM actors WHERE id = #{@id};")
    @name = returned_actor.first().fetch("name")
    Actor.new({:name => @name, :id => @id})
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    DB.exec("UPDATE actors SET name = '#{@name}' WHERE id =  #{self.id()};")

    attributes.fetch(:movies_id, []).each() do |y|
      DB.exec("INSERT INTO movies_actors (movies_id, actors_id) VALUES (#{y}, #{self.id()});")
    end
  end

  define_method(:movies) do
    movies_array = []
    results = DB.exec("SELECT movies_id FROM movies_actors WHERE actors_id = #{self.id()};")
    results.each() do |result|
      mov_id = result.fetch("movies_id").to_i()
      movie = DB.exec("SELECT * FROM movies WHERE id = #{mov_id};")
      name = movie.first().fetch("name")
      movies_array.push(Movie.new({:name => name, :id => mov_id}))
    end
    movies_array
  end

  define_method(:delete) do
    DB.exec("DELETE FROM actors WHERE id = #{self.id()};")
  end
end
