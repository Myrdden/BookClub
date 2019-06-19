class BooksController < ApplicationController
  def index
    if params[:sort] == "avg_rating"
      books = Book.sort_average_rating
    elsif params[:sort] == "avg_rating_desc"
      books = Book.sort_average_rating :desc
    elsif params[:sort] == "num_pages"
      books = Book.order :page_count
    elsif params[:sort] == "num_pages_desc"
      books = Book.order page_count: :desc
    elsif params[:sort] == "num_reviews"
      books = Book.sort_number_reviews
    elsif params[:sort] == "num_reviews_desc"
      books = Book.sort_number_reviews :desc
    else
      books = Book
    end
    @to_show = params[:id].to_i
    @left = []; @mid = []; @right = []; @reviews = {}
    i = 0
    books.all.each do |book|
      @reviews[book.id] = book.reviews
      case i
      when 0; @left << book
      when 1; @mid << book
      when 2; @right << book
      end
      i += 1; i = 0 if i > 2
    end

    @top_three = Book.stat_three_best_rated
    @bottom_three = Book.stat_three_worst_rated
    @top_users = []

    # @backgrounds = ['#c00', '#c60', '#c90', '#3c0', '#39f', '#969', '#606']
    @backgrounds = ['red darken-2', 'orange darken-4', 'amber darken-3', 'green darken-2', 'blue darken-2', 'purple darken-2']
    @foregrounds = ['red lighten-1', 'orange', 'amber lighten-1', 'green lighten-2', 'blue lighten-2', 'purple lighten-2']
  end

  def show
    redirect_to action: 'index', id: params[:id]
  end

  def destroy
    Book.destroy(params[:id])
    redirect_to "/books"
  end

  def new
  end

  def create
    image_path = nil
    if params[:book]
      image_path = params[:book][:image] if params[:book][:image] != ""
    end
    new_book = Book.create({title: params[:book][:title].titleize, page_count: params[:book][:pages],
      year_published: "01-01-#{params[:book][:year]}".to_date, image_url: image_path})
    authors_list = params[:book][:authors].split(", ")
    authors_list.each do |author|
      Author.find_or_create_by(name: author.titleize).books << new_book
    end
    redirect_to '/books'
  end
end
