require 'rails_helper'

RSpec.describe 'Subscription Requests' do

  describe 'POST api/v1/customers/:id/subscriptions' do
    context 'success' do
      it 'creates a subscription in the database associated with a customer and a tea' do
        customer = create(:customer)
        tea = create(:tea)
        black_tea = create(:tea, title: "Black Tea")
        parameters = {
          title: 'Green Tea',
          price: 3.25,
          status: 'active',
          frequency: 'weekly',
          tea_id: tea.id
        }
        expect do
          post "/api/v1/customers/#{customer.id}/subscriptions", params: parameters
        end.to change { Subscription.count }.by(1) 

        expect(response.status).to eq(201)
        expect(customer.subscriptions.length).to eq(1)
        expect(tea.subscriptions.length).to eq(1)

        parameters2 = {
          title: 'Black Tea',
          price: 3.50,
          status: 'active',
          frequency: 'monthly',
          tea_id: black_tea.id
        }

        expect do
          post "/api/v1/customers/#{customer.id}/subscriptions", params: parameters2
        end.to change { Subscription.count }.by(1)
        expect(Customer.find(customer.id).subscriptions.length).to eq(2)
        expect(tea.subscriptions.length).to eq(1)
        expect(black_tea.subscriptions.length).to eq(1)
      end
    end
  end

  describe 'GET api/v1/customers/:id/subscriptions' do
    context 'success' do
      it 'returns all subscriptions for a given customer' do
        customer = create(:customer)
        tea = create(:tea)
        black_tea = create(:tea, title: "Black Tea")
        subscription1 = create(:subscription, title: "Green Tea", tea_id: tea.id, customer_id: customer.id)
        subscription2 = create(:subscription, title: "Black Tea", tea_id: black_tea.id, customer_id: customer.id)

        get "/api/v1/customers/#{customer.id}/subscriptions"

        expect(response.status).to eq(200)
        json = JSON.parse(response.body, symbolize_names: true)
        data = json[:data] 
        expect(data).to be_a(Array)
        expect(data.length).to eq(2)
      end
    end
  end

  describe 'PATCH api/v1/customers/:id/subscriptions/:id' do
    context 'success' do
      it 'changes subscription status to cancelled' do
        customer = create(:customer)
        tea = create(:tea)
        black_tea = create(:tea, title: "Black Tea")
        subscription1 = create(:subscription, title: "Green Tea", tea_id: tea.id, customer_id: customer.id)
        subscription2 = create(:subscription, title: "Black Tea", tea_id: black_tea.id, customer_id: customer.id)
        
        expect(subscription1.status).to eq("Active")

        patch "/api/v1/customers/#{customer.id}/subscriptions/#{subscritpion1.id}"

        expect(response.status).to eq(202)
        json = JSON.parse(response.body, symbolize_names: true)
        data = json[:data] 
        expect(data).to be_a(Array)
        expect(data.length).to eq(2)
        expect(subscription1.status).to eq("Cancelled")
      end
    end
  end

end