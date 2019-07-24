require('sinatra')
require('sinatra/reloader')
require('./lib/album')
require('./lib/song')
require('pry')
also_reload('lib/**/*.rb')

Album.clear()
Album.new("Giant Steps", 1960, ["Jazz"], "John Coltrane").save()
Album.new("Blue", 1971, ["Folk rock", "Pop"], "Joni Mitchell").save()
Album.new("Green", 1972, ["Acid Jazz"], "Joni Mitchell").save()
Song.clear()

get ('/') do
  @albums = Album.all
  erb(:albums)
end

get ('/albums') do
  @albums = Album.all
  erb(:albums)
end

get ('/sold_albums') do
  @sold_albums = Album.all_sold
  erb(:sold_albums)
end

get ('/albums/new') do
  "This will take us to a page with a form for adding a new album."
  erb(:new_album)
end

get('/albums/search') do
  erb(:albums_search)
end

get ('/custom_route') do
  "We can even create custom routes, but we should only do this when needed."
end

get ('/albums/:id') do
  "This route will show a specific album based on its ID. The value of ID here is #{params[:id]}."
  @album = Album.find(params[:id].to_i())
  erb(:album)
end

get ('/albums/:id/edit') do
  @album = Album.find(params[:id].to_i())
  erb(:edit_album)
end

get('/albums/:id/songs/:song_id') do
  @song = Song.find(params[:song_id].to_i())
  erb(:song)
end

post ('/albums') do
  name, year, genres, artist = params.values
  genres = genres.split(/, /)
  album = Album.new(name, year, genres, artist, nil)
  album.save()
  @albums = Album.all()
  erb(:albums)
end

post('/find_album') do
  name = params[:album_name]
  @albums = Album.find_by_name(name)
  # @albums = Album.all
  erb(:search_results)
end

post('/albums/:id/songs') do
  @album = Album.find(params[:id].to_i())
  song = Song.new(params[:song_name], @album.id, nil)
  song.save()
  erb(:album)
end

post ('/buy/:id') do
  @album = Album.find(params[:id].to_i)
  @album.sold()
  redirect to ('/sold_albums')
end

patch ('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  @album.update(params[:name], params[:year].to_i)
  @albums = Album.all
  erb(:albums)
end

patch('/albums/:id/songs/:song_id') do
  @album = Album.find(params[:id].to_i())
  song = Song.find(params[:song_id].to_i())
  song.update(params[:name], @album.id)
  erb(:album)
end

delete ('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  @album.delete()
  @albums = Album.all
  erb(:albums)
end

delete('/albums/:id/songs/:song_id') do
  song = Song.find(params[:song_id].to_i())
  song.delete
  @album = Album.find(params[:id].to_i())
  erb(:album)
end
