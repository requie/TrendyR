class GigPolicy
  ACCESS_ROLES = %w(artist venue producer manager label)
  PERMITTED_ATTRIBUTES = [
    :title, :price, :overview_text, :opportunity_text, :band_text, :event_id, :venue_details_text, :category_ids,
    :terms_text, :started_at, :finished_at, :start_time, :photo_id, :private, faqs_attributes: [:id, :question, :answer]
  ]
  FILTER_ATTRIBUTES = %i(started_at_lteq finished_at_gteq location_source_place_id_eq)

  attr_reader :user, :gig

  def initialize(user, gig)
    @user = user
    @gig = gig
  end

  def index?
    ACCESS_ROLES.include?(@user.role.name)
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
    index? && @gig.owner_profile == @user.profile
  end

  def destroy?
    index?
  end

  def request_confirmation?
    @user.role?(:artist) && !Booking.exists?(artist_id: @user.entity, gig_id: @gig)
  end

  def permitted_attributes
    PERMITTED_ATTRIBUTES
  end

  def filter_attributes
    FILTER_ATTRIBUTES
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
      scope.where(owner_profile: @user.profile).includes(:pending_bookings)
    end
  end
end
