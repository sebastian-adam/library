require('rspec')
require('pg')
require('book')
require('patron')
require('checkout')

DB = PG.connect({:dbname => 'library_test'})

RSpec.configure do |config|
  config.before(:each) do
    DB.exec('DELETE FROM books *;')
    DB.exec('DELETE FROM patrons *;')
    DB.exec('DELETE FROM checkouts *;')
  end
  config.after(:each) do
    DB.exec('DELETE FROM books *;')
    DB.exec('DELETE FROM patrons *;')
    DB.exec('DELETE FROM checkouts *;')
  end
end
