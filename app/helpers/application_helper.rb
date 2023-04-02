# frozen_string_literal: true

# View helpers for the whole application
module ApplicationHelper
  def username(user)
    "Welcome #{user.email}"
  end

  def embed_youtube_movie(youtube_id)
    content_tag(:iframe, '', class: 'embed-responsive-item', allowfullscreen: '', src: full_youtube_url(youtube_id))
  end

  def full_youtube_url(youtube_id)
    "https://www.youtube.com/embed/#{youtube_id}"
  end
end
