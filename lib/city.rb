class City
  attr_reader(:name, :train_id, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @train_id = attributes.fetch(:train_id)
    @id = attributes[:id]
  end
end
