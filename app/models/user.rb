class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:authentication_keys => [:login]
	# has_secure_password

	has_many :orders
	# has_many :services, dependent: :destroy

 	validates_uniqueness_of :username
 	validates_presence_of :password, :on => :create
 	validates :username, presence: true
 	validates_presence_of  :email, :if => :email_required?
  belongs_to :meta, :polymorphic => true
 	# before_create { generate_token(:auth_token) }

	# def generate_token(column)
	# 	begin
	# 	  self[column] = SecureRandom.urlsafe_base64
	# 	end while User.exists?(column => self[column])
	# end

  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end

  def email_required?
   false  
  end

end