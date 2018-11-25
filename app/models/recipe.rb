class Recipe < ApplicationRecord
  validates :title, :making_time, :ingredients, :serves, :cost, presence: true
end
