class User < ActiveRecord::Base
  EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :nombre, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
  validates :correo, :presence => true, :uniqueness => true, :format => EMAIL_REGEX
  validates :pass, :confirmation => true #password_confirmation attr
  validates_length_of :pass, :in => 6..20, :on => :create
  before_save :encrypt_password
  after_save :clear_password

  def encrypt_password
    if pass.present?
      self.salt = BCrypt::Engine.generate_salt
      self.pass = BCrypt::Engine.hash_secret(pass, salt)
    end
  end

  def authenticate(usuario='', pass='')
    user = User.find_by(nombre: usuario)
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
