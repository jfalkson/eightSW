class RecommendationsController < ApplicationController
 

 
  def show
@recs = Recommendation.find(params[:id])
  end

def index
@recs = Recommendation.paginate( :per_page => 2, :page => params[:page])
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