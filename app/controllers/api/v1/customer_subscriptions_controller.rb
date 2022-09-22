class Api::V1::CustomerSubscriptionsController < ApplicationController

  def create
    subscription = Subscription.create(subscription_params)
    render json: SubscriptionSerializer.new(subscription), status: :created
  end

  def index
    customer = Customer.find(params[:customer_id])
    subscriptions = customer.subscriptions
    render json: SubscriptionSerializer.new(subscriptions), status: :ok
  end

  def update
    subscription = Subscription.find_by_id(params[:id])
    if subscription
      subscription.update(status: "Cancelled")
      render json: SubscriptionSerializer.new(subscription),  status: :accepted
    else
      render json: { errors: "Invalid Subscription ID" }, status: :not_found
    end
  end

  private
  def subscription_params
    params.permit(:title, :price, :status, :frequency, :tea_id, :customer_id)
  end
end