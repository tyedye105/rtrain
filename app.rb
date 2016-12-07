require('sinatra')
require('sinatra/reloader')
require('pry')
also_reload('lib/**/*.rb')
require('./lib/city')
require('./lib/city')

get("/") do
  erb(:index)
end
