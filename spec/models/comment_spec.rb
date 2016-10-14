require 'rails_helper'

RSpec.describe Comment, type: :model do
  # Associations
  it { is_expected.to belong_to(:post) }

  # Validations
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_presence_of(:post) }
end
