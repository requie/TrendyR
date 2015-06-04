class ReleasePolicy
  PERMITTED_ATTRIBUTES = [:title, :description_text, :photo_id, song_ids: []]

  attr_reader :user, :release

  def initialize(user, release)
    @user = user
    @profile = release
  end

  def index?
    create?
  end

  def list?
    user.role?(:producer)
  end

  def show?
    user.role?(:label)
  end

  def new?
    create?
  end

  def create?
    user.role?(:artist)
  end

  def edit?
    update?
  end

  def update?
    create? && release.artist == user.profile.entity
  end

  def permitted_attributes
    PERMITTED_ATTRIBUTES
  end

  def scope
    Pundit.policy_scope!(user, release.class)
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
