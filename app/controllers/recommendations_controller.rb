class RecommendationsController < ApplicationController
  before_filter :find_eatery

  def update
    user_recommendations.first_or_create

    flash[:notice] = "Thanks for recommending this eatery."
    redirect_to eatery_path(@eatery)
  end

  def destroy
    if user_recommendations.first && user_recommendations.first.destroy
      flash[:notice] = "The recommendation has been removed."
    else
      flash[:error] = "No recommendation could be found for this eatery."
    end

    redirect_to eatery_path(@eatery)
  end

  private

  def find_eatery
    @eatery = Eatery.friendly.find(params[:eatery_id])
  rescue ActiveRecord::RecordNotFound
    error_404
  end

  def user_recommendations
    current_user.recommendations.where(eatery_id: @eatery.id)
  end

end
