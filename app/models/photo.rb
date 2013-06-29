class Photo < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_attached_file :content

  default_scope -> { order('took_date DESC') }
  validates :user_id, presence: true
  validates :took_date, presence: true
  validates_attachment :content, presence: true,
    content_type: { content_type: ["image/jpg", "image/jpeg"] },
    size: { less_than: 5.megabytes }
end
