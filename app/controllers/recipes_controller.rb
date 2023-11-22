class RecipesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]

  def index
    @recipes = current_user.recipes.all
  end

  def new
    @recipe = Recipe.new
  end

  def show
    @recipe = Recipe.find(params[:id])
    @recipe_foods = @recipe.recipe_foods.includes(:food)
  end

  # def create
  #   @recipe = Recipe.new(recipe_params)

  #   if @recipe.save
  #     redirect_to recipes_path, notice: 'Recipe was successfully created.'
  #   else
  #     render :new
  #   end
  # end

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

  def shopping_list
    @recipe = Recipe.includes([recipe_foods: [:food]]).find(params[:recipe_id])
    @recipe_data = {
      total_food_items: @recipe.recipe_foods.size,
      total_price: @recipe.recipe_foods.sum { |recipe_food| recipe_food.food.price * recipe_food.quantity }
    }
    # @recipe_foods = @recipe.recipe_foods.includes(:food)
  end

  private

  # def recipe_params
  #   params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  # end

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description)
  end
end
