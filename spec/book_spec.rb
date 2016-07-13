require('spec_helper')

describe(Book) do
  describe('.all') do
    it('starts off as an empty array') do
      expect(Book.all()).to(eq([]))
    end
  end
end
