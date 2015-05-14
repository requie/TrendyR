module Base
  class DiscoveryController < BaseController
    before_action :set_page, except: :resource

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

    # deprecated
    def artists
      @q = Artist.ransack(filter_params)
      @resources = @q.result.includes(profile: [:location, :genres]).page(@page)
      respond_to do |format|
        format.html
        format.json { render json: html_template(:artist) }
      end
    end

    # deprecated
    def labels
      @q = Label.ransack(filter_params)
      @resources = @q.result.includes(profile: [:location, :genres]).page(@page)
      respond_to do |format|
        format.html
        format.json { render json: html_template(:label) }
      end
    end

    # deprecated
    def managers
      @q = Manager.ransack(filter_params)
      @resources = @q.result.includes(profile: [:location, :genres]).page(@page)
      respond_to do |format|
        format.html
        format.json { render json: html_template(:manager) }
      end
    end

    # deprecated
    def producers
      @q = Producer.ransack(filter_params)
      @resources = @q.result.includes(profile: [:location, :genres]).page(@page)
      respond_to do |format|
        format.html
        format.json { render json: html_template(:producer) }
      end
    end

    # deprecated
    def venues
      @q = Venue.ransack(filter_params)
      @resources = @q.result.includes(profile: [:location, :genres]).page(@page)
      respond_to do |format|
        format.html
        format.json { render json: html_template(:venue) }
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
      @resources = Song.eager_load(release: { artist: { profile: :location } }).where.not(release: nil).page(@page)
      respond_to do |format|
        format.html
        format.json { render json: html_template(:song) }
      end
    end

    private

    def filter_params
      params[:q] && params[:q].permit(:profile_location_source_place_id_eq)
    end

    def set_page
      @page = request.xhr? ? params[:page] : 1
    end

    def html_template(resource_name = @type)
      {
        template: render_to_string(
          partial: "base/discovery/blocks/templates/#{resource_name}",
          collection: @resources,
          formats: :html
        )
      }
    end
  end
end
