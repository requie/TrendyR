class ProfilePolicy
  GENERAL_ATTRIBUTES = [
      :name, :website, :description_text, :spotify_url, :rdio_url, :facebook_url,
      :twitter_url, :google_plus_url, :instagram_url, genre_ids: []
  ]
  MANAGER_ATTRIBUTES = [
      :name, :website, :description_text, :facebook_url, :twitter_url,
      :google_plus_url, :instagram_url, genre_ids: []
  ]

  attr_reader :user, :profile

  def initialize(user, profile)
    @user = user
    @profile = profile
  end

  def show?
    update?
  end

  def update?
    @profile.user_id == @user.id
  end

  def update_photo?
    update?
  end

  def permitted_attributes
    @user.role?(:manager) ? MANAGER_ATTRIBUTES : GENERAL_ATTRIBUTES
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
