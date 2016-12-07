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
      city_id = train.fetch("train_id")
      id = train.fetch("id")
      times = train.fetch("times")
      trains.push(Train.new({:name => name, :city_id => city_id, :id => id, :times => times}))
    end
    trains
  end  
end
