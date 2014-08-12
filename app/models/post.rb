class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  
  default_scope -> { order('created_at DESC') }
  validates :title, presence: true
  validates :content, presence: true
  validates :user_id, presence: true
end
