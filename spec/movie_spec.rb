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
end
