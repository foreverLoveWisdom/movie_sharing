# frozen_string_literal: true

# Handle movies routing
class MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = current_user.movies.new(movie_params)
    extract_youtube_id(params[:movie][:youtube_url], @movie)

    if @movie.save
      redirect_to root_path, notice: I18n.t('movie.create.success')
    else
      render :new
    end
  end

  private

  def extract_youtube_id(url, movie)
    # rubocop:disable Layout/LineLength
    youtube_regex = %r{(?:youtube(?:-nocookie)?\.com/(?:[^/\n\s]+/\S+/|(?:v|vi|e(?:mbed)?)/|\S*?[?&]v=)|youtu\.be/)([A-Za-z0-9_-]{11})}
    # rubocop:enable Layout/LineLength
    youtube_id = url.match(youtube_regex)[1]
    movie.youtube_id = youtube_id
  rescue NoMethodError, ArgumentError
    # Invalid or missing YouTube URL
  end

  def movie_params
    params.require(:movie).permit(:title, :description)
  end
end
