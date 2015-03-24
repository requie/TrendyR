class PhotoAlbumPolicy
  attr_reader :user, :photo_album

  def initialize(user, photo_album)
    @user = user
    @photo_album = photo_album
  end

  def edit?
    update?
  end

  def update?
    @photo_album.owned_by?(user.profile)
  end

  def create?
    true
  end

  def destroy?
    @photo_album.owned_by?(user.profile)
  end
end
