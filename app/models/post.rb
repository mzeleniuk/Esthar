class Post < ActiveRecord::Base
  belongs_to :user

  has_many :comments
  has_many :votes, dependent: :destroy
  has_many :voted_users, through: :votes, source: :user

  validates :title, presence: true, length: {maximum: 500}

  def as_json(options = {})
    super(options.merge(include: [:user, comments: {include: :user}]))
  end
end
