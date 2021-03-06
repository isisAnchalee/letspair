module API
  class ReviewsController < ApiController
    
    def index
      @project = Project.find(params[:project_id])
      @reviews = @project.reviews.includes(:reviewer, :reviewee)
      render :index
    end

    def new
      @review = Review.new
      render :new
    end

    def create
      @review = Review.new(review_params)
      @review.reviewer_id = current_user.id
      @review.reviewed_id = Project.find(params[:project_id]).user_id
      @review.save!
      redirect_to root_url
    end

    def show
      @review = Review.find(params[:id])
      render :show
    end

    def destroy
      @review = Review.find(params[:id])
      @review.destroy
      render json: @review
    end

    private

    def review_params
      params.require(:review).permit(:title, :body, :project_id, :rating)
    end
  end
end
