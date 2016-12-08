class City
  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes[:id]
  end

  define_singleton_method(:all) do
    returned_cities = DB.exec("SELECT * FROM cities;")
    cities = []
    returned_cities.each() do |city|
      name = city.fetch("name")
      id = city.fetch("id").to_i()
      cities.push(City.new({:name => name, :id => id}))
    end
    cities
  end

  define_method(:==) do |another_city|
  name().==(another_city.name()).&(self.id().==(another_city.id()))
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO cities (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    DB.exec("UPDATE cities SET name = '#{@name}' WHERE id = #{self.id()};")

    attributes.fetch(:train_ids, []).each() do |train_id|
      DB.exec("INSERT INTO stops (city_ids, train_ids) VALUES (#{self.id()}, #{train_id});")
    end
  end

  define_method(:trains) do
    active_trains = []
    results = DB.exec("SELECT train_ids FROM stops WHERE city_ids = #{self.id()};")
    results.each() do |result|
      train_id = result.fetch('train_ids').to_i()
      train = DB.exec("SELECT * FROM trains WHERE id = #{train_id};")
      train_name = train.first().fetch('name')
      active_trains.push(Train.new({:name => train_name, :id => train_id}))
  end
  active_trains
end

  define_method(:delete) do
    DB.exec("DELETE FROM cities WHERE id = #{@id};")
  end

  define_singleton_method(:find) do |city_id|
    found_city = nil
    City.all.each() do |city|
      if city.id().eql?(city_id)
        found_city = city
      end
    end
    found_city
  end
end
