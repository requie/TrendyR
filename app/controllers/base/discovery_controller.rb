module Base
  class DiscoveryController < BaseController
    before_action :set_page

    def artists
      @q = Artist.ransack(filter_params)
      @resources = @q.result.includes(profile: [:location, :genres]).page(@page)
      respond_to do |format|
        format.html
        format.json { render json: html_template(:artist) }
      end
    end

    def labels
      @q = Label.ransack(filter_params)
      @resources = @q.result.includes(profile: [:location, :genres]).page(@page)
      respond_to do |format|
        format.html
        format.json { render json: html_template(:label) }
      end
    end

    def managers
      @q = Manager.ransack(filter_params)
      @resources = @q.result.includes(profile: [:location, :genres]).page(@page)
      respond_to do |format|
        format.html
        format.json { render json: html_template(:manager) }
      end
    end

    def producers
      @q = Producer.ransack(filter_params)
      @resources = @q.result.includes(profile: [:location, :genres]).page(@page)
      respond_to do |format|
        format.html
        format.json { render json: html_template(:producer) }
      end
    end

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
      {}
    end

    def set_page
      @page = request.xhr? ? params[:page] : 1
    end

    def html_template(resource_name)
      {
        template: render_to_string(
          partial: "base/discovery/blocks/#{resource_name}",
          collection: @resources,
          formats: :html
        )
      }
    end
  end
end
