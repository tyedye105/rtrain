class City
  attr_reader(:name, :train_id, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @train_id = attributes.fetch(:train_id)
    @id = attributes[:id]
  end

  define_singleton_method(:all) do
    returned_cities = DB.exec("SELECT * FROM cities;")
    cities = []
    returned_cities.each() do |city|
      name = city.name()
      id = city.id()
      train_id = city.train_id()
      cities_list.push(City.new({:name => name, :train_id => train_id, :id => id}))
    end
    cities
  end
end
