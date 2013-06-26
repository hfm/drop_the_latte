class Photo < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy

  default_scope -> { order('created_at DESC') }
  validates :user_id, presence: true
  validates :took_date, presence: true
end
