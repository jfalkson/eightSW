class RecommendationsDatatable
  ##delegating helper methods to this class
  ##h is the html escape method used to prevent hacking
  delegate :params, :h, :link_to, to: :@view

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

##trying to create a method to count the number of upvotes
def number_of_upvotes
#  recommendations.find(params[:id]).votes.count
end



##map is a way to loop through instead of saying recommendations.each
  def data
    recommendations.map do |recommendation|
      [
        link_to(recommendation.rec_type, recommendation),
        link_to(recommendation.link,recommendation),
        recommendation.rec_description,
        #recommendation.find(params[:id]).votes.count
      ]
    end
  end

## if products isnt defined right now set it to fetch products
  def recommendations
    @recommendations ||= fetch_recommendations
  end

  def fetch_recommendations
    recommendations = Recommendation.order("#{sort_column} #{sort_direction}")
    recommendations = recommendations.page(page).per_page(per_page)
    if params[:sSearch].present?
      recommendations = recommendations.where("rec_description like ? OR rec_type like ? OR link like ?", "%#{query}%","%#{query}%","%#{query}%")
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