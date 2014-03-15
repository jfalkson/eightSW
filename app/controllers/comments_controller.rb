class CommentsController < ApplicationController

#before a user posts comments they need 
# to be authenticated with Devise
before_filter :authenticate_user!, :except => [:index, :show]
  
  def create
    @comment = current_user.comments.create(allowed_params)
  	redirect_to :back
  end
  
  
  def new
    @comment=Comment.new
  end



private
def allowed_params
  params.require(:comment).permit(:message, :user_id, :rec_id)
end

end