# This file is app/controllers/movies_controller.rb
class MoviesController < ApplicationController

  def index
    puts "index"
    sortingCriteria = params[:sort_by]
    puts sortingCriteria
    @movies = Movie.all
    if  sortingCriteria == "title"
      puts "title sorting"
      @movies.sort!{|x,y|x.title <=>y.title}   
    elsif sortingCriteria == "rDate"
      puts "date sorting"
      @movies.sort!{|x,y|x.release_date <=>y.release_date}   
    end
     @movies.each do |movie|
      puts movie.title
    end
    @all_ratings = Array[1, 2, 3, 4,5]
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # Look up movie by unique ID
      # will render app/views/movies/show.<extension> by default
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
