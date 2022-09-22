class Api::V1::CustomerSubscriptionsController < ApplicationController

  def create
    # binding.pry
    subscription = Subscription.create(subscription_params)
    render json: SubscriptionSerializer.new(subscription), status: :created
  end

  def show
    # binding.pry
    customer = Customer.find(params[:customer_id])
    subscriptions = customer.subscriptions
    render json: SubscriptionSerializer.new(subscriptions), status: :ok
  end

  private
  def subscription_params
    params.permit(:title, :price, :status, :frequency, :tea_id, :customer_id)
  end
end