require('spec_helper')

describe(Patron) do
  describe('.all') do
    it('starts off as an empty array') do
      expect(Patron.all()).to(eq([]))
    end
  end

  describe('#first_name') do
    it('returns the first_name of a given patron') do
      patron1 = Patron.new({:id => nil, :first_name => 'Alice', :last_name => 'Lewis', :phone_num => '5552349876', :books_id => 1})
      expect(patron1.first_name()).to(eq('Alice'))
    end
  end

  describe('#last_name') do
    it('returns the last_name of a given patron') do
      patron1 = Patron.new({:id => nil, :first_name => 'Alice', :last_name => 'Lewis', :phone_num => '5552349876', :books_id => 1})
      expect(patron1.last_name()).to(eq('Lewis'))
    end
  end

  describe('#phone_num') do
    it('returns the phone_num of a given patron') do
      patron1 = Patron.new({:id => nil, :first_name => 'Alice', :last_name => 'Lewis', :phone_num => '5552349876', :books_id => 1})
      expect(patron1.phone_num()).to(eq('5552349876'))
    end
  end

  describe('#==') do
    it('is the same patron if it has the same attributes') do
      patron1 = Patron.new({:id => nil, :first_name => 'Alice', :last_name => 'Lewis', :phone_num => '5552349876', :books_id => 1})
      patron2 = Patron.new({:id => nil, :first_name => 'Alice', :last_name => 'Lewis', :phone_num => '5552349876', :books_id => 1})
      expect(patron1).to(eq(patron2))
    end
  end

  describe('#save') do
    it('lets you save the Patron object to the database') do
      patron1 = Patron.new({:id => nil, :first_name => 'Alice', :last_name => 'Lewis', :phone_num => '5552349876', :books_id => 1})
      patron1.save()
      expect(Patron.all()).to(eq([patron1]))
    end
  end

  describe('#id') do
    it('returns the id of a given patron') do
      patron1 = Patron.new({:id => nil, :first_name => 'Alice', :last_name => 'Lewis', :phone_num => '5552349876', :books_id => 1})
      patron1.save()
      expect(patron1.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe('.find') do
    it('returns a patron by its id') do
      patron1 = Patron.new({:id => nil, :first_name => 'Alice', :last_name => 'Lewis', :phone_num => '5552349876', :books_id => 1})
      patron1.save()
      patron2 = Patron.new({:id => nil, :first_name => 'Ben', :last_name => 'Christian', :phone_num => '5552387876', :books_id => 2})
      patron2.save()
      expect(Patron.find(patron1.id())).to(eq(patron1))
    end
  end

end
