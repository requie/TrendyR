class ProfileHeadlessPolicy < Struct.new(:user, :profile)
  def initialize(user, profile)
    @user = user
    @profile = profile
  end

  def show_music_links?
    !@user.role?(:manager)
  end
end
