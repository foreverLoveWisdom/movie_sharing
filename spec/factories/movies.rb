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
FactoryBot.define do
  factory :movie do
    association :user
    title { Faker::Movie.title }
    youtube_url { Faker::Internet.url(host: 'youtube.com', path: "/watch?v=#{Faker::Alphanumeric.alpha(number: 11)}") }
    description { Faker::Lorem.paragraph }
  end
end
