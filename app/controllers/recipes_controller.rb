class RecipesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  
  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
  
    if @recipe.save
      redirect_to recipes_path, notice: 'Recipe was successfully created.'
    else
      render :new
    end
  end  

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path, notice: 'Recipe was successfully removed.'
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description)
  end
end
