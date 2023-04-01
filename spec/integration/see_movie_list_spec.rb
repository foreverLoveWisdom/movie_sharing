# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'See Movie list', type: :feature do
  let(:user) { create(:user) }
  let!(:movies) { create_list(:movie, 3, user:) }

  before do
    visit root_path
  end

  context 'when a guest user wants to see the movie list' do
    it 'displays a list of shared movies' do
      movies.each do |movie|
        expect_movie_to_be_displayed(movie)
      end
    end
  end

  context 'when a registered user wants to see the movie list' do
    before do
      sign_in user
      visit root_path
    end

    it 'displays a list of shared movies' do
      movies.each do |movie|
        expect_movie_to_be_displayed(movie)
      end
    end
  end

  def expect_movie_to_be_displayed(movie)
    expect(page).to have_content(movie.title)
    expect(page).to have_content(movie.description)
    expect(page).to have_css("iframe[src*='#{movie.youtube_id}']")
  end
end
