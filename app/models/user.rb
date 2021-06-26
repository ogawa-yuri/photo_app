class User < ApplicationRecord
  mount_uploader :image, ImageUploader
  has_many :photos
  validates :name, presence: true
  validates :email, presence: true ,length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  has_many :favorites, dependent: :destroy
  has_many :favorite_photos, through: :favorites, source: :photo
end
