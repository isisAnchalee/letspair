module API
  class BidsController < ApiController

    def index
      @project = Project.find(params[:project_id])
      @bids = @project.bids
      render :index
    end

    def new
      @bid = Bid.new
      render :new
    end

    def create
      @bid = current_user.bid.build(bid_params)
      @bid.save!
      redirect_to root_url
    end

    def update
      @bid = Bid.find(params[:id])
      if @bid.update(bid_params)
        render :show
      else
        render json: { error: @bid.errors.full_messages }
      end
    end

    def show
      @bid = Bid.find(params[:id]).include(:bidder, :project)
      render :show
    end

    def destroy
      @bid = Bid.find(params[:id])
      @bid.destroy
      render json: @bid
    end

    private

    def bid_params
      params.require(:bid).permit(:price, :content, :project_id)
    end
  end
end
