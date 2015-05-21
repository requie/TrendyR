module Guests
  class SearchController < Guests::GuestsController
    before_action :set_profile, if: proc { user_signed_in? }
    before_action :set_inbox_messages, if: proc { user_signed_in? && !request.xhr? }

    def index
      @search_results = SearchIndex.search_grouped_by_type(params[:q], 5)
      respond_to do |format|
        format.html { gon.resource = nil }
        format.json { render json: json_response('results') }
      end
    end

    def search
      @search_results = "SearchIndex::#{params[:resource].capitalize}".constantize.search(params[:q], 12)
      respond_to do |format|
        format.html { gon.resource = params[:resource] }
        format.json { render json: json_response('resource_results') }
      end
    end

    def event
      @search_results = SearchIndex::Event.search(params[:q], 9)
      respond_to do |format|
        format.html { gon.resource = 'event' }
        format.json { render json: json_response('event_results') }
      end
    end

    private

    def set_profile
      @profile = current_user.profile
    end

    def set_inbox_messages
      @inbox_messages = current_user.unread_messages
    end

    def json_response(partial)
      { template: render_to_string(partial: "guests/search/blocks/#{partial}", locals: { results: @search_results }, formats: :html) }
    end
  end
end
