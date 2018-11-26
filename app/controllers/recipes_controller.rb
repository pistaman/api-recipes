class RecipesController < ApplicationController
  before_action :set_recipe, only: :destroy

  def index
    @recipes = Recipe.all
    @recipes = { recipes: @recipes }
    render json: @recipes.as_json(except: ['created_at','updated_at'])
  end

  def show
    @recipe = Recipe.find(params[:id])
    @recipe = { message: 'Recipe details by id', recipe: [@recipe] }
    render json: response_fields(@recipe)
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      render json: response_fields({ message: 'Recipe successfully created!', recipe: @recipe })
    else
      render json: response_fields({ message: 'Recipe creation failed!', required: 'title, making_time, serves, ingredients, cost' })
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    if @recipe.destroy
      render json: response_fields({ message: 'Recipe successfully removed!' })
    end
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      render json: response_fields({ message: 'Recipe successfully updated!', recipe: [@recipe] })
    end
  end

  private

  def set_recipe
    @recipe = Recipe.find_by(id: params[:id])
    render json: { message: 'No Recipe found' } and return false if @recipe.nil?
  end

  def response_fields(recipe)
    recipe.as_json(except: ['id','created_at','updated_at'])
  end

  def recipe_params
    params.permit(:title, :making_time, :serves, :ingredients, :cost)
  end
end
