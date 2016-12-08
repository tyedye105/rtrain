require('rspec')
require('pg')
require('Train')
require('city')


DB = PG.connect({:dbname => "test_trains"})

RSpec.configure do |config|
 config.after(:each) do
   DB.exec("DELETE FROM trains *;")
   DB.exec("DELETE FROM cities *;")
 end
end
