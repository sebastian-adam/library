require('capybara/rspec')
require('./app')
require('spec_helper')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('view the book path', {:type => :feature}) do
  it('shows no books when there are no books in the database') do
    visit('/')
    expect(page).to have_content('There are no books in the databse.')
  end

  it('Shows the user a table of books when there are books in the database') do
    book1 = Book.new({:id => nil, :title => 'Alice in Wonderland', :author_first => 'Lewis', :author_last => 'Carroll', :genre => 'fantasy'})
    book1.save()
    visit('/')
    expect(page).to have_content('Alice in Wonderland Carroll, Lewis fantasy')
  end
end
