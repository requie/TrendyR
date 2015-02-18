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
    true
  end
end
