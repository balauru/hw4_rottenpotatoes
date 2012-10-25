class DirectorController < ApplicationController
  respond_to :html

  def show
    movie = Movie.find(params[:movie_id])
    @movies = Movie.find_all_by_director(movie.director) unless movie.director.empty?

    respond_with do |format|
      format.html do
        if movie.director.empty?
          flash[:notice] = "'#{movie.title}' has no director info"
          redirect_to movies_path
        else
          render :show
        end
      end
    end
  end
end
