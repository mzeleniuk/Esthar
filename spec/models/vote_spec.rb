require 'rails_helper'

RSpec.describe Vote, type: :model do
  let!(:vote) { create :vote }

  # Associations
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:post) }
  it { is_expected.to belong_to(:comment) }

  # Validations
  it { is_expected.to validate_uniqueness_of(:post_id).scoped_to(:user_id) }
  it { is_expected.to validate_uniqueness_of(:comment_id).scoped_to(:user_id) }
end
