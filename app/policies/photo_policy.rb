class PhotoPolicy
  attr_reader :user, :photo

  def initialize(user, photo)
    @user = user
    @photo = photo
  end

  def create?
    true
  end

  def crop?
    @photo.owned_by?(user)
  end

  def destroy?
    @photo.owned_by?(user)
  end
end
