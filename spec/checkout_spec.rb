require('spec_helper')

describe(Checkout) do
  describe('.all') do
    it('starts off as an empty array') do
      expect(Checkout.all()).to(eq([]))
    end
  end

  describe('#date') do
    it('returns the date of a checkout') do
      checkout1 = Checkout.new({:id => nil, :date => '2016-08-07', :books_id => 1, :patrons_id => 1})
      expect(checkout1.date()).to(eq('2016-08-07'))
    end
  end

  describe('#books_id') do
    it('returns the book id of a checkout') do
      checkout1 = Checkout.new({:id => nil, :date => '2016-08-07', :books_id => 1, :patrons_id => 1})
      expect(checkout1.books_id()).to(eq(1))
    end
  end

  describe('#patrons_id') do
    it('returns the patrons id of a checkout') do
      checkout1 = Checkout.new({:id => nil, :date => '2016-08-07', :books_id => 1, :patrons_id => 1})
      expect(checkout1.patrons_id()).to(eq(1))
    end
  end

  describe('#==') do
    it('is the same checkout if it has the same attributes') do
      checkout1 = Checkout.new({:id => nil, :date => '2016-08-07', :books_id => 1, :patrons_id => 1})
      checkout2 = Checkout.new({:id => nil, :date => '2016-08-07', :books_id => 1, :patrons_id => 1})
      expect(checkout1).to(eq(checkout2))
    end
  end

  describe('#save') do
    it('lets you save the checkout object to the database') do
      checkout1 = Checkout.new({:id => nil, :date => '2016-08-07', :books_id => 1, :patrons_id => 1})
      checkout1.save()
      expect(Checkout.all()).to(eq([checkout1]))
    end
  end

  describe('#id') do
    it('returns the id of a given checkout') do
      checkout1 = Checkout.new({:id => nil, :date => '2016-08-07', :books_id => 1, :patrons_id => 1})
      checkout1.save()
      expect(checkout1.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe('.find') do
    it('returns a checkout by its id') do
      checkout1 = Checkout.new({:id => nil, :date => '2016-08-07', :books_id => 1, :patrons_id => 1})
      checkout2 = Checkout.new({:id => nil, :date => '2016-08-07', :books_id => 1, :patrons_id => 1})
      checkout1.save()
      checkout2.save()
      expect(Checkout.find(checkout1.id())).to(eq(checkout1))
    end
  end

  describe('#delete') do
    it('lets user delete a checkout from the database') do
      checkout1 = Checkout.new({:id => nil, :date => '2016-08-07', :books_id => 1, :patrons_id => 1})
      checkout2 = Checkout.new({:id => nil, :date => '2016-08-07', :books_id => 1, :patrons_id => 1})
      checkout1.save()
      checkout2.save()
      checkout1.delete()
      expect(Checkout.all()).to(eq([checkout2]))
    end
  end

# DO SEARCH SPEC
end
