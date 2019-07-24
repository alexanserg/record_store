# require 'song'

class Album
  attr_accessor :id, :name, :year, :genres, :artist #Our new save method will need reader methods.

  @@albums = {}
  @@sold_albums = {}
  @@total_rows = 0 # We've added a class variable to keep track of total rows and increment the value when an ALbum is added.

  def initialize(name, year=nil, genres=nil, artist=nil, id = nil) # We've added id as a second parameter.
    @name = name
    @year = year
    @genres = genres
    @artist = artist
    @id = id || @@total_rows += 1  # We've added code to handle the id.
  end

  def self.all
    @@albums.values()
  end

  def self.all_sold
    @@sold_albums.values()
  end

  def save
    @@albums[self.id] = Album.new(self.name, self.year, self.genres, self.artist, self.id)
    Album.sort()
  end

  def == (album_to_compare)
    @name == album_to_compare.name()
    @year == album_to_compare.year()
    @genres == album_to_compare.genres()
    @artist == album_to_compare.artist()
  end

  def sold
    @@sold_albums[self.id] = self
    self.delete()
  end

  def self.clear
    @@albums = {}
    @@total_rows = 0
  end

  def self.find_by_name(name)
    @@albums.select do |id, album|
      album.name == name
    end
  end

  def self.find(id)
    @@albums.fetch(id.to_i)
  end

  def self.sort()
    sorted_albums = @@albums.sort_by { |id, album| album.name.downcase }
    @@albums = sorted_albums.to_h
  end

  def update(new_name, new_year)
    self.name = new_name
    self.year = new_year
    @@albums[@id] = Album.new(self.name, self.year, self.genres, self.artist, @id)
  end

  def delete
    @@albums.delete(@id)
  end

  def songs
    Song.find_by_album(self.id)
  end
end
