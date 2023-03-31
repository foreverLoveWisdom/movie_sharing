# frozen_string_literal: true

# == Schema Information
#
# Table name: movies
#
#  id          :bigint           not null, primary key
#  description :string(500)      default(""), not null
#  title       :string(100)      default(""), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#  youtube_id  :string           not null
#
# Indexes
#
#  index_movies_on_user_id     (user_id)
#  index_movies_on_youtube_id  (youtube_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Movie do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    subject(:movie) { build(:movie, user:) }

    let!(:user) { create(:user) }

    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:youtube_id) }
    it { is_expected.to validate_length_of(:title).is_at_most(100) }
    it { is_expected.to validate_length_of(:description).is_at_most(500) }
    it { is_expected.to validate_uniqueness_of(:youtube_id) }

    it 'validate youtube_id' do
      expect(movie).to allow_value('AbCdEfGhIjK').for(:youtube_id)
      expect(movie).to allow_value('12345678901').for(:youtube_id)
      expect(movie).not_to allow_value('AbCdEfGhIjKl').for(:youtube_id)
      expect(movie).not_to allow_value('AbCdEfGhIjK!').for(:youtube_id)
      expect(movie).not_to allow_value('AbCdEfGhIjK ').for(:youtube_id)
      expect(movie).not_to allow_value(' AbCdEfGhIjK').for(:youtube_id)
    end
  end

  describe 'database columns' do
    it { is_expected.to have_db_column(:description).of_type(:string).with_options(default: '', null: false) }
    it { is_expected.to have_db_column(:title).of_type(:string).with_options(default: '', null: false) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
    it { is_expected.to have_db_column(:youtube_id).of_type(:string).with_options(null: false) }
  end

  describe 'database indexes' do
    it { is_expected.to have_db_index(:user_id) }
    it { is_expected.to have_db_index(:youtube_id) }
  end
end
