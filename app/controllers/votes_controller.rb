class VotesController < ApplicationController
before_filter :authenticate_user!

def create
@votes = Vote.where(:recommendation_id => params[:vote][:recommendation_id], :user_id => current_user.id).first
if @votes
  @votes.up = params[:vote][:up]
  @votes.save
else
  @votes = current_user.votes.create(allowed_params)
end
redirect_to :back

end


private 

def allowed_params
  params.require(:vote).permit(:up, :user_id, :recommendation_id)
end

end