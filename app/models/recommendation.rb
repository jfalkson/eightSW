class Recommendation < ActiveRecord::Base
belongs_to :user
has_many :comments
has_many :votes
#validates :link, presence: true
#validates :rec_type, presence: true
end
