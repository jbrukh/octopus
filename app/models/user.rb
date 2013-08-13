class User < ActiveRecord::Base
  has_many :recordings

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable, :confirmable, :lockable

  before_create :reset_authentication_token

  strip_attributes :allow_empty => true, :only => [:first_name, :last_name]

  validates :first_name,  :presence => true
  validates :last_name,   :presence => true

  def admin?
    self.role == 'admin'
  end
end
