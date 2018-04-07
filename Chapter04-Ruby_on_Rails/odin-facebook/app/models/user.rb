class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, omniauth_providers: %i[facebook]
  validates :name, presence: true, length: { maximum: 50 }
  has_many :friend_requests, dependent: :destroy
  has_many :pending_friends, through: :friend_requests, source: :friend
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :posts, dependent: :destroy
  has_many :likes
  has_many :liked_posts, :through => :likes, :source => :post
  has_many :comments

  def remove_friend(friend)
  	friends.destroy(friend)
  end

  def friend?(user)
    friends.include?(user)
  end

  def pending_friend?(user)
    pending_friends.include?(user)
  end

  def feed
    friend_ids = "SELECT friend_id FROM friendships
                  WHERE user_id = :user_id"
    Post.where("user_id IN (#{friend_ids}) 
              OR user_id = :user_id", user_id: id)
  end
end
