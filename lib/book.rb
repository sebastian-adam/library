class Book
  attr_reader(:id, :title, :author, :genre)


  define_method(:initalize) do |attributes|
    @id = attributes.fetch(:id)
    @title = attributes.fetch(:title)
    @autor = attributes.fetch(:author)
    @genre = attributes.fetch(:genre)
  end

  define_singleton_method(:all) do
    returned_books = DB.exec('SELECT * FROM books ORDER BY author ASC;')
    books = []
    returned_books.each() do |book|
      id = book.fetch('id').to_i
      title = book.fetch('title')
      author = book.fetch('author')
      genre = book.fetch('genre')
      books.push(Book.new({:id => id, :title => title, :author => author, :genre => genre}))
    end
    books
  end

end
