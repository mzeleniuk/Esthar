class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates_presence_of :email, :username

  validates :email, length: {maximum: 50},
            format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :username, length: {maximum: 15}, uniqueness: {case_sensitive: false}
  validates :password, length: {minimum: 6}
  validates :first_name, :last_name, length: {maximum: 25}, allow_blank: true
  validates :phone, numericality: {only_integer: true}, length: {maximum: 20}, allow_blank: true
  validates :website, length: {maximum: 100}, allow_blank: true
end
