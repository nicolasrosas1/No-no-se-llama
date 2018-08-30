class User < ActiveRecord::Base
  EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :nombre, presence: true, length:  { :in => 3..20 }
  validates :apellido, presence: true, length:  { :in => 3..20 }
  validates :cargo, presence: true
  validates :bodega, presence: true
  validates :correo, presence: true, uniqueness: true, format: EMAIL_REGEX
  validates :pass, :confirmation => true #password_confirmation attr
  validates_length_of :pass, :in => 6..20, :on => :create
  before_save :encrypt_password
  after_save :clear_password

  def encrypt_password
    if pass.present?
      self.salt = BCrypt::Engine.generate_salt if new_record?
      self.pass = BCrypt::Engine.hash_secret(pass, salt) if new_record?
    end
  end

  def authenticate(correo='', pass='')
    user = User.find_by(correo: correo)
    if user && user.match_password(pass)
      return user
    else
      return false
    end
  end

  def match_password(login_password='')
    pass == BCrypt::Engine.hash_secret(login_password,salt)
  end

  def clear_password
    self.pass = nil
  end
end
