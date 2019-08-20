# frozen_string_literal: true

class RecipesController < ApplicationController
  before_action :authenticate_user!, only: [:show, :create]

  def index
    @ingredients = Ingredient.where("name LIKE(?)", "%#{params[:keyword]}%")
  end

  def show
    @recipe = Recipe.find(params[:id])
    @total_calorie = 0
    @total_carbohydrate = 0
    @total_protein = 0
    @total_lipid = 0
    @total_salt = 0
    @recipe.ingredient_relations.zip(@recipe.ingredients) do |r, t|
      @total_calorie += r.weight * (t.calorie / 100)
      @total_carbohydrate += r.weight * (t.carbohydrate / 100)
      @total_protein += r.weight * (t.protein / 100)
      @total_lipid += r.weight * (t.lipid / 100)
      @total_salt += r.weight * (t.salt / 100)
    end
  end

  def new
    @recipe = current_user.recipes.build
    @recipe.ingredient_relations.build
    @recipe.directions.build
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    @recipe.save!
    redirect_to root_path
  end

  def edit
    @recipe = Recipe.find(params[:id])
      @ingredient_ids = @recipe.ingredient_ids
    @ingredient_ids.map! {|item|  Ingredient.find_by(id: item).name }
    @i = 0
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe)
    else
      flash.now[:alert] = @article.errors.full_messages.join('。')
      render :edit
    end
    @recipe = Recipe.find(params[:id])
  end

  private

  def recipe_params
    params.require(:recipe).permit(:id, :name, :description, :image, :_destroy,
                                   ingredient_relations_attributes: [:id, :recipe_id, :ingredient_id, :weight, :display_weight_name, :display_ingredient_name, :_destroy],
                                   directions_attributes: [:id, :number, :content, :_destroy])
  end

end
