require 'rails_helper'

RSpec.describe Post, type: :model do
  # Associations
  it { is_expected.to have_many(:comments) }
  it { is_expected.to have_many(:votes).dependent(:destroy) }
  it { is_expected.to have_many(:voted_users).through(:votes).source(:user) }

  # Validations
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_length_of(:title).is_at_most(500).with_message('is too long (maximum is 500 characters)') }
  it { is_expected.to validate_presence_of(:body) }

  describe '#as_json' do
    let(:post) { create :post }
    let!(:comment) { create :comment, post: post }

    it 'returns JSON with comments' do
      expect(post.as_json.to_s).to include(comment.body)
    end
  end
end
