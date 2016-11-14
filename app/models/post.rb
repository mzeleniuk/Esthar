class Post < ActiveRecord::Base
  belongs_to :user

  has_many :comments

  validates :title, presence: true, length: {maximum: 500}

  def as_json(options = {})
    super(options.merge(include: [:user, :comments]))
  end
end
