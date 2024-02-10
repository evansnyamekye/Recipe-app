class RecipeFoodsController < ApplicationController
  before_action :set_user_and_recipe

  def index
    @recipe_foods = RecipeFood.all ``
  end

  def show
    @recipe_food = RecipeFood.find_by_id(params[:id])

    return unless @recipe_food.nil?

    redirect_to recipe_foods_path
  end

  def new
    @recipe_food = RecipeFood.new
  end

  def create
    @user = User.find(params[:user_id])
    @recipe = @user.recipes.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.build(recipe_food_params)

    if @recipe_food.save
      redirect_to user_recipe_path(@user, @recipe), notice: 'Ingredient added to recipe'
    else
      render :new
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @recipe = @user.recipes.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.find(params[:id])
    @recipe_food.destroy

    redirect_to user_recipe_path(@user, @recipe), notice: 'Ingredient removed from recipe'
  end

  private

  def set_user_and_recipe
    @user = User.find(params[:user_id])
    @recipe = @user.recipes.find(params[:recipe_id])
  end

  def recipe_food_params
    params.require(:recipe_food).permit(:food_id, :quantity)
  end
end
