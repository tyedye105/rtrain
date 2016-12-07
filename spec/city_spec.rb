require('rspec')
require('city')
require('pg')


RSpec.configure do |config|
 config.after(:each) do
   DB.exec("DELETE FROM trains *;")
   DB.exec("DELETE FROM cities *;")
 end
end

test_city = City.new({:name => "PDX", :train_id => 'NULL', :id => 'NULL'})

describe(City) do
  describe("#initialize") do
    it('will create a new City with name, and array of all the train_ids') do
      expect(test_city.name()).to(eq('PDX'))
      expect(test_city.id()).to(eq('NULL'))
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
      test_city2 = City.new({:name => "PDX", :train_id => 'NULL', :id => "NULL"})
      expect(test_city.name()).to(eq(test_city2.name))
    end
  end
    describe("#save") do
      it('will save the city in to the cities database') do
        test_city.save()
        test_city2 = City.new({:name => "PDX", :train_id => 'NULL', :id => "NULL"})
        test_city2.save()
        expect(City.all()).to(eq([test_city, test_city2]))
      end
    end
end
