class AwardPolicy
  attr_reader :user, :award

  def initialize(user, award)
    @user = user
    @award = award
  end

  def index?
    false
  end

  def new?
    create?
  end

  def create?
    true
  end

  def edit?
    update?
  end

  def update?
    @user.profile == @award.owner_profile
  end

  def scope
    Pundit.policy_scope!(user, award.class)
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
