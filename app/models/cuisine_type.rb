class CuisineType < ActiveRecord::Base
  has_many :eateries

  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :name, uniqueness: true
end
