class Eatery < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :recommendations
  has_many :recommended_by, through: :recommendations, source: :user

  validates :name, presence: true

  scope :in_name_order, -> { order(name: :asc) }
  scope :in_random_order, -> { order("RANDOM()") }
end
