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

  describe('.all') do
    it("has no actors in it at first") do
      expect(Actor.all()).to(eq([]))
    end
  end

  describe('#==') do
    it("if it has the same name and same id sets to equal") do
      actor1 = Actor.new({:name => "Brad Pitt", :id => nil})
      actor2 = Actor.new({:name => "Brad Pitt", :id => nil})
      expect(actor1).to(eq(actor2))
    end
  end

  describe('#save') do
    it("saves an actor to the database") do
      actor = Actor.new({:name => "Ingar Bergman", :id => nil})
      actor.save()
      expect(Actor.all()).to(eq([actor]))
    end
  end

  describe('.find') do
    it("finds the actor for a specific id") do
      actor = Actor.new({:name => "Brad Pitt", :id => nil})
      actor.save()
      actor2 = Actor.new({:name => "John Smith", :id => nil})
      actor2.save()
      expect(Actor.find(actor2.id())).to(eq(actor2))
    end
  end

  describe('#update') do
    it("updates an actor in the database") do
      actor = Actor.new({:name => "Ingar Bergman", :id => nil})
      actor.save()
      actor.update({:name => "Ingrid Bergman"})
      expect(actor.name()).to(eq("Ingrid Bergman"))
    end
  end

  describe('#delete') do
    it("deletes an actor from the database") do
      actor = Actor.new({:name => "Ingar Bergman", :id => nil})
      actor.save()
      actor2 = Actor.new({:name => "Ingrid Bergman", :id => nil})
      actor2.save()
      actor.delete()
      expect(Actor.all()).to(eq([actor2]))
    end
  end
end
