class Member < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
   has_many :kijis, dependent: :destroy
   has_many :votes, dependent: :destroy
   has_many :voted_kijis, through: :votes, source: :kiji
   validates :name, presence: true, length: { minimum: 1, maximum: 50 }
   validates :email, presence: true
   validates :gender, presence: true
   mount_uploader :image, ImageUploader


  def votable_for?(kiji)
    kiji && kiji.author != self && !votes.exists?(kiji_id:
     kiji.id)
  end
end
