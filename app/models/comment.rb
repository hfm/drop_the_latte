class Comment < ActiveRecord::Base
  belongs_to :photo
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates :user_id, presence: true
  validates :other_id, presence: true
  validates :photo_id, presence: true
  validates :content,  presence: true, length: { maximum: 140 }
end
