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
class Movie < ApplicationRecord
  belongs_to :user

  validates :title, length: { maximum: 100 }, presence: true
  validates :description, length: { maximum: 500 }, presence: true
  validates :youtube_id, presence: true,
                         uniqueness: true,
                         format: { with: /\A[A-Za-z0-9_-]{11}\z/, message: I18n.t('errors.movie.youtube_id.invalid') }
end
