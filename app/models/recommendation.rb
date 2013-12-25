class Recommendation < ActiveRecord::Base
belongs_to :user
#validates :link, presence: true
#validates :rec_type, presence: true
end
