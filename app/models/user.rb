class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable
  
  has_many :books, dependent: :destroy
  has_one_attached :profile_image
  
  validates :name, presence: true, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, presence: true, length: { maximum: 50 }

  def get_profile_image(width: 100, height: 100)
    # デフォルト画像が未添付の場合、ファイルパスを指定して添付
    unless profile_image.attached?
      file_path = Rails.root.join('app', 'assets', 'images', 'default-image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    
    # サイズ指定があれば変換
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
end