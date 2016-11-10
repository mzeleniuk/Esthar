require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create :user }

  # Validations
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_length_of(:email).is_at_most(50).with_message('is too long (maximum is 50 characters)') }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  it { is_expected.to allow_value('user@example.com').for(:email) }
  it { is_expected.to allow_value('user@example.COM').for(:email) }
  it { is_expected.to allow_value('A_US-ER@f.b.org').for(:email) }
  it { is_expected.to allow_value('frst.lst@mail.jp').for(:email) }
  it { is_expected.to allow_value('a+b@baz.cn').for(:email) }
  it { is_expected.to_not allow_value('user@example,com').for(:email) }
  it { is_expected.to_not allow_value('user@mail').for(:email) }
  it { is_expected.to_not allow_value('user_at_foo.org').for(:email) }
  it { is_expected.to_not allow_value('example.user@foo.foo@bar_baz.com').for(:email) }
  it { is_expected.to_not allow_value('foo@bar+baz.com').for(:email) }
  it { is_expected.to validate_presence_of(:username) }
  it { is_expected.to validate_length_of(:username).is_at_most(15).with_message('is too long (maximum is 15 characters)') }
  it { is_expected.to validate_uniqueness_of(:username).case_insensitive }
  it { is_expected.to validate_length_of(:password).is_at_least(6).with_message('is too short (minimum is 6 characters)') }
  it { is_expected.to validate_length_of(:first_name).is_at_most(25).with_message('is too long (maximum is 25 characters)') }
  it { is_expected.to validate_length_of(:last_name).is_at_most(25).with_message('is too long (maximum is 25 characters)') }
  it { is_expected.to validate_numericality_of(:phone).only_integer }
  it { is_expected.to validate_length_of(:website).is_at_most(100).with_message('is too long (maximum is 100 characters)') }
end
