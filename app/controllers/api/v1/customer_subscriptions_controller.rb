class Api::V1::CustomerSubscriptionsController < ApplicationController

  def create
    # binding.pry
    tea = Tea.find_by(title: params[:title])
    customer = Customer.find_by(email: params[:customer_email])
    subscription = Subscription.create(title: params[:title], price: params[:price], status: params[:status], frequency: params[:frequency], tea_id: tea.id, customer_id: customer.id)
    render json: SubscriptionSerializer.new(subscription), status: :created
  end

  def show
    # binding.pry
    # customer = Customer.find_by(email: params[:customer_email])
    customer = Customer.find(params[:customer_id])
    subscriptions = customer.subscriptions
    render json: SubscriptionSerializer.new(subscriptions), status: :ok
  end

  private
  def subscription_params
    params.permit(:title, :price, :status, :frequency)
  end
end