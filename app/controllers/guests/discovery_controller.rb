module Guests
  class DiscoveryController < Guests::GuestsController
    FILTER_ATTRIBUTES = %i(
      profile_location_source_place_id_eq started_at_lteq finished_at_gteq location_source_place_id_eq
    )

    before_action :set_page, except: :resource
    before_action :set_filter_params, except: :music

    def resource
      @type = params[:resource].singularize.downcase
      @q = @type.capitalize.constantize.ransack(filter_params)
      page = request.xhr? ? params[:page] : 1
      @resources = @q.result.includes(profile: [:location, :genres]).page(page)
      respond_to do |format|
        format.html
        format.json { render json: html_template }
      end
    end

    def gigs
      @q = Gig.ransack(filter_params)
      @resources = @q.result.page(@page)
      respond_to do |format|
        format.html
        format.json { render json: html_template(:gig) }
      end
    end

    def events
      @q = Event.ransack(filter_params)
      @resources = @q.result.page(@page)
      respond_to do |format|
        format.html
        format.json { render json: html_template(:event) }
      end
    end

    def music
      @albums = Release.first(5)
      @resources = Song.eager_load(release: {artist: {profile: :location}})
          .where.not(release: nil).page(@page)
      respond_to do |format|
        format.html
        format.json { render json: html_template(:song) }
      end
    end

    private

    def filter_params
      params[:q] && params[:q].permit(FILTER_ATTRIBUTES)
    end

    def set_page
      @page = request.xhr? ? params[:page] : 1
    end

    def set_filter_params
      gon.q = { q: params.fetch(:q, {}) }
    end

    def html_template(resource_name = @type)
      {
        template: render_to_string(
          partial: "guests/discovery/blocks/templates/#{resource_name}",
          collection: @resources,
          formats: :html
        )
      }
    end
  end
end
