class User < ApplicationRecord
 
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :books, dependent: :destroy, foreign_key: :user_id
	has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :book_comments, dependent: :destroy
 
  has_many :relationships, class_name: "Relationship", foreign_key: :followed_id  #フォローする側のhas_many
  has_many :followings, through: :relationships, source: :followed #あるユーザーがフォローしている人全員をもってくる
  
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: :follower_id #フォローされる側のhas_many
  has_many :followers, through: :reverse_of_relationships, source: :follower#フォローしてくれている人全員を持ってくる
  
  def follow(user_id)
     relationships.create(followed_id: user_id)
  end
  
  def unfollow(user_id)
    relationships.find_by(following_id: user_id).destroy
  end
  
  def following?(user)
    followings.include?(user)
  end
  
  
  


  validates :name, presence: true,length: {in: 2..20}
  validates :name, uniqueness: true
  validates :introduction,length: { maximum: 50}
         
  has_one_attached :profile_image
  def get_profile_image(size)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize: size).processed
  end 


end
