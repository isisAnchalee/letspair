module API
  class UserProfilesController < ApiController

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
    end

    def show
      @profile = UserProfile.find(params[:user_id])
      render :show
    end

    private

    def user_profile_params
      params.require(:user_profile).permit(:short_tag_line, :description, :work_history)
    end
  end
end
