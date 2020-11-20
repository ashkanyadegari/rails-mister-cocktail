class CocktailsController < ApplicationController
  before_action :set_cocktail, only: [:show, :edit, :update, :destroy]
  def index
    if params[:query].present?
      @query = params[:query]
      @cocktails = Cocktail.where("name LIKE ?","%#{params[:query]}%")
      # Preventing SQL Injection and Database error for
      # unknown characters
    else
      @cocktails = Cocktail.all
    end
    @random_cocktail = rand(0..@cocktails.length)
  end

  def new
    @cocktail = Cocktail.new
  end

  def show
    @dose = Dose.new
    @review = Review.new
  end


  def create
    @cocktail = Cocktail.new(cocktail_params)
    if @cocktail.save
      redirect_to @cocktail, notice: 'Cocktail was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    @cocktail.update(cocktail_params)
    redirect_to @cocktail
  end

  def destroy
    @cocktail.delete
    redirect_to cocktails_path
  end

  private

  def set_cocktail
    @cocktail = Cocktail.find(params[:id])
  end

  def cocktail_params
    params.require(:cocktail).permit(:name, :description, :image, :difficulty, :photo)
  end
end
