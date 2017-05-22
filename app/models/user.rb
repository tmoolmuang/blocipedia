class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  
  has_many :wikis
         
  before_save { self.email = email.downcase if email.present? }
  after_initialize :init

# validates :name, length: { minimum: 1, maximum: 100 }, presence: true
# validates :password, presence: true, length: { minimum: 6 }, if: "password_digest.nil?"
  validates :password, length: { minimum: 6 }, allow_blank: true
  validates :email,
             presence: true,
             uniqueness: { case_sensitive: false },
             length: { minimum: 3, maximum: 254 }

#   has_secure_password

    def init
      self.role  ||= :standard           
    end
    
    enum role: [:standard, :premium, :admin]
   
end
