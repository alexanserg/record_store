require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('create an album path', {:type => :feature}) do
  it('creates an album and then goes to the album page') do
    visit('/albums')
    click_on('Add a new album')
    fill_in('album_name', :with => 'Yellow Submarine')
    click_on('Go!')
    expect(page).to have_content('Yellow Submarine')
  end
end

describe('create a song path', {:type => :feature}) do
  it('creates an album and then goes to the album page') do
    album = Album.new("Yellow Submarine", 1960, ["Rock"], "The Beatles", nil)
    album.save
    visit("/albums/#{album.id}")
    fill_in('song_name', :with => 'All You Need Is Love')
    click_on('Add song')
    expect(page).to have_content('All You Need Is Love')
  end
end

describe('visit home page', {:type => :feature}) do
  it('loads the home page with a list of albums') do
    visit('/')
    expect(page).to have_content('All Sales Vinyl')
    expect(page).to have_content('Available Records')
    expect(page).to have_content('Blue')
  end
end


describe('Search for an album by name', {:type => :feature}) do
  it("finds an album by page and displays the results") do
    album = Album.new("Dookie", 1993, ["Punk"], "Green Day", nil)
    album.save
    visit('/albums/search')
    fill_in('album_name', :with => 'Dookie')
    click_on('Go!')
    expect(page). to have_content('Green Day')
  end
end
