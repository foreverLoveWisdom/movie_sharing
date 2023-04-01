# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Share Movie', type: :feature do
  let!(:user) { create(:user) }
  let(:movie) { build(:movie) }
  let(:youtube_url) { 'https://www.youtube.com/watch?v=AbCdEfGhIjK' }
  let(:persisted_movie) { Movie.last }
  let(:embed_youtube_movie) { "https://www.youtube.com/embed/#{persisted_movie.youtube_id}" }

  context 'when user is logged in' do
    before do
      sign_in user
      visit root_path
      click_on 'Share a movie'
    end

    context 'when user can share a movie successfully' do
      it 'on the share movie page' do
        expect(page).to have_content('Share a Youtube movie')
      end

      it 'has movie share form' do
        ['Title', 'Description', 'Youtube url'].each do |field|
          expect(page).to have_content(field)
        end
      end

      context 'when user can share a movie' do
        before do
          fill_in 'Title', with: movie.title
          fill_in 'Description', with: movie.description
          fill_in 'Youtube url', with: youtube_url

          click_on 'Share'
        end

        it 'redirects to root path' do
          expect(page).to have_current_path(root_path)
        end

        it 'shows a success message' do
          expect(page).to have_content('Movie shared successfully.')
        end

        it 'shows the movie info' do
          [persisted_movie.title, persisted_movie.description].each do |movie_content|
            expect(page).to have_content(movie_content)
          end
        end

        it 'shows the embedded YouTube video' do
          expect(page).to have_css("iframe[src*='#{embed_youtube_movie}']")
        end
      end
    end

    context 'when user cannot share a movie' do
      context 'when youtube url is invalid' do
        before do
          fill_in 'Title', with: movie.title
          fill_in 'Description', with: movie.description
          fill_in 'Youtube url', with: 'invalid_url'
          click_on 'Share'
        end

        it 'does not create a new movie' do
          expect(Movie.count).to eq(0)
        end

        it 'shows an error message' do
          expect(page).to have_content('is not a valid YouTube ID')
        end
      end

      context 'when user tries to share a movie without filling all required fields' do
        before do
          fill_in 'Title', with: movie.title
          fill_in 'Description', with: ''
          fill_in 'Youtube url', with: youtube_url

          click_on 'Share'
        end

        it 'does not create a new movie' do
          expect(Movie.count).to eq(0)
        end

        it 'shows an error message' do
          expect(page).to have_content('Description can\'t be blank')
        end
      end

      context 'when the description is too long' do
        before do
          fill_in 'Title', with: movie.title
          fill_in 'Description', with: 'a' * 501
          fill_in 'Youtube url', with: youtube_url

          click_on 'Share'
        end

        it 'does not create a new movie' do
          expect(Movie.count).to eq(0)
        end

        it 'shows an error message' do
          expect(page).to have_content('Description is too long (maximum is 500 characters)')
        end
      end

      context 'when the title is too long' do
        before do
          fill_in 'Title', with: 'a' * 101
          fill_in 'Description', with: movie.description
          fill_in 'Youtube url', with: youtube_url

          click_on 'Share'
        end

        it 'does not create a new movie' do
          expect(Movie.count).to eq(0)
        end

        it 'shows an error message' do
          expect(page).to have_content('Title is too long (maximum is 100 characters)')
        end
      end

      context 'when user tries to share a movie that has already been shared' do
        let!(:movie) { create(:movie, youtube_id: YoutubeIdParser.parse(youtube_url)) }

        before do
          fill_in 'Title', with: movie.title
          fill_in 'Description', with: movie.description
          fill_in 'Youtube url', with: youtube_url

          click_on 'Share'
        end

        it 'does not create a new movie' do
          expect(Movie.count).to eq(1)
        end

        it 'shows an error message' do
          expect(page).to have_content('has already been taken')
        end
      end
    end
  end

  context 'when user is not logged in' do
    before do
      visit root_path
    end

    it 'does not show the share movie link' do
      expect(page).not_to have_content('Share a movie')
    end

    context 'when visitor tries to go to share movie page' do
      before do
        visit new_movie_path
      end

      it 'redirects to login page' do
        visit new_movie_path
        expect(page).to have_current_path(new_user_session_path)
      end

      it 'show sign in message' do
        expect(page).to have_content('You need to sign in or sign up before continuing.')
      end
    end
  end
end
