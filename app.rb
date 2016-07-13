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

# get('/books/:id') do
#   @book = Book.find(params.fetch('id').to_i())
#   erb(:book)
# end

get('/books/:id/edit') do
  @book = Book.find(params.fetch('id').to_i())
  erb(:book_edit)
end

patch('/books/:id') do
  title = params.fetch('title')
  author_last = params.fetch('author_last')
  author_first = params.fetch('author_first')
  genre = params.fetch('genre')
  @book = Book.find(params.fetch('id').to_i())
  @book.update({:title => title, :author_first => author_first, :author_last => author_last, :genre => genre})
  @books = Book.all()
  erb(:index)
end

delete('/books/:id') do
  @book = Book.find(params.fetch('id').to_i())
  @book.delete()
  @books = Book.all()
  erb(:index)
end

post('/search/title') do
  title = params.fetch('title')
  @search_term = title
  @search_results = Book.search_title(title)
  erb(:search_results)
end

post('/search/author') do
  author_last = params.fetch('author_last')
  @search_term = author_last
  @search_results = Book.search_author(author_last)
  erb(:search_results)
end
