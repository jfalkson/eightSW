class Comment < ActiveRecord::Base
  #attr_accessible :message, :user_id, :recommendation_id
  #has_one :user
  belongs_to :user
  belongs_to :recommendation
end