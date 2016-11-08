require 'rails_helper'

RSpec.describe User, type: :model do
  # Validations
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:username) }
end
