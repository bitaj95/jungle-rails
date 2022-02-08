require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validation" do 
    it "is valid when attributes are provided" do 
      @user = User.new(name: "Arthur", email: "test@mail.com", password: "123", password_confirmation: "123")
      expect(@user).to be_valid
    end

    it "is not valid if password is missing" do 
      @user = User.new(name: "Arthur", email: "test@mail.com", password_confirmation: "123")
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages.first).to eq "Password can't be blank"
    end

    it "is not valid if password_confimation is missing" do 
      @user = User.new(name: "Arthur", email: "test@mail.com", password: "123")
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages.first).to eq "Password confirmation can't be blank"
    end

    it "is not valid if name is missing" do 
      @user = User.new(email: "test@mail.com", password: "123", password_confirmation: "123")
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages.first).to eq "Name can't be blank"
    end

    it "is not valid if email is missing" do 
      @user = User.new(name: "Arthur", password: "123", password_confirmation: "123")
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages.first).to eq "Email can't be blank"
    end

    it "is not valid if passwords don't match" do 
      @user = User.new(name: "Arthur", email: "test@mail.com", password: "123", password_confirmation: "1223")
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages.first).to eq "Password confirmation doesn't match Password"
    end
  end
end
