require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'Validations' do

    it 'should show a new user will save successfully' do
      user_params = {first_name: "firstName", last_name: "lastName", email: "email@email.com", password: 'password', password_confirmation: 'password'}
      @new_user = User.create(user_params)
      @new_user.save!

      expect(@new_user.id).to be_present
    end

    it 'should confirm that passwords have been entered' do
      user_params = {first_name: "firstName", last_name: "lastName", email: "email@email.com", password: nil, password_confirmation: nil}
      expect(User.create(user_params).errors.full_messages).to include("Password can't be blank")
    end

    it 'should confirm that entered passwords match' do
      user_params = {first_name: "firstName", last_name: "lastName", email: "email@email.com", password: 'otherpassword', password_confirmation: 'password'}
      expect(User.create(user_params).errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'should confirm that a first_name, last_name, and email have been entered' do
      user_params1 = {first_name: nil, last_name: "lastName", email: "email@email.com", password: 'password', password_confirmation: 'password'}
      user_params2 = {first_name: "firstName", last_name: nil, email: "email@email.com", password: 'password', password_confirmation: 'password'}
      user_params3 = {first_name: "firstName", last_name: "lastName", email: nil, password: 'password', password_confirmation: 'password'}

      expect(User.create(user_params1).errors.full_messages).to include("First name can't be blank")
      expect(User.create(user_params2).errors.full_messages).to include("Last name can't be blank")
      expect(User.create(user_params3).errors.full_messages).to include("Email can't be blank")
    end

    it 'should confirm that the password has a minimum length of 8 characters' do
      user_params1 = {first_name: "firstName", last_name: "lastName", email: "email@Email.com", password: 'password', password_confirmation: 'password'}
      user_params2 = {first_name: "firstName", last_name: "lastName", email: "eMail@email.com", password: 'pass', password_confirmation: 'pass'}

      expect(User.create(user_params1)).to be_valid
      expect(User.create(user_params2).errors.full_messages).to include("Password is too short (minimum is 8 characters)")
    end

    it 'should confirm that the email does not already exist' do
      user_params1 = {first_name: "firstName", last_name: "lastName", email: "email@email.com", password: 'password', password_confirmation: 'password'}
      user_params2 = {first_name: "newName", last_name: "otherName", email: "email@email.com", password: 'passwordx', password_confirmation: 'passwordx'}
      user_params3 = {first_name: "firstName", last_name: "lastName", email: "eMail@eMAIL.com", password: 'password', password_confirmation: 'password'}

      User.create(user_params1).save!

      expect(User.create(user_params2).errors.full_messages).to include("Email has already been taken")
      expect(User.create(user_params3).errors.full_messages).to include("Email has already been taken")
    end
    
  end

  describe '.authenticate_with_credentials' do
    it 'should return a user object when correct credentials are provided' do
      user_params1 = {first_name: "firstName", last_name: "lastName", email: "email@email.com", password: 'password', password_confirmation: 'password'}
      validUser = User.create(user_params1)

      expect(User.authenticate_with_credentials("email@email.com", "password")).to eq(validUser)
      expect(User.authenticate_with_credentials("differentEmail@email.com", "wrongPassword")).not_to equal(validUser)
    end

    it 'should return a user object when correct credentials are provided, EVEN IF THEY HAVE EXTRA SPACES' do
      user_params1 = {first_name: "firstName", last_name: "lastName", email: "email@email.com", password: 'password', password_confirmation: 'password'}
      validUser = User.create(user_params1)

      expect(User.authenticate_with_credentials("  email@email.com   ", "password")).to eq(validUser)
    end

    it 'should return a user object when correct credentials are provided, EVEN IF THEY TYPE THE WRONG CASE' do
      user_params1 = {first_name: "firstName", last_name: "lastName", email: "email@email.com", password: 'password', password_confirmation: 'password'}
      validUser = User.create(user_params1)

      expect(User.authenticate_with_credentials("eMaIl@EMAIL.com", "password")).to eq(validUser)
    end

  end

end
