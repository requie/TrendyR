class ProfilePolicy
  PERMITTED_ATTRIBUTES = [
    :name, :website, :description_text, :spotify_url, :rdio_url, :facebook_url,
    :twitter_url, :google_plus_url, :instagram_url, genre_ids: []
  ]

  attr_reader :user, :profile

  def initialize(user, profile)
    @user = user
    @profile = profile
  end

  def show?
    true
  end

  def index?
    update?
  end

  def update?
    @profile.user == @user
  end

  def update_photo?
    update?
  end

  def permitted_attributes
    if @user.role?(:manager)
      PERMITTED_ATTRIBUTES - [:spotify_url, :rdio_url]
    else
      PERMITTED_ATTRIBUTES
    end
  end

  def scope
    Pundit.policy_scope!(user, profile.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end
