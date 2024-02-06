class RecipesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def index
   @user = User.find(params[:user_id])
    @recipes = @user.recipes
  end

  def show
    @user = User.find(params[:user_id])
    @recipe = @user.recipes.find(params[:id])
    @recipe_foods = @recipe.recipe_foods.includes(:food)
  end

  def new
    @user = current_user
    @recipe = @user.recipes.build
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    if @recipe.save
      redirect_to user_recipes_path(current_user)
    else
      put @recipe.errors.full_messages
      render :new
    end
  end

  def destroy 
    @recipe = current_user.recipes.includes(recipe_params).find(params[:id])
    RecipeFood.where(recipe_id: @recipe.id).destroy_all
    @recipe.destroy 

    redirect_to user_recipes_path(current_user), notice: 'Recipe successfully deleted'
end

def update 
  @user = User.find(params[:user_id])
  @recipe = @user.recipes.find(params[:id])

  if @recipe.update(recipe_params)
    redirect_to user_recipes_path(@user, @recipe).notice = 'Recipe successfully updated'
    else
    render :show
  end
end

def shopping_lists
  @recipe = Recipe.includes([:recipe_foods, [:foods]).find(params[:id])
  user_food = current_user.foods

  missing_foods = @recipe.recipe_foods.reject { |recipe_food| user_foods.include?(recipe_food.food) }

  data = { total_items: missing_foods.size,
total_price: missing_foods.sum( |recipe_food| recipe_food.quantity * recipe_food.food.price) }

@missing_foods = misssing_foods
end

private

def recipe_params
  params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
 end
end
