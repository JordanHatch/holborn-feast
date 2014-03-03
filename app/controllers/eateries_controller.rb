class EateriesController < ApplicationController
  before_filter :find_eatery, only: [:show, :edit, :update]

  def index
    @eateries = Eatery.in_name_order.includes(:recommendations)
    # index.html.erb
  end

  def new
    @eatery = Eatery.new
  end

  def create
    @eatery = Eatery.new(eatery_params)
    if @eatery.save
      flash[:notice] = "Eatery created"
      redirect_to eatery_path(@eatery)
    else
      render action: :new
    end
  end

  def random
    @eatery = Eatery.in_random_order.first
    redirect_to eatery_path(@eatery)
  end

  def show
    # show.html.erb
  end

  def edit
    # edit.html.erb
  end

  def update
    if @eatery.update_attributes(eatery_params)
      flash[:notice] = "Eatery saved"
      redirect_to eatery_path(@eatery)
    else
      render action: :edit
    end
  end

  private
  def find_eatery
    @eatery = Eatery.friendly.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    error_404
  end

  def eatery_params
    params.require(:eatery).permit(:name, :lat, :lon, :description)
  end

end
