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
      name = city.fetch("name")
      id = city.fetch("id").to_i()
      train_id = city.fetch("train_id")
      cities.push(City.new({:name => name, :train_id => train_id, :id => id}))
    end
    cities
  end

  define_method(:==) do |another_city|
  name().==(another_city.name()).&(self.id().==(another_city.id()))
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO cities (name, train_id) VALUES ('#{@name}', #{@train_id or "NULL"}) RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end
end
