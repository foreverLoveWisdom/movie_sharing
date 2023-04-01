# frozen_string_literal: true

# Handle movies routing
class MoviesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @movies = Movie.all
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = current_user.movies.new(movie_params)

    if @movie.save
      redirect_to root_path, notice: I18n.t('movie.create.success')
    else
      render :new
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :description, :youtube_url)
  end
end
