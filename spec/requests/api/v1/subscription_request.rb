require 'rails_helper'

RSpec.describe 'Subscription Requests' do

  context 'happy path' do
    describe 'POST api/v1/subscription' do
        
      it 'creates a subscription in the database associated with a customer and a tea' do
        customer = create(:customer)
        tea = create(:tea)
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

        json = JSON.parse(response.body, symbolize_names: true)
        expect(response.status).to eq(400)
        expect(customer.subscriptions.length).to eq(1)
        
      end
    end 
  end

end