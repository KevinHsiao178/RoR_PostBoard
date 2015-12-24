class User < ActiveRecord::Base
	has_many :articles, dependent: :destroy
	has_many :comments, dependent: :destroy

	has_secure_password validations: false

	validates :name, presence: true, length: {minimum: 3}
	validates :mail, presence: true, uniqueness: true, length: {minimum: 5}
	validates :password, presence: true, on: :create, length: {minimum: 5}
end