class ArtistPolicy
  attr_reader :user, :artist

  def initialize(user, artist)
    @user = user
    @artist = artist
  end

  def index?
    user.roles?(%w(producer manager label))
  end
end
