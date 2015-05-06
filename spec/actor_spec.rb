require('spec_helper')

describe(Actor) do

  describe('#name') do
    it("return the name of an actor") do
      actor = Actor.new({:name => "Brad Pitt", :id => nil})
      expect(actor.name()).to(eq("Brad Pitt"))
    end
  end

  describe('#id') do
    it("returns the id of an actor") do
      actor = Actor.new({:name => "Brad Pitt", :id => 1})
      expect(actor.id()).to(eq(1))
    end
  end
end
