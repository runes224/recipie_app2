class MyRecipesController < ApplicationController
  before_action :authenticate_user!

  def index
    @q = Recipe.joins(:my_recipes).where(my_recipes: { user: current_user }).order(created_at: :desc).ransack(params[:q])
    @recipes = @q.result(distinct: true)
                 .page(params[:page])
  end

  def create
    @my_recipe = current_user.my_recipes.create(recipe_id: params[:recipe_id])
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @my_recipe = current_user.my_recipes.find_by(recipe: params[:recipe])
    @my_recipe.destroy
    redirect_back(fallback_location: root_path)
  end
end
