class DosesController < ApplicationController
  before_action :set_cocktail, except: [:destroy]

  def new
    # @cocktail = Cocktail.find(params[:cocktail_id]) provided from line 2
    @dose = Dose.new
  end

  def create
    # @cocktail = Cocktail.find(params[:cocktail_id]) provided from line 2
    @dose = Dose.new(dose_params)
    @dose.cocktail = @cocktail
    @ingredient = Ingredient.find(params[:dose][:ingredient_id]) if params[:dose][:ingredient_id]
    @dose.ingredient = @ingredient
    # @dose.save unnecessary; line below runs save as part of if condition
    if @dose.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  def destroy
    @dose = Dose.find(params[:id])
    @dose.destroy
    redirect_to cocktail_path(@dose.cocktail)
  end

  private

  def set_cocktail
    @cocktail = Cocktail.find(params[:cocktail_id])
  end

  def dose_params
    params.require(:dose).permit(:description, :ingredient)
  end
end
