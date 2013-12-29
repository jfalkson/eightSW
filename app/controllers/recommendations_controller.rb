class RecommendationsController < ApplicationController
before_filter :authenticate_user!, :except => [:index, :show] 

 
  def show
@recs = Recommendation.find(params[:id])
@comment= Comment.new
  end

def index
##adding new if then statement to add search functionality
## to the website
if params[:search]
@recs = Recommendation.search(params[:search]).order("created_at DESC").paginate( :per_page => 2, :page => params[:page])
else

@recs = Recommendation.paginate( :per_page => 2, :page => params[:page])
end
end

def new
 @recommendation=Recommendation.new
end

def create
 @recommendation=Recommendation.new(allowed_params)
 @recommendation.save
end

#only let this method be accessible within this specific class
private
def allowed_params
  params.require(:recommendation).permit(:rec_type, :rec_description, :link)
end

end