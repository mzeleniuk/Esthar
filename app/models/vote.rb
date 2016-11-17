class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  belongs_to :comment

  validates_uniqueness_of :post_id, scope: :user_id, allow_blank: true
  validates_uniqueness_of :comment_id, scope: :user_id, allow_blank: true
end
