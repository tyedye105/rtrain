require('rspec')
require('pg')
require('Train')
require('city')


RSpec.configure do |config|
 config.after(:each) do
   DB.exec("DELETE FROM trains *;")
   DB.exec("DELETE FROM cities *;")
 end
end

test_city = City.new({:name => "PDX"})

describe(City) do
  describe("#initialize") do
    it('will create a new City with name' ) do
      expect(test_city.name()).to(eq('PDX'))
    end
  end

  describe(".all") do
    it("is an empty array at first") do
      expect(City.all()).to(eq([]))
    end
  end

  describe("#==") do
    it('will return objects are the same if their name matches') do
      test_city
      test_city2 = City.new({:name => "PDX"})
      expect(test_city.name()).to(eq(test_city2.name))
    end
  end

  describe("#save") do
    it('will save the city in to the cities database') do
      test_city.save()
      test_city2 = City.new({:name => "PDX"})
      test_city2.save()
      expect(City.all()).to(eq([test_city, test_city2]))
    end
  end

  describe("#update") do
    it("updates the city") do
      test_city.save()
      test_city.update({:name => "Houston"})
      expect(test_city.name()).to(eq("Houston"))
    end

    it("add a train that stops in the city") do
      train1 = Train.new({:name => "r-Train"})
      train1.save()
      train2 = Train.new({:name => "Pain Train"})
      train2.save()
      test_city.save()
      test_city.update({:train_ids => [train1.id()]})
      test_city.update({:train_ids => [train2.id()]})
      expect(test_city.trains()).to(eq([train1, train2]))
    end
  end

  describe("#trains") do
    it("returns all of the trains that stop in the city") do
      train1 = Train.new({:name => "r-Train"})
      train1.save()
      train2 = Train.new({:name => "Pain Train"})
      train2.save()
      test_city.save()
      test_city.update({:train_ids => [train1.id()]})
      test_city.update({:train_ids => [train2.id()]})
      expect(test_city.trains()).to(eq([train1, train2]))
    end
  end


  describe("#delete") do
    it('will delete the city.') do
      test_city.save()
      test_city.delete()
      expect(City.all()).to(eq([]))
    end
  end

  describe(".find") do
    it('will find the city by its id') do
      test_city.save()
      test_city2 = City.new({:name => "Houston"})
      test_city2.save()
      expect(City.find(test_city2.id())).to(eq(test_city2))
    end
  end
end
