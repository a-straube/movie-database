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
end
