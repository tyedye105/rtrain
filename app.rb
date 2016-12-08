require('sinatra')
require('sinatra/reloader')
require('pry')
require('pg')
require('./lib/train')
require('./lib/city')
require('capybara')
also_reload('lib/**/*.rb')

get("/") do
  @trains = Train.all()
  @cities = City.all()
  erb(:index)
end

get("/add_train") do
  erb(:train_form)
end

post("/added_train") do
  train_name = params.fetch('train_name')
  new_train = Train.new({:name => train_name})
  new_train.save()
  erb(:index)
end
