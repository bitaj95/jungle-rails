require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validation" do 
    it "is valid when attributes are provided" do 
      @user = User.new(name: "Arthur", email: "test@mail.com", password: "Aardvark123", password_confirmation: "Aardvark123")
      expect(@user).to be_valid
    end

    it "is not valid if password is missing" do 
      @user = User.new(name: "Arthur", email: "test@mail.com", password_confirmation: "Aardvark123")
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages.first).to eq "Password can't be blank"
    end

    it "is not valid if password_confimation is missing" do 
      @user = User.new(name: "Arthur", email: "test@mail.com", password: "Aardvark123")
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages.first).to eq "Password confirmation can't be blank"
    end

    it "is not valid if name is missing" do 
      @user = User.new(email: "test@mail.com", password: "Aardvark123", password_confirmation: "Aardvark123")
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages.first).to eq "Name can't be blank"
    end

    it "is not valid if email is missing" do 
      @user = User.new(name: "Arthur", password: "Aardvark123", password_confirmation: "Aardvark123")
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages.first).to eq "Email can't be blank"
    end

    it "is not valid if passwords don't match" do 
      @user = User.new(name: "Arthur", email: "test@mail.com", password: "Aardvark123", password_confirmation: "Aardvark1223")
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages.first).to eq "Password confirmation doesn't match Password"
    end

    it "is not valid if passwords < 8 characters" do 
      @user = User.new(name: "Arthur", email: "test@mail.com", password: "123", password_confirmation: "123")
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages.first).to eq "Password is too short (minimum is 8 characters)"
    end
  end

  describe '.authenticate_with_credentials' do
    it 'is valid with the correct attributes' do
      @user = User.new(name: "Arthur", email: "test@mail.com", password: "Aardvark123", password_confirmation: "Aardvark123")
      expect(@user).to be_valid
      @user.save
      @user2 = User.authenticate_with_credentials('test@mail.com', 'Aardvark123')
      expect(@user2).to_not be nil
    end
    
    it 'is not valid with a non-existing email' do
      @user = User.new(name: "Arthur", email: "test@mail.com", password: "Aardvark123", password_confirmation: "Aardvark123")
      expect(@user).to be_valid
      @user.save
      @user2 = User.authenticate_with_credentials('different-email@mail.com', 'Aardvark123')
      expect(@user2).to be nil
    end

    it 'is not valid with the wrong password' do
      @user = User.new(name: "Arthur", email: "test@mail.com", password: "Aardvark123", password_confirmation: "Aardvark123")
      expect(@user).to be_valid
      @user.save
      @user2 = User.authenticate_with_credentials('test@mail.com', 'Aard123')
      expect(@user2).to be nil
    end
  end
end
