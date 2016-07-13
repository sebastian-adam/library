require('sinatra')
require('sinatra/reloader')
require('./lib/book')
require('pg')
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => 'library_test'})

get('/') do
  @books = Book.all()
  erb(:index)
end

post('/books') do
  title = params.fetch('title')
  author_last = params.fetch('author_last')
  author_first = params.fetch('author_first')
  genre = params.fetch('genre')
  book = Book.new({:id => nil, :title => title, :author_last => author_last, :author_first => author_first, :genre => genre})
  book.save()
  @books = Book.all()
  erb(:index)
end
