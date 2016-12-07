class Train
  attr_reader(:name, :city_id, :id, :times)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @city_id = attributes.fetch(:city_id)
    @id = attributes.fetch(:id)
    @times = attributes.fetch(:times)
  end
end
