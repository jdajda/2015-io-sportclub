class User
  include Mongoid::Document
  include ActiveModel::SecurePassword
  include Mongoid::Paperclip
  
  before_save { email.downcase! }

  field :username, :type => String
  field :email, :type => String
  field :phone, :type => String
  field :password_digest, :type => String

  has_mongoid_attached_file :photo,
                            :styles => { :small => '100x100#', :medium => '250x250#', :large => '500x500#' }
  has_secure_password

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PHONE_REGEX = /\+?\d+/i

  validates_attachment_content_type :photo, :content_type => ['image/jpg', 'image/jpeg', 'image/png']
  validates :username, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :phone, presence: true, length: { minimum: 9, maximum: 16 },
                    format: { with: VALID_PHONE_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }, on: :create
  
end
