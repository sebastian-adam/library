require('spec_helper')

describe(Book) do
  describe('.all') do
    it('starts off as an empty array') do
      expect(Book.all()).to(eq([]))
    end
  end

  describe('#title') do
    it('returns the title of a given book') do
      book1 = Book.new({:id => nil, :title => 'Alice in Wonderland', :author_first => 'Lewis', :author_last => 'Carroll', :genre => 'fantasy'})
      expect(book1.title()).to(eq('Alice in Wonderland'))
    end
  end

  describe('#author_first') do
    it('returns the author_first of a given book') do
      book1 = Book.new({:id => nil, :title => 'Alice in Wonderland', :author_first => 'Lewis', :author_last => 'Carroll', :genre => 'fantasy'})
      expect(book1.author_first()).to(eq('Lewis'))
    end
  end

  describe('#author_last') do
    it('returns the author_last of a given book') do
      book1 = Book.new({:id => nil, :title => 'Alice in Wonderland', :author_first => 'Lewis', :author_last => 'Carroll', :genre => 'fantasy'})
      expect(book1.author_last()).to(eq('Carroll'))
    end
  end

  describe('#genre') do
    it('returns the genre of a given book') do
      book1 = Book.new({:id => nil, :title => 'Alice in Wonderland', :author_first => 'Lewis', :author_last => 'Carroll', :genre => 'fantasy'})
      expect(book1.genre()).to(eq('fantasy'))
    end
  end

  describe('#==') do
    it('is the same book if it has the same attributes') do
      book1 = Book.new({:id => nil, :title => 'Alice in Wonderland', :author_first => 'Lewis', :author_last => 'Carroll', :genre => 'fantasy'})
      book2 = Book.new({:id => nil, :title => 'Alice in Wonderland', :author_first => 'Lewis', :author_last => 'Carroll', :genre => 'fantasy'})
      expect(book1).to(eq(book2))
    end
  end

  describe('#save') do
    it('lets you save the Book object to the database') do
      book1 = Book.new({:id => nil, :title => 'Alice in Wonderland', :author_first => 'Lewis', :author_last => 'Carroll', :genre => 'fantasy'})
      book1.save()
      expect(Book.all()).to(eq([book1]))
    end
  end

  describe('#id') do
    it('returns the id of a given book') do
      book1 = Book.new({:id => nil, :title => 'Alice in Wonderland', :author_first => 'Lewis', :author_last => 'Carroll', :genre => 'fantasy'})
      book1.save()
      expect(book1.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe('.find') do
    it('returns a book by its id') do
      book1 = Book.new({:id => nil, :title => 'Alice in Wonderland', :author_first => 'Lewis', :author_last => 'Carroll', :genre => 'fantasy'})
      book1.save()
      book2 = Book.new({:id => nil, :title => 'Invisible Man', :author_first => 'Ralph', :author_last => 'Ellison', :genre => 'social commentary'})
      book2.save()
      expect(Book.find(book1.id())).to(eq(book1))
    end
  end

  # describe('#update') do
  #   it('lets user update a book in the database') do
  #     book1 = Book.new({:id => nil, :title => 'Alice in Wonderland', :author_first => 'Lewis', :author_last => 'Carroll', :genre => 'fantasy'})
  #     book1.save()
  #     book1.update({:title => 'Through the Looking Glass', :genre => 'kids'})
  #     expect(book1.title()).to(eq('Through the Looking Glass'))
  #     expect(book1.genre()).to(eq('kids'))
  #   end
  # end

end
