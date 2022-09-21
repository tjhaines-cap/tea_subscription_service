class Api::V1::SubscriptionsController < ApplicationController

  def create
    tea = Tea.find_by(title: params[:title])
    customer = Customer.find_by(email: params[:customer_email])
    subscription = Subscription.create(title: params[:title], price: params[:price], status: params[:status], frequency: params[:frequency], tea_id: tea.id, customer_id: customer.id)
    render status: :created
  end

  private
  def subscription_params
    params.permit(:title, :price, :status, :frequency)
  end
end