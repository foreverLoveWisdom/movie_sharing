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
    end

    context 'when the input is invalid' do
      def redirect_to_registration_path
        expect(page).to have_current_path(user_registration_path)
      end

      it 'User cannot create an account with invalid email address' do
        fill_in 'Email', with: 'invalid email'
        fill_in 'Username', with: username
        fill_in 'Password', with: password
        fill_in 'Password confirmation', with: password
        click_button 'Sign up'

        expect(page).to have_text('Email is invalid')
        redirect_to_registration_path
      end

      it 'User cannot create an account with a password that is too short' do
        fill_in 'Email', with: email
        fill_in 'Username', with: username
        fill_in 'Password', with: 'short'
        fill_in 'Password confirmation', with: 'short'
        click_button 'Sign up'

        expect(page).to have_text('Password is too short')
        redirect_to_registration_path
      end

      it 'User cannot create an account with a password that does not match confirmation' do
        fill_in 'Email', with: email
        fill_in 'Username', with: username
        fill_in 'Password', with: password
        fill_in 'Password confirmation', with: 'different password'
        click_button 'Sign up'

        expect(page).to have_text("Password confirmation doesn't match Password")
        redirect_to_registration_path
      end
    end
  end

  context 'when signing in' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
    end

    it 'on the right page' do
      expect(page).to have_text('Log in')
    end

    context 'when the input is valid' do
      it 'signs in successfully' do
        fill_in 'Username', with: user.username
        fill_in 'Password', with: user.password
        click_button 'Log in'

        expect(page).to have_content('Signed in successfully.')
      end
    end

    context 'when the input is not valid' do
      it 'shows an error message if username is missing' do
        fill_in 'Password', with: user.password
        click_button 'Log in'

        expect(page).to have_content('Invalid Username or password.')
      end

      it 'shows an error message if password is missing' do
        fill_in 'Username', with: user.username
        click_button 'Log in'

        expect(page).to have_content('Invalid Username or password.')
      end

      it 'shows an error message if username and password are incorrect' do
        fill_in 'Username', with: 'wrong_username'
        fill_in 'Password', with: 'wrong_password'
        click_button 'Log in'

        expect(page).to have_content('Invalid Username or password.')
      end
    end
  end

  context 'when signing out' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
      fill_in 'Username', with: user.username
      fill_in 'Password', with: user.password
      click_button 'Log in'
    end

    it 'signs out successfully' do
      click_link 'Logout'

      expect(page).to have_content('Signed out successfully.')
    end
  end
end
