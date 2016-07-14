class Checkout
  attr_reader(:id, :date, :books_id, :patrons_id)

  define_method(:initialize) do |attributes|
    @id = attributes.fetch(:id)
    @date = attributes.fetch(:date)
    @books_id = attributes.fetch(:books_id)
    @patrons_id = attributes.fetch(:patrons_id)
  end

  define_singleton_method(:all) do
    returned_checkouts = DB.exec("SELECT * FROM checkouts ORDER BY date ASC;")
    checkouts = []
    returned_checkouts.each() do |checkout|
      id = checkout.fetch('id').to_i
      date = checkout.fetch('date')
      books_id = checkout.fetch('books_id').to_i
      patrons_id = checkout.fetch('patrons_id').to_i
      checkouts.push(Checkout.new({:id => id, :date => date, :books_id => books_id, :patrons_id => patrons_id}))
    end
    checkouts
  end

  define_method(:==) do |another_checkout|
    self.id().==(another_checkout.id()).&(self.date().==(another_checkout.date())).&(self.books_id().==(another_checkout.books_id())).&(self.patrons_id().==(another_checkout.patrons_id()))
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO checkouts (date, books_id, patrons_id) VALUES ('#{@date}', '#{@books_id}', '#{@patrons_id}') RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  define_singleton_method(:find) do |id|
    found_checkout = nil
    Checkout.all().each() do |checkout|
      if checkout.id().==(id)
        found_checkout = checkout
      end
    end
    found_checkout
  end

  define_method(:delete) do
    DB.exec("DELETE FROM checkouts WHERE id = #{self.id()};")
  end

  define_method(:due) do
    DB.exec("SELECT #{self.date()}, DATEADD(dd, 14, #{self.date()}) AS DueDate FROM checkouts WHERE id = #{self.id()};")
  end

end
