class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  has_many :votes, dependent: :destroy
  has_many :voted_users, through: :votes, source: :user

  validates_presence_of :body, :post

  def as_json(options = {})
    super(options.merge(include: :user))
  end
end
