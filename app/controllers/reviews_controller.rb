class ReviewsController < ApplicationController
  before_action :set_cocktail, only: [:create, :new]
  def index
    @reviews = Review.all
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.cocktail_id = params[:cocktail_id]
    if @review.save
      redirect_to @cocktail, notice: 'Review was successfully created.'
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :photo, :rating)
  end

  def set_cocktail
    @cocktail = Cocktail.find(params[:cocktail_id])
  end
end
