class Album
  attr_accessor :id, :name, :year, :genres, :artist #Our new save method will need reader methods.

  @@albums = {}
  @@total_rows = 0 # We've added a class variable to keep track of total rows and increment the value when an ALbum is added.

  def initialize(name, year, genres, artist, id = nil) # We've added id as a second parameter.
    @name = name
    @year = year
    @genres = genres
    @artist = artist
    @id = id || @@total_rows += 1  # We've added code to handle the id.
  end

  def self.all
    @@albums.values()
  end

  def save
    # @@albums[self.id] = Album.new(self.name, self.year, self.genres, self.artist, self.id)
    @@albums[self.id] = self
    Album.sort()
  end

  def == (album_to_compare)
    @name == album_to_compare.name()
    @year == album_to_compare.year()
    @genres == album_to_compare.genres()
    @artist == album_to_compare.artist()
  end

  def sold

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

  def update(name)
    self.name = name
    # @@albums[@id] = Album.new(self.name, self.year, self.genres, self.artist, @id)
  end

  def delete
    @@albums.delete(@id)
  end

end
