class ReviewsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    # The condition hinges on whether there's a :dog_house_id key in the params
    # hash — in other words, whether the user navigated to
    # /dog_houses/:dog_house_id/reviews or simply /reviews
    if params[:dog_house_id]
      dog_house = DogHouse.find(params[:dog_house_id])
      reviews = dog_house.reviews
    else
      reviews = Review.all
    end
    render json: reviews, include: :dog_house
  end

  def show
    review = Review.find(params[:id])
    render json: review, include: :dog_house
  end

  def create
    review = Review.create(review_params)
    render json: review, status: :created
  end

  private

  def render_not_found_response
    render json: { error: "Review not found" }, status: :not_found
  end

  def review_params
    params.permit(:username, :comment, :rating)
  end

end
