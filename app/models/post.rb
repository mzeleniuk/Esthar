class Post < ActiveRecord::Base
  has_many :comments

  validates :title, presence: true, length: {maximum: 500}

  def as_json(options = {})
    super(options.merge(include: :comments))
  end
end
