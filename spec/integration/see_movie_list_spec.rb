# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'See Movie List', type: :feature do
  let!(:users) { create_list(:user, 3) }
  let(:movie) { build(:movie) }
  let(:youtube_url) { 'https://www.youtube.com/watch?v=AbCdEfGhIjK' }
  let(:persisted_movie) { Movie.last }
  let(:embed_youtube_movie) { "https://www.youtube.com/embed/#{persisted_movie.youtube_id}" }

  before do
    users.each do |user|
      sign_in user
      visit new_movie_path
      fill_in 'Title', with: movie.title
      fill_in 'Description', with: movie.description
      fill_in 'Youtube url', with: youtube_url
      click_on 'Share'
      sign_out user
    end
    visit root_path
  end

  it 'shows shared movies by users' do
    Movie.all.each do |movie|
      expect_to_see_movie(movie)
    end
  end

  def expect_to_see_movie(movie)
    expect(page).to have_content(movie.title)
    expect(page).to have_content(movie.description)
    expect(page).to have_css("iframe[src*='https://www.youtube.com/embed/#{movie.youtube_id}']")
  end
end
