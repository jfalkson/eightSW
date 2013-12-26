class CommentsController < ApplicationController

#before a user posts comments they need 
# to be authenticated with Devise
before_filter :authenticate_user!, :except => [:index, :show]
  
  def create
    @comment = current_user.comments.create(allowed_params)
    #@comment=Comment.create(params[:comment])
  	#bring user back to original page (only this time with comment there)
  	redirect_to :back
  end
end

private
def allowed_params
  params.require(:comment).permit(:message, :user_id, :recommendation_id)
end