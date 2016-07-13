class Book
  attr_reader(:id, :title, :author_first, :author_last, :genre)

  define_method(:initialize) do |attributes|
    @id = attributes.fetch(:id)
    @title = attributes.fetch(:title)
    @author_first = attributes.fetch(:author_first)
    @author_last = attributes.fetch(:author_last)
    @genre = attributes.fetch(:genre)
  end

  define_singleton_method(:all) do
    returned_books = DB.exec("SELECT * FROM books ORDER BY author_last ASC;")
    books = []
    returned_books.each() do |book|
      id = book.fetch('id').to_i
      title = book.fetch('title')
      author_first = book.fetch('author_first')
      author_last = book.fetch('author_last')
      genre = book.fetch('genre')
      books.push(Book.new({:id => id, :title => title, :author_first => author_first, :author_last => author_last, :genre => genre}))
    end
    books
  end

  define_method(:==) do |another_book|
    self.id().==(another_book.id()).&(self.title().==(another_book.title())).&(self.author_first().==(another_book.author_first())).&(self.author_last().==(another_book.author_last())).&(self.genre().==(another_book.genre()))
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO books (title, author_first, author_last, genre) VALUES ('#{@title}', '#{@author_first}', '#{@author_last}', '#{@genre}') RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  define_singleton_method(:find) do |id|
    found_book = nil
    Book.all().each() do |book|
      if book.id().==(id)
        found_book = book
      end
    end
    found_book
  end

  define_singleton_method(:search_title) do |keyword|
    found_books = []
    found_book = nil
    Book.all().each() do |book|
      if book.title().==(keyword)
        found_book = book
        found_books.push(book)
      end
    end
    found_books
  end

  define_singleton_method(:search_author) do |keyword|
    found_books = []
    found_book = nil
    Book.all().each() do |book|
      if book.author_last().==(keyword)
        found_book = book
        found_books.push(book)
      end
    end
    found_books
  end

  define_method(:update) do |attributes|
    @id = self.id()
    @title = attributes.fetch(:title)
    @author_first = attributes.fetch(:author_first)
    @author_last = attributes.fetch(:author_last)
    @genre = attributes.fetch(:genre)
    DB.exec("UPDATE books SET title = '#{@title}', author_last = '#{@author_last}', author_first = '#{@author_first}', genre = '#{@genre}' WHERE id = #{@id};")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM books WHERE id = #{self.id()};")
  end

end
