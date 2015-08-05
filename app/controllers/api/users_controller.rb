module API
  class UsersController < ApiController

    def users_index
      @users = User.consultants.include(:user_profile)
      render :index
    end

    def companies_index
      @users = User.companies.include(:company_profile)
      render :index
    end

    def update
      if current_user == User.find(params[:id])
        @user = current_user
        if @user.update(user_params)
          render :show
        else
          render json: { errors: @user.errors.full_messages }
        end
      end
    end

    def show
      @user = User.find(params[:id])
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
