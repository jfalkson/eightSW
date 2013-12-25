class Recommendation < ActiveRecord::Base
belongs_to :user
has_many :comments
#validates :link, presence: true
#validates :rec_type, presence: true
end
