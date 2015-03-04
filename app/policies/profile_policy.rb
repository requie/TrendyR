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

  def show_gigs?
    @profile.user.roles? %w(artist venue)
  end

  def show_events?
    @profile.user.roles? %w(artist label manager venue)
  end

  def show_awards?
    @profile.user.roles? %w(label producer)
  end

  def show_photos?
    @profile.user.roles? %w(artist venue)
  end

  def show_music?
    @profile.user.role?(:artist)
  end

  def show_videos?
    @profile.user.roles? %w(artist label)
  end

  def show_location?
    @profile.user.roles? %w(label manager producer venue)
  end

  def show_item_artists?
    @profile.user.roles? %w(label manager producer)
  end

  def show_item_releases?
    @profile.user.roles? %w(artist label producer)
  end

  def show_item_calendar?
    @profile.user.roles? %w(label manager venue)
  end

  def show_item_press_kit?
    @profile.user.role?(:artist)
  end

  def edit?
    update?
  end

  def update?
    @profile.user == @user
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
