require('spec_helper')

describe(Movie) do

  describe('#name') do
    it("returns the name of a movie") do
      movie_name = Movie.new({:name => "Superbad", :id => nil})
      expect(movie_name.name()).to(eq("Superbad"))
    end
  end

  describe('#id') do
    it("returns the id of a movie") do
      movie_name = Movie.new({:name => "Superbad", :id => 1})
      expect(movie_name.id()).to(eq(1))
    end
  end

  describe('.all') do
    it("is empty at first") do
      expect(Movie.all()).to(eq([]))
    end
  end

  describe('#save') do
    it("saves a movie to the database") do
      movie = Movie.new({:name => "Superbad", :id => nil})
      movie.save()
      expect(Movie.all()).to(eq([movie]))
    end
  end

  describe('#==') do
    it("is the same movie if it has the same name and id") do
      movie1 = Movie.new({:name => "Superbad", :id => nil})
      movie2 = Movie.new({:name => "Superbad", :id => nil})
      expect(movie1).to(eq(movie2))
    end
  end

  describe('.find') do
    it("will find a movie based on its id") do
      movie1 = Movie.new({:name => "Superbad", :id => nil})
      movie1.save()
      movie2 = Movie.new({:name => "Memento", :id => nil})
      movie2.save()
      expect(Movie.find(movie2.id())).to(eq(movie2))
    end
  end

  describe('#update') do
    # it("will update a movie name") do
    #   movie = Movie.new({:name => "Superbad", :id => nil})
    #   movie.save()
    #   movie.update({:name => "Pineapple Express"})
    #   expect(movie.name()).to(eq("Pineapple Express"))
    # end

    it("will add actors to a movie") do
      movie = Movie.new({:name => "Superbad", :id => nil})
      movie.save()
      jonah = Actor.new({:name => "Jonah Hill", :id => nil})
      jonah.save()
      seth = Actor.new({:name => "Seth Rogen", :id => nil})
      seth.save()
      actors_id = [jonah.id(), seth.id()]
      movie.update({:actors_id => actors_id})
      expect(movie.actors()).to(eq([jonah, seth]))
    end
  end

  describe('#actors') do
    it("will return all actors in a specific movie") do
      movie = Movie.new({:name => "Superbad", :id => nil})
      movie.save()
      jonah = Actor.new({:name => "Jonah Hill", :id => nil})
      jonah.save()
      seth = Actor.new({:name => "Seth Rogen", :id => nil})
      seth.save()
      movie.update({:actors_id => [jonah.id(), seth.id()]})
      expect(movie.actors()).to(eq([jonah, seth]))
    end
  end

  describe('#delete') do
    it("will delete a movie") do
      movie = Movie.new({:name => "Superbad", :id => nil})
      movie.save()
      movie2 = Movie.new({:name => "Pineapple Express", :id => nil})
      movie2.save()
      movie.delete()
      expect(Movie.all()).to(eq([movie2]))
    end
  end
end
