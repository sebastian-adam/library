require('sinatra')
require('sinatra/reloader')
require('./lib/book')
require('./lib/patron')
require('./lib/checkout')
require('pg')
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => 'library_test'})

get('/') do
  @books = Book.all()
  @@librarian = false
  erb(:index)
end

get('/librarian') do
  @books = Book.all()
  @checkouts = Checkout.all()
  @@librarian = true
  erb(:librarian)
end

get('/patrons/:id') do
  @books = Book.all()
  @patron = Patron.find(params.fetch('id').to_i())
  @@patron = true
  erb(:patron)
end

post('/patrons') do
  first_name = params.fetch('first_name')
  last_name = params.fetch('last_name')
  phone_num = params.fetch('phone_num')
  if Patron.confirm_by_all?(first_name, last_name, phone_num)
    @id = Patron.find_id_by_all(first_name, last_name, phone_num)
    @patron = Patron.find(@id)
    @header = "Welcome back"
  else
    @patron = Patron.new({:id => nil, :first_name => first_name, :last_name => last_name, :phone_num => phone_num})
    @patron.save()
    @header = "Welcome"
  end
  @books = Book.all()
  @checkouts = Checkout.all()
  erb(:patron)
end

post('/books') do
  title = params.fetch('title')
  author_last = params.fetch('author_last')
  author_first = params.fetch('author_first')
  genre = params.fetch('genre')
  book = Book.new({:id => nil, :title => title, :author_last => author_last, :author_first => author_first, :genre => genre})
  book.save()
  @books = Book.all()
  @checkouts = Checkout.all()
  if @@librarian == true
    erb(:librarian)
  else
    erb(:index)
  end
end

# get('/books/:id') do
#   @book = Book.find(params.fetch('id').to_i())
#   erb(:book)
# end

get('/books/:id/edit') do
  @book = Book.find(params.fetch('id').to_i())
  erb(:book_edit)
end

get('/patrons/:patron_id/books/:book_id/checkout') do
  @patron = Patron.find(params.fetch('patron_id').to_i())
  @book = Book.find(params.fetch('book_id').to_i())
  erb(:checkout_form)
end

post('/patrons/:patron_id/books/:book_id/checkout') do
  date = params.fetch('date')
  @patron = Patron.find(params.fetch('patron_id').to_i())
  patrons_id = @patron.id()
  @book = Book.find(params.fetch('book_id').to_i())
  books_id = @book.id()
  checkout = Checkout.new({:id => nil, :date => date, :due_date => nil, :books_id => books_id, :patrons_id => patrons_id})
  checkout.save()
  @books = Book.all()
  @checkouts = Checkout.all()
  erb(:patron)
end

patch('/books/:id') do
  title = params.fetch('title')
  author_last = params.fetch('author_last')
  author_first = params.fetch('author_first')
  genre = params.fetch('genre')
  @book = Book.find(params.fetch('id').to_i())
  @book.update({:title => title, :author_first => author_first, :author_last => author_last, :genre => genre})
  @books = Book.all()
  @checkouts = Checkout.all()
  if @@librarian == true
    erb(:librarian)
  else
    erb(:index)
  end
end

delete('/books/:id') do
  @book = Book.find(params.fetch('id').to_i())
  @book.delete()
  @books = Book.all()
  @checkouts = Checkout.all()
  if @@librarian == true
    erb(:librarian)
  else
    erb(:index)
  end
end

delete('/checkouts/:id') do
  @checkout = Checkout.find(params.fetch('id').to_i())
  @checkout.delete()
  @checkouts = Checkout.all()
  @books = Book.all()
  if @@librarian == true
    erb(:librarian)
  else
    erb(:index)
  end
end

post('/search/title') do
  title = params.fetch('title_search')
  @search_term = title
  @search_results = Book.find_by_title(title)
  erb(:search_results)
end

post('/search/author') do
  author_last = params.fetch('author_last_search')
  @search_term = author_last
  @search_results = Book.find_by_author(author_last)
  erb(:search_results)
end
