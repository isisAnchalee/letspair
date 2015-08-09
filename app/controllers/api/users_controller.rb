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
      # authorize! :update, @user
      respond_to do |format|
        if @user.update(user_params)
          sign_in(@user == current_user ? @user : current_user, :bypass => true)
          format.html { redirect_to @user, notice: 'Your profile was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    def show
      @user = User.find(params[:id])
      @profile = @user.profile
      render :show
    end

    def destroy
      # authorize! :delete, @user
      @user.destroy
      respond_to do |format|
        format.html { redirect_to root_url }
        format.json { head :no_content }
      end
    end


    private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      accessible = [ :first_name, :last_name, :email ] # extend with your own params
      accessible << [ :password, :password_confirmation ] unless params[:user][:password].blank?
      params.require(:user).permit(accessible)
    end
  end
end
