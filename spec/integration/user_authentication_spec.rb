# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Register', type: :feature do
  let(:email) { Faker::Internet.email }
  let(:password) { Faker::Internet.password(min_length: 8) }
  let(:username) { Faker::Internet.username }
  let!(:user) { User.find(create(:user, email:, password:, username:).id) }

  context 'when signing up' do
    before do
      visit new_user_registration_path
    end

    it 'on the right page' do
      expect(page).to have_text('Sign up')
    end

    context 'when the input is valid' do
      before do
        fill_in 'Email', with: email
        fill_in 'Username', with: username
        fill_in 'Password', with: password
        fill_in 'Password confirmation', with: password
        click_button 'Sign up'
      end

      let(:user_info) { [user.email, user.username] }

      it 'creates a new user' do
        expect(user_info).to include(email, username)
      end

      it 'has valid password' do
        expect(user).to be_valid_password(password)
      end

      # click_link 'Sign out'
      # expect(page).to have_text('Signed out successfully.')

      # visit new_user_session_path

      # fill_in 'Email', with: user_attributes[:email]
      # fill_in 'Password', with: user_attributes[:password]
      # click_button 'Log in'

      # expect(page).to have_text('Signed in successfully.')
      # expect(page).to have_current_path(root_path)
    end

    context 'when the input is invalid' do
      it 'User cannot create an account with invalid email address' do
        fill_in 'Email', with: 'invalid email'
        fill_in 'Username', with: username
        fill_in 'Password', with: password
        fill_in 'Password confirmation', with: password
        click_button 'Sign up'

        expect(page).to have_text('Email is invalid')
      end

      # expect(page).to have_current_path(user_registration_path)
      it 'User cannot create an account with a password that is too short' do
        fill_in 'Email', with: email
        fill_in 'Username', with: username
        fill_in 'Password', with: 'short'
        fill_in 'Password confirmation', with: 'short'
        click_button 'Sign up'

        expect(page).to have_text('Password is too short')
      end

      it 'User cannot create an account with a password that does not match confirmation' do
        fill_in 'Email', with: email
        fill_in 'Username', with: username
        fill_in 'Password', with: password
        fill_in 'Password confirmation', with: 'different password'
        click_button 'Sign up'

        expect(page).to have_text("Password confirmation doesn't match Password")
      end
    end
  end
end
