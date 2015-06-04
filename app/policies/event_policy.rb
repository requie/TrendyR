class EventPolicy
  ACCESS_ROLES = %w(artist venue label)
  PERMITTED_ATTRIBUTES = %i(photo_id title description_text started_at finished_at price)
  FILTER_ATTRIBUTES = %i(started_at_lteq finished_at_gteq location_source_place_id_eq)

  attr_reader :user, :event

  def initialize(user, event)
    @user = user
    @event = event
  end

  def index?
    ACCESS_ROLES.include?(user.role.name)
  end

  def new?
    index?
  end

  def create?
    index?
  end

  def edit?
    update?
  end

  def update?
    index? && event.owner_profile == user.profile
  end

  def destroy?
    index?
  end

  def permitted_attributes
    PERMITTED_ATTRIBUTES
  end

  def filter_attributes
    FILTER_ATTRIBUTES
  end

  def scope
    Pundit.policy_scope!(user, event.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.where(owner_profile: @user.profile)
    end
  end
end
