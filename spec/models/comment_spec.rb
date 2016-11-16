require 'rails_helper'

RSpec.describe Comment, type: :model do
  # Associations
  it { is_expected.to belong_to(:post) }

  it { is_expected.to have_many(:votes).dependent(:destroy) }
  it { is_expected.to have_many(:voted_users).through(:votes).source(:user) }

  # Validations
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_presence_of(:post) }

  describe '#as_json' do
    let(:user) { create :user }
    let(:post) { create :post }
    let!(:comment) { create :comment, post: post, user: user }

    it 'returns JSON with user ID' do
      expect(comment.as_json.to_s).to include(comment.body)
      expect(comment.as_json.to_s).to include(user.id.to_s)
    end
  end
end
