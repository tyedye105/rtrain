require('spec_helper')

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
   it('will allow you to add a city that the trains stops in')do
     test_train.save()
     new_city =City.new({:name => "Houston"})
     new_city.save()
     test_train.update({:city_ids => [new_city.id()]})
     expect(test_train.cities()).to(eq([new_city]))
   end
  end

describe('#cities') do
  it('display cities the train stops in.')do
    test_train.save()
    new_city =City.new({:name => "Houston"})
    new_city.save()
    new_city2 =City.new({:name => "Mega City 1"})
    new_city2.save()
    test_train.update({:city_ids => [new_city.id(), new_city2.id()]})
    expect(test_train.cities()).to(eq([new_city, new_city2]))
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
