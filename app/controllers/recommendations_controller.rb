class RecommendationsController < ApplicationController
before_filter :authenticate_user!, :except => [:index, :show] 
helper_method :sort_column, :sort_direction
 
  def show
@recs = Recommendation.find(params[:id])
@comment= Comment.new
  end

def index
##adding new if then statement to add search functionality
## to the website
# if params[:search]
# @recs = Recommendation.search(params[:search]).order("created_at DESC").paginate( :per_page => 2, :page => params[:page])
# else

@recs = Recommendation.order(sort_column + " " + sort_direction).paginate( :per_page => 2, :page => params[:page])
#end

  respond_to do |format|
    format.html
    format.json { render json: RecommendationsDatatable.new(view_context) }
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

##Here we are putting in the code to sort the recommendation results##
def sort_column
    Recommendation.column_names.include?(params[:sort]) ? params[:sort] : "rec_type"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end




end