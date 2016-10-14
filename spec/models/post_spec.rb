require 'rails_helper'

RSpec.describe Post, type: :model do
  # Associations
  it { is_expected.to have_many(:comments) }

  # Validations
  it { is_expected.to validate_presence_of(:title) }
end
