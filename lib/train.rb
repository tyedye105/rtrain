class Train
  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes[:id]
  end

  define_singleton_method(:all) do
    returned_trains = DB.exec("SELECT * FROM trains;")
    trains = []
    returned_trains.each do |train|
      name = train.fetch("name")
      id = train.fetch("id").to_i()
      trains.push(Train.new({:name => name, :id => id}))
    end
    trains
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO trains (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_train|
    self.name().==(another_train.name())
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    DB.exec("UPDATE trains SET name = '#{@name}' WHERE id = #{self.id()};")

    attributes.fetch(:city_ids, []).each() do |city_id|
      DB.exec("INSERT INTO stops (train_ids, city_ids) VALUES (#{self.id()}, #{city_id})")
  end
end

  define_method(:cities) do
    service_in = []
    results = DB.exec("SELECT city_ids FROM stops WHERE train_ids = #{self.id()}")
    results.each() do |result|
      city_id = result.fetch('city_ids').to_i()
      city = DB.exec("SELECT * FROM cities WHERE id = #{city_id}")
      name = city.first().fetch("name")
      service_in.push(City.new({:name => name, :id => city_id}))
    end
    service_in
  end

  define_method(:delete) do
    DB.exec("DELETE FROM stops WHERE train_ids = #{self.id()};")
    DB.exec("DELETE FROM trains WHERE id = #{self.id()};")
  end

  define_singleton_method(:find) do |train_id|
    found_train = nil
    Train.all.each() do |train|
      if train.id().eql?(train_id)
        found_train = train
      end
    end
  found_train
  end
end
