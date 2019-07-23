require 'rspec'
require 'pry'
require 'album'

describe '#Album' do

  before(:each) do
    Album.clear()
  end

  describe('.all') do
    it("returns an empty array when there are no albums") do
      expect(Album.all).to(eq([]))
    end
  end

  describe('#save') do
    it("saves an album and sorts all saved albums") do
      album = Album.new("Giant Steps", 1960, ["Jazz"], "John Coltrane") # nil added as second argument
      album.save()
      album2 = Album.new("Blue", 1971, ["Folk rock", "Pop"], "Joni Mitchell") # nil added as second argument
      album2.save()
      expect(Album.all).to(eq([album2, album]))
    end
  end

  describe('#==') do
    it("is the same album if it has the same attributes as another album") do
      album = Album.new("Blue", 1971, ["Folk rock", "Pop"], "Joni Mitchell")
      album2 = Album.new("Blue", 1971, ["Folk rock", "Pop"], "Joni Mitchell", nil)
      expect(album).to(eq(album2))
    end
  end

  describe('.clear') do
    it("clears all albums") do
      album = Album.new("Giant Steps", 1960, ["Jazz"], "John Coltrane")
      album.save()
      album2 = Album.new("Blue", 1971, ["Folk rock", "Pop"], "Joni Mitchell")
      album2.save()
      Album.clear()
      expect(Album.all).to(eq([]))
    end
  end

  describe('.find') do
    it("finds an album by id") do
      album = Album.new("Giant Steps", 1960, ["Jazz"], "John Coltrane")
      album.save()
      album2 = Album.new("Blue", 1971, ["Folk rock", "Pop"], "Joni Mitchell")
      album2.save()
      expect(Album.find(album.id)).to(eq(album))
    end
  end

  describe('#update') do
    it("updates an album by id") do
      album = Album.new("Giant Steps", 1960, ["Jazz"], "John Coltrane")
      album.save()
      album.update("A Love Supreme")
      expect(album.name).to(eq("A Love Supreme"))
    end
  end

  describe('#delete') do
    it("deletes an album by id") do
      album = Album.new("Giant Steps", 1960, ["Jazz"], "John Coltrane")
      album.save()
      album2 = Album.new("Blue", 1971, ["Folk rock", "Pop"], "Joni Mitchell")
      album2.save()
      album.delete()
      expect(Album.all).to(eq([album2]))
    end
  end

  describe('#sort') do
    it("sorts 2 albums by name") do
      album = Album.new("Giant Steps", 1960, ["Jazz"], "John Coltrane")
      album.save()
      album2 = Album.new("Blue", 1971, ["Folk rock", "Pop"], "Joni Mitchell")
      album2.save()
      Album.sort
      expect(Album.all).to(eq([album2, album]))
    end

    it("sorts 3 albums by name") do
      album = Album.new("Giant Steps", 1960, ["Jazz"], "John Coltrane")
      album.save()
      album2 = Album.new("Blue", 1971, ["Folk rock", "Pop"], "Joni Mitchell")
      album2.save()
      album3 = Album.new("Green", 1972, ["Acid Jazz"], "Joni Mitchell")
      album3.save()
      Album.sort
      expect(Album.all).to(eq([album2, album, album3]))
    end
  end
end
