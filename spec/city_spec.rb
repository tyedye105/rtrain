require('rspec')
require('city')
require('pg')

DB = PG.connect({:dbname => "test_train"})

RSpec.configure do |config|
 config.after(:each) do
   DB.exec("DELETE FROM trains *;")
   DB.exec("DELETE FROM cities *;")
 end
end
test_city = City.new({:name => "PDX", :train_id => nil})

describe(City) do
  describe("#initialize") do
    it('will create a new City with name, and array of all the train_ids') do
      expect(test_city.name()).to(eq('PDX'))
      expect(test_city.id()).to(eq(nil))
    end
  end
end
