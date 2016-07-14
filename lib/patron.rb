class Patron
  attr_reader(:id, :first_name, :last_name, :phone_num)

  define_method(:initialize) do |attributes|
    @id = attributes.fetch(:id)
    @first_name = attributes.fetch(:first_name)
    @last_name = attributes.fetch(:last_name)
    @phone_num = attributes.fetch(:phone_num)
  end

  define_singleton_method(:all) do
    returned_patrons = DB.exec("SELECT * FROM patrons ORDER BY last_name ASC;")
    patrons = []
    returned_patrons.each() do |patron|
      id = patron.fetch('id').to_i
      first_name = patron.fetch('first_name')
      last_name = patron.fetch('last_name')
      phone_num = patron.fetch('phone_num')
      patrons.push(Patron.new({:id => id, :first_name => first_name, :last_name => last_name, :phone_num => phone_num}))
    end
    patrons
  end

  define_method(:==) do |another_patron|
    self.id().==(another_patron.id()).&(self.first_name().==(another_patron.first_name())).&(self.last_name().==(another_patron.last_name())).&(self.phone_num().==(another_patron.phone_num()))
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO patrons (first_name, last_name, phone_num) VALUES ('#{@first_name}', '#{@last_name}', '#{@phone_num}') RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  define_singleton_method(:find) do |id|
    found_patron = nil
    Patron.all().each() do |patron|
      if patron.id().==(id)
        found_patron = patron
      end
    end
    found_patron
  end

  define_singleton_method(:confirm_by_all?) do |first, last, phone|
    patron_exists = false
    Patron.all().each() do |patron|
      if patron.first_name().==(first).&(patron.last_name().==(last)).&(patron.phone_num().==(phone))
        patron_exists = true
      end
    end
    patron_exists
  end

  define_singleton_method(:find_id_by_all) do |first, last, phone|
    found_patron_id = nil
    Patron.all().each() do |patron|
      if patron.first_name().==(first).&(patron.last_name().==(last)).&(patron.phone_num().==(phone))
        found_patron_id = patron.id()
      end
    end
    found_patron_id
  end

end
