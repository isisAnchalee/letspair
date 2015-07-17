module API
  class UserProfilesController < ApiController
    # before_action :require_signed_in!
    # before_action :ensure_current_user, only: [:new, :update, :create]
    # before_action :ensure_user_has_user_profile, except: :show

    def new
      @profile = UserProfile.new
      render :new
    end

    def create
      @profile = current_user.user_profile.build(user_profile_params)
      @profile.save!
      redirect_to root_url
    end

    def update
      @user = current_user
      @profile = @user.user_profile
      if @profile.update(user_profile_params)
        render :show
      else
        render json: { error: @profile.errors.full_messages }
      end
      #should decide later what to render/redirect
      redirect_to root_url
    end

    def show
      @profile = UserProfile.find(params[:id])
      render :show
    end

    private

    def user_profile_params
      params.require(:user_profile).permit(:short_tag_line, :description, :work_history)
    end
  end
end
