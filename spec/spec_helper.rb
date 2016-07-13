require('rspec')
require('pg')
require('book')

DB = PG.connect({:dbname => 'library_test'})

RSpec.configure do |config|
  config.before(:each) do
    DB.exec('DELETE FROM books *;')
  end
  config.after(:each) do
    DB.exec('DELETE FROM books *;')
  end
end
