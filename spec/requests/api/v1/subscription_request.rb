require 'rails_helper'

RSpec.describe 'Subscription Requests' do

  context 'happy path' do
    describe 'POST api/v1/subscription' do
      it 'creates a subscription in the database associated with a customer and a tea' do
        customer = create(:customer)
        tea = create(:tea)
        black_tea = create(:tea, title: "Black Tea")
        parameters = {
          title: 'Green Tea',
          price: 3.25,
          status: 'active',
          frequency: 'weekly',
          customer_email: 'customer@email.com'
        }
        expect do
          post '/api/v1/subscriptions', params: parameters
        end.to change { Subscription.count }.by(1) 

        expect(response.status).to eq(201)
        expect(customer.subscriptions.length).to eq(1)
        expect(tea.subscriptions.length).to eq(1)

        parameters2 = {
          title: 'Black Tea',
          price: 3.50,
          status: 'active',
          frequency: 'monthly',
          customer_email: 'customer@email.com'
        }

        expect do
          post '/api/v1/subscriptions', params: parameters2
        end.to change { Subscription.count }.by(1)
        expect(Customer.find(customer.id).subscriptions.length).to eq(2)
        expect(tea.subscriptions.length).to eq(1)
        expect(black_tea.subscriptions.length).to eq(1)
      end
    end 
  end

end