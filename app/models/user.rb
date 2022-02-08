class User < ActiveRecord::Base
  has_secure_password

  validates_presence_of :name, :email, :password, :password_confirmation
  validates :password, length: {minimum: 8}


  # Check if the user exists and if the password correct
  def self.authenticate_with_credentials(email, password)
    @user = User.find_by(email: email.downcase).try(:authenticate, password)
    if @user
      @user
    else
      nil
    end
  end


end
