class Recommendation < ActiveRecord::Base
  belongs_to :user
  belongs_to :eatery

  # set validations on each other, so the errors hash
  # doesn't imply that just one of the two values is erroneous
  validates :user_id, uniqueness: { scope: :eatery_id }
  validates :eatery_id, uniqueness: { scope: :user_id }
end
