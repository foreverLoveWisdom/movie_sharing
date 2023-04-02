# frozen_string_literal: true

# Parse YouTube URL to YouTube ID
class YoutubeIdParser
  prepend SimpleCommand
  include ActiveModel::Validations

  validates :url, presence: true

  def initialize(url)
    @url = url
  end

  def call
    return unless valid?

    youtube_regex = %r{
      (?:youtube(?:-nocookie)?\.com/(?:[^/\n\s]+/\S+/|(?:v|vi|e(?:mbed)?)/|\S*?[?&]v=)|
      youtu\.be/
    )([A-Za-z0-9_-]{11})}x

    unless (match = url.match(youtube_regex))
      errors.add(:base, I18n.t('errors.movie.youtube_id.invalid'))
      return
    end

    match[1]
  end

  private

  attr_reader :url
end
