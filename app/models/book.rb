class Book < ApplicationRecord
  mount_uploader :picture,PictureUploader
  validates :title, presence: true, uniqueness: true,length: { maximum: 30 }
  validates :memo, presence: true, length: { maximum: 400 }
  validates :author, presence: true, length: { maximum: 20 }
  validates_size_of :picture, maximum: 2.megabytes, message: "2MBを超えています。"
end
