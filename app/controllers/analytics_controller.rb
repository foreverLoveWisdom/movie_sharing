# frozen_string_literal: true

class AnalyticsController < ApplicationController
  def index
    kafka = Rdkafka.new(['localhost:9092'])
    consumer = kafka.consumer(group_id: 'my_application')

    # Subscribe to the Kafka topic
    consumer.subscribe('shared_movies')

    # Consume messages from the Kafka topic and update the statistics
    @total_movies = 0
    @most_popular_movies = []

    consumer.each_message do |message|
      # Deserialize the movie data from the Kafka message
      movie_data = JSON.parse(message.value)

      # Update the statistics
      @total_movies += 1

      if @most_popular_movies.length < 10
        @most_popular_movies << movie_data['title']
      else
        @most_popular_movies = @most_popular_movies.sort_by { |title| -Movie.where(title:).count }.take(10)
      end
    end
  end
end
