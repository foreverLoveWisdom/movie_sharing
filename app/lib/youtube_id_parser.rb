# frozen_string_literal: true

# Parse YouTube URL to YouTube ID
class YoutubeIdParser
  class InvalidUrlError < StandardError; end

  def self.parse(url)
    youtube_regex = %r{
      (?:youtube(?:-nocookie)?\.com/(?:[^/\n\s]+/\S+/|(?:v|vi|e(?:mbed)?)/|\S*?[?&]v=)|
      youtu\.be/
    )([A-Za-z0-9_-]{11})}x

    raise InvalidUrlError, "Invalid URL: #{url}" unless (match = url.match(youtube_regex))

    match[1]
  end
end
