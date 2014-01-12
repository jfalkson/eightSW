class RecommendationsDatatable
  ##delegating helper methods to this class
  ##h is the html escape method used to prevent hacking
  delegate :params, :h, :link_to, :current_user, to: :@view
  include ApplicationHelper
  include Rails.application.routes.url_helpers
  
  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Recommendation.count,
      iTotalDisplayRecords: recommendations.total_entries,
      aaData: data
    }
  end


private

#need to make this method actually change the votecount#
#user needs to be able to post
# right now vote count doesnt change and method doesnt get to second if statement
def votelnk(recommendation)
		rec=recommendation
        if current_user && current_user.votes.where(:recommendation_id => rec.id, :up => true).present?
     	"*"
   		else
    		link_to '+', votes_path(:vote => {:recommendation_id => rec.id, :up => true}), :method => :post
   		end
   		 
    	if current_user && current_user.votes.where(:recommendation_id => rec.id, :up => false).present? 
    		"*"     	
    	else
      	link_to '-', votes_path(:vote => {:recommendation_id => rec.id, :up => false}), :method => :post
    	end
end

##map is a way to loop through instead of saying recommendations.each
  def data
    recommendations.map do |recommendation|
      [
      ##link to is a ruby function, the second argument is the path
      ##in this case the path leads to a recommendation id
        link_to(recommendation.rec_type, recommendation),
        link_to(recommendation.link,recommendation),
        recommendation.rec_description,
        recommendation.votes.count,
        link_to('Add Comment',recommendation),
        ##when this code below is removed it works fine without an up/down vote option
		votelnk(recommendation)
      ]
    end
  end

## if recs isnt defined right now set it to fetch recs
  def recommendations
    @recommendations ||= fetch_recommendations
  end

  def fetch_recommendations
    recommendations = Recommendation.order("#{sort_column} #{sort_direction}")
    recommendations = recommendations.page(page).per_page(per_page)
    if params[:sSearch].present?
      recommendations = recommendations.where("rec_description like :search OR rec_type like :search OR link like :search", search: "%#{params[:sSearch]}%")
    end
    recommendations
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[rec_type link rec_description ]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end