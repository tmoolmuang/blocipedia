class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  
  has_many :wikis
         
  before_save { self.email = email.downcase if email.present? }
  after_initialize :init

  # validates :name, length: { minimum: 1, maximum: 100 }, presence: true
  # validates :password, presence: true, length: { minimum: 6 }, if: "password_confirmation.nil?"
  # validates_confirmation_of :password
  validates :password, length: { minimum: 6 }, allow_blank: true
  validates :email,
             presence: true,
             uniqueness: { case_sensitive: false },
             length: { minimum: 3, maximum: 254 }

  def init
    self.role  ||= :standard           
  end
  
  enum role: [:standard, :premium, :admin]
   
end
