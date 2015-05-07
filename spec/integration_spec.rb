require('spec_helper')
require('./app')
Capybara.app=Sinatra::Application
set(:show_exceptions, false)

describe('the path to adding an actor', {:type => :feature}) do
  it('allows a user to add an actor to the database') do
    visit('/')
    click_link("Go to the actors page.")
    fill_in('name', :with => 'James Stewart')
    click_button('Submit')
    expect(page).to have_content("James Stewart")
  end
end

describe('the path to updating a movie', {:type => :feature}) do
  it('allows a user to update a movie') do
    actor = Actor.new(:name => 'Sylvester Stallone', :id => nil)
    actor.save()
    visit('/')
    click_link("Go to the movies page.")
    fill_in('name', :with => 'Rambo')
    click_button('Submit')
    click_link('Rambo')
    check('Sylvester Stallone')
    click_button('Add actor or actress')
    expect(page).to have_content("This is the page for Rambo")
  end
end
