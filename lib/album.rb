class Album
  attr_accessor :id, :name #Our new save method will need reader methods.

  @@albums = {}
  @@total_rows = 0 # We've added a class variable to keep track of total rows and increment the value when an ALbum is added.

  def initialize(name, id) # We've added id as a second parameter.
    @name = name
    @id = id || @@total_rows += 1  # We've added code to handle the id.
  end

  def self.all
    @@albums.values()
  end

  def save
    @@albums[self.id] = Album.new(self.name, self.id)
  end

  def ==(album_to_compare)
    @name == album_to_compare.name()
  end

  def self.clear
    @@albums = {}
    @@total_rows = 0
  end

  def self.find(id)
    @@albums.fetch(id.to_i)
  end

  def update(name)
    self.name = name
    @@albums[@id] = Album.new(self.name, @id)
  end

  def delete
    @@albums.delete(@id)
  end

end
