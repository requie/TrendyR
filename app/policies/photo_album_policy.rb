class PhotoAlbumPolicy
  PERMITTED_ATTRIBUTES = [:title, photo_ids: []]

  attr_reader :user, :photo_album

  def initialize(user, photo_album)
    @user = user
    @photo_album = photo_album
  end

  def index?
    create?
  end

  def new?
    create?
  end

  def create?
    user.role?('venue')
  end

  def edit?
    update?
  end

  def update?
    create? && photo_album.owner_profile == user.profile
  end

  def destroy?
    create?
  end

  def permitted_attributes
    PERMITTED_ATTRIBUTES
  end
end
