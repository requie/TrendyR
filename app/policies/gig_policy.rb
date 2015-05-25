class GigPolicy
  attr_reader :user, :gig

  def initialize(user, gig)
    @user = user
    @gig = gig
  end

  def index
    false
  end

  def request_confirmation?
    @user.role?(:artist) && !Booking.exists?(artist_id: @user.entity, gig_id: @gig)
  end

  def scope
    Pundit.policy_scope!(user, gig.class)
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
