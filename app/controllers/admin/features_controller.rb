module Admin
  class FeaturesController < Admin::AdminController
    before_action :set_feature, only: [:edit, :update, :destroy]

    def index
      @features = Feature.order(updated_at: :desc).page(params[:page])
    end

    def new
      @feature = Feature.new
    end

    def create
      feature = Feature.new(feature_params)
      feature.save
      redirect_to admin_features_path
    end

    def edit
    end

    def update
      @feature.update(feature_params)
      redirect_to admin_features_path
    end

    def destroy
      @feature.delete
      redirect_to admin_features_path
    end

    private

    def set_feature
      @feature = Feature.find(params[:id])
    end

    def feature_params
      params.require(:feature).permit(:title, :is_active)
    end
  end
end
