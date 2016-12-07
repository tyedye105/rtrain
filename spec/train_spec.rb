require('rspec')
require('train')
require('pg')

DB = PG.connect({:dbname => "test_train"})

RSpec.configure do |config|
 config.after(:each) do
   DB.exec("DELETE FROM trains *;")
   DB.exec("DELETE FROM cities *;")
 end
end

test_train = Train.new({:name => "MAX", :city_id => 'NULL', :id => 'NULL', :times => 'NULL'})

describe(Train) do
  describe('#name') do
    it('tells rider a name of the train') do
      expect(test_train.name()).to(eq("MAX"))
    end
  end
  describe('.all') do
    it('is empty at first') do
      expect(Train.all()).to(eq([]))
    end
  end
  describe('#save') do
    it('saves the train into the database') do
      test_train.save()
      expect(Train.all()).to(eq([test_train]))
    end
  end
  describe('#==') do
    it('will return the trains are the same if they share name, and id') do
      test_train
      test_train2 = Train.new({:name => "MAX", :city_id => "NULL", :id => "NULL", :times => "NULL" })
      expect(test_train).to(eq(test_train2))
    end
  end
end
