module Base
  class GigsController < Base::BaseController
    def index
      @gigs = policy_scope(Gig)
      # renders a template
    end
  end
end
