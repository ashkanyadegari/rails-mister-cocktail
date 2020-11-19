class DosesController < ApplicationController
  before_action :set_dose, only: [:show, :edit, :destroy]
  def new
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.new
  end

  def create
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.new(dose_params)
    @dose.cocktail_id = params[:cocktail_id]
    if @dose.save
      redirect_to @cocktail, notice: 'Dose was successfully created.'
    else
      render :new
    end
  end

  def show
  end


  def destroy
    @cocktail = @dose.cocktail_id
    @dose.delete
    redirect_to cocktail_path(@cocktail)
  end

  private

  def dose_params
    params.require(:dose).permit(:description, :ingredient_id)
  end

  def set_dose
    @dose = Dose.find(params[:id])
  end
end
