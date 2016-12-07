require('rspec')
require('train')

test_train = Train.new({:name => "MAX", :city_id => nil, :id => nil, :times => nil})


describe(Train) do
  describe('#name') do
    it('tells rider a name of the train') do
      expect(test_train.name()).to(eq("MAX"))
    end
  end
end