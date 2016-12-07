class Train
  attr_reader(:name, :city_id, :id, :times)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @city_id = attributes.fetch(:city_id)
    @id = attributes.fetch(:id)
    @times = attributes.fetch(:times)
  end

  define_singleton_method(:all) do
    returned_trains = DB.exec("SELECT * FROM trains;")
    trains = []
    returned_trains.each do |train|
      name = train.fetch("name")
      city_id = train.fetch("city_id").to_i()
      id = train.fetch("id").to_i()
      times = train.fetch("times")
      trains.push(Train.new({:name => name, :city_id => city_id, :id => id, :times => times}))
    end
    trains
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO trains (name, city_id, times) VALUES ('#{@name}',#{@city_id or "NULL"},#{@times or "NULL"}) RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_train|
    self.name().==(another_train.name())
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name)
    @id = self.id()
    DB.exec("UPDATE trains SET name = '#{@name}' WHERE id = #{@id};")
  end

  define_method(:delete) do
    @id = self.id()
    DB.exec("DELETE FROM trains WHERE id = #{self.id()};")
  end
end
