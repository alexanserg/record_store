require('sinatra')
require('sinatra/reloader')
require('./lib/album')
require('pry')
also_reload('lib/**/*.rb')

get ('/') do
  @albums = Album.all
  erb(:albums)
end

get ('/albums') do
  @albums = Album.all
  erb(:albums)
end

get ('/albums/new') do
  "This will take us to a page with a form for adding a new album."
  erb(:new_album)
end

# get ('/albums/:id') do
#   "This route will show a specific album based on its ID. The value of ID here is #{params[:id]}."
#   @album = Album.find(params[:id].to_i())
#   erb(:album)
# end

post ('/albums') do
  name, year, genres, artist = params.values
  genres = genres.split(/, /)
  album = Album.new(name, year, genres, artist, nil)
  album.save()
  @albums = Album.all()
  erb(:albums)
end

get ('/albums/:id/edit') do
  @album = Album.find(params[:id].to_i())
  erb(:edit_album)
end

get('/albums/search') do
  erb(:albums_search)

end

post('/albums_search') do
  name = params[:album_name]
  @albums = Album.find_by_name(name)
  # @albums = Album.all
  erb(:search_results)
end

delete ('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  @album.delete()
  @albums = Album.all
  erb(:albums)
end

get ('/custom_route') do
  "We can even create custom routes, but we should only do this when needed."
end

patch ('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  @album.update(params[:name])
  @albums = Album.all
  erb(:albums)
end
