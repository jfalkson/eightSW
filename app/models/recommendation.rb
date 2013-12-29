class Recommendation < ActiveRecord::Base
belongs_to :user
has_many :comments
has_many :votes
#validates :link, presence: true
#validates :rec_type, presence: true


def self.search(query)
# where(:title, query) -> This would return an exact match of the query
where("rec_description like ? OR rec_type like ? OR link like ?", "%#{query}%","%#{query}%","%#{query}%") 

end



end
