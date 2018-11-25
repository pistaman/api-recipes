class RecipesController < ApplicationController

  def index
    recipes = Recipe.all
    recipes = { recipes: recipes }
    render json: recipes
  end

  def show
    recipe = Recipe.find!(params[:id])
  rescue
    render json: { message: 'No Recipe found' } and return false if recipe.nil?

    recipe = { recipes: recipes }
    render json: recipe
  end

  def create
    recipe = Recipe.new(recipe_params)
    if recipe.save
      render json: { message: 'Recipe successfully created!', recipe: recipe }
    else
      render json: { message: 'Recipe creation failed!', required: 'title, making_time, serves, ingredients, cost' }
    end
  end

  def destroy
    recipe = Recipe.find!(params[:id])
  rescue
    render json: { message: 'No Recipe found' } and return false if recipe.nil?

    if recipe.destroy
      render json: { message: 'Recipe successfully removed!' }
    end
  end

  def update
    recipe = Recipe.find!(params[:id])
  rescue
    render json: { message: 'No Recipe found' } and return false if recipe.nil?

    if recipe.update(recipe_params)
      render json: { message: 'Recipe successfully updated!', recipe: recipe }
    end
  end

  private

  def recipe_params
    params.permit(:title, :making_time, :serves, :ingredients, :cost)
  end
end
