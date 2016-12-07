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

test_train = Train.new({:name => "MAX"})

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
    it('will return the trains are the same if they share name') do
      test_train
      test_train2 = Train.new({:name => "MAX"})
      expect(test_train).to(eq(test_train2))
    end
  end
  describe('#update') do
   it('updates the trains in the database') do
     test_train.save()
     test_train.update({:name => "C-Tran"})
     expect(test_train.name()).to(eq("C-Tran"))
   end
  end
  describe('#delete') do
    it('deletes the trains from the database') do
      test_train.save()
      test_train.delete()
      expect(Train.all()).to(eq([]))
    end
  end
  describe('.find') do
    it("search for train by its id number and return the matching train")do
    test_train.save()
    test_train2 = Train.new(:name => "Coal-train")
    test_train2.save()
    expect(Train.find(test_train2.id())).to(eq(test_train2))

    end
  end
end
