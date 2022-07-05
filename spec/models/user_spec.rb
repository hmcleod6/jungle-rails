require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do

    it "should have a password and password_confirmation" do
      user = User.new(
        first_name: "Heather", last_name: "McLeod", email: "123@abc.com", password: nil, password_confirmation: nil)
      user.save
      expect(user.errors.full_messages).to include("Password can't be blank" || "Password is too short (minimum is 3 characters)" || "Password confirmation can't be blank")                       
    end

    it "should not save without a valid first_name" do
      user = User.new(
        first_name: nil, last_name: "McLeod", email: "123@abc.com", password: "password", password_confirmation: "password")
      user.save
      expect(user.errors.full_messages).to include("First name cannot be blank")
    end

    it "should not save without a valid last_name" do
      user = User.new(
        first_name: "Heather", last_name: "", email: "123@abc.com", password: "password", password_confirmation: "password")
      user.save
      expect(user.errors.full_messages).to include("Last name cannot be blank")
    end

    it "should not save if the passwords don't match" do
      user = User.new(
        first_name: "Heather", last_name: "McLeod", email: "123@abc.com", password: "password", password_confirmation: "string")
      user.save
      expect(user.errors.full_messages).to include("Password confirmation does not match")
    end

    it "should not save without a valid email" do
      user = User.new(
        first_name: "Heather", last_name: "McLeod", email: "abc", password: "password", password_confirmation: "password")
      user.save
      expect(user.errors.full_messages).to include("Email is invalid")
    end

    it "should not save if the email is not unique" do

      user1 = User.new(
        first_name: "Heather", last_name: "McLeod", email: "123@abc.com", password: "password", password_confirmation: "password")
      user1.save

      user2 = User.new(
        first_name: "Heather", last_name: "McLeod", email: "123@ABC.COM", password: "password", password_confirmation: "password")
      user2.save

      expect(user2.errors.full_messages).to include("Email has already been taken")
    end

    it "should not save if the password length is less than three characteres" do
      user = User.new(
        first_name: "Heather", last_name: "McLeod", email: "abc@123.com", password: "he", password_confirmation: "he")
      user.save
      expect(user.errors.full_messages).to include("Password is too short (minimum is 3 characters)")
    end
  end


  describe '.authenticate_with_credentials' do
    it "should return an error if credentials are not valid" do
    user = User.new(
      first_name: "Heather", last_name: "Smith", email: "boop@beep.com", password: "qwerty", password_confirmation: "qwerty")
    user.save
    expect(User.authenticate_with_credentials("boop@beep.com", "qwerty")).to eql(user)
    end


    it "should authenticate despite whitespace" do
      user = User.new(
        first_name: "Heather", last_name: "McLeod", email: "123@abc.com", password: "password", password_confirmation: "password")
      user.save
      expect(User.authenticate_with_credentials("  123@abc.com  ", "password")).to eql(user)
    end


        it "should authenticate despite wrong case" do
      user = User.new(
        first_name: "Heather", last_name: "McLeod", email: "123@abc.com", password: "password", password_confirmation: "password")
      user.save
      expect(User.authenticate_with_credentials("123@abc.COM", "password")).to eql(user)
    end


  end
end