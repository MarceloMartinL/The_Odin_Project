class Post < ApplicationRecord
	default_scope -> { order(created_at: :desc) }
	validates :user_id, presence: true
	validates :content, presence: true, length: { maximum: 200 }
	belongs_to :user
	has_many :likes
	has_many :liking_users, :through => :likes, :source => :user
	has_many :comments
end
