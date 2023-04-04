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
  attr_accessor :youtube_url

  belongs_to :user

  validates :title, length: { maximum: 100 }, presence: true
  validates :description, length: { maximum: 500 }, presence: true
  validate  :validate_youtube_url
  validates :youtube_id, uniqueness: { message: I18n.t('errors.movie.youtube_id.duplicate') }

  after_create_commit :publish_to_kafka_topic

  private

  def validate_youtube_url
    parser = YoutubeIdParser.call(youtube_url)

    if parser.success?
      self.youtube_id = parser.result
    else
      errors.add(:base, parser.errors.full_messages.join(', '))
    end
  end

  def publish_to_kafka_topic
    kafka = Kafka.new(['localhost:9092'])
    producer = kafka.producer

    # Serialize the movie data as a JSON string
    movie_data = to_json

    # Publish the movie data to the Kafka topic
    producer.produce(movie_data, topic: 'shared_movies')

    # Flush the producer to ensure that the message is sent
    producer.deliver_messages
  end
end
