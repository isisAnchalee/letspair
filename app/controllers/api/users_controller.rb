module API
  class UsersController < ApiController
    def update
      if current_user == User.find(params[:id])
        @user = current_user
        if @user.update_attributes(user_params)
          render :show
        else
          render json: @user.errors.full_messages
        end
      end
      render :edit
    end

    def show
      @user = current_user
      @profile = @user.profile
      render :show
    end

    def destroy
      current_user.destroy if current_user == User.find(params[:id])
      redirect_to root_url
    end

    private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email)
    end
  end
end
