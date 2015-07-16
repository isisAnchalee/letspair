module Api
  class ProfilesController < ApiController
    # before_action :require_signed_in!
    # before_action :ensure_current_user, only: [:new, :update, :create]

    def new
      @profile = Profile.new
      render :new
    end

    def create
      @profile = current_user.profile.build(profile_params)
      @profile.save!
      redirect_to root_url
    end

    def update
      @user = User.find(params[:user_id])
      @profile = @user.profile
      if @profile.update_attributes(profile_params)
        render :show
      else
        render json: { error: @profile.errors.full_messages }
      end
      #should decide later what to render/redirect
      redirect_to root_url
    end

    def show
      @profile = Profile.find(params[:id])
      render :show
    end

    private

    def profile_params
      params.require(:profile).permit(:short_tag_line, :description, :work_history)
    end
  end
end
