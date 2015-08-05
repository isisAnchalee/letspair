module API
  class CompanyProfilesController < ApiController
    # before_action :ensure_current_user, only: [:new, :update, :create]
    # before_action :ensure_user_has_company_profile, except: :show

    def new
      @profile = CompanyProfile.new
      render :new
    end

    def create
      @profile = current_user.company_profile.build(company_profile_params)
      @profile.save!
      redirect_to root_url
    end

    def update
      @user = current_user
      @profile = @user.profile
      if @profile.update(company_profile_params)
        render :show
      else
        render json: { error: @profile.errors.full_messages }
      end
      #should decide later what to render/redirect
      redirect_to root_url
    end

    def show
      @profile = CompanyProfile.find(params[:id])
      render :show
    end

    private

    def company_profile_params
      params.require(:company_profile).permit(:short_tag_line, :description)
    end
  end
end
