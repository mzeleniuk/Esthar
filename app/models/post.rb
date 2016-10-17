class Post < ActiveRecord::Base
  has_many :comments

  validates_presence_of :title

  def as_json(options = {})
    super(options.merge(include: :comments))
  end
end
