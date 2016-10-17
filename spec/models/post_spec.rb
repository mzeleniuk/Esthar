require 'rails_helper'

RSpec.describe Post, type: :model do
  # Associations
  it { is_expected.to have_many(:comments) }

  # Validations
  it { is_expected.to validate_presence_of(:title) }

  describe '#as_json' do
    let(:post) { create :post }
    let!(:comment) { create :comment, post: post }

    it 'returns JSON with comments' do
      expect(post.as_json.to_s).to include(comment.body)
    end
  end
end
