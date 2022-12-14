require 'rails_helper'

RSpec.describe 'Subscription Requests' do

  describe 'POST api/v1/customers/:id/subscriptions' do
    context 'success' do
      it 'creates a subscription in the database associated with a customer and a tea' do
        customer = create(:customer)
        customer2 = create(:customer, email: "what@email.com")
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
        expect(customer2.subscriptions.length).to eq(0)

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
        expect(customer2.subscriptions.length).to eq(0)
      end
    end


    context 'failure' do
      it 'returns an error if not all fields are provided' do
        customer = create(:customer)
        tea = create(:tea)
        black_tea = create(:tea, title: "Black Tea")
        parameters = {
          title: 'Green Tea',
          status: 'active',
          frequency: 'weekly',
          tea_id: tea.id
        }
        
        post "/api/v1/customers/#{customer.id}/subscriptions", params: parameters
      
        expect(response.status).to eq(400)
        json = JSON.parse(response.body, symbolize_names: true)
        expect(json[:errors]).to eq(["Price can't be blank"])
      end

      it 'returns an error if invalid tea id is given' do
        customer = create(:customer)
        parameters = {
          title: 'Green Tea',
          price: 3.50,
          status: 'active',
          frequency: 'weekly',
          tea_id: 1
        }
        
        post "/api/v1/customers/#{customer.id}/subscriptions", params: parameters
      
        expect(response.status).to eq(400)
        json = JSON.parse(response.body, symbolize_names: true)
        expect(json[:errors]).to eq(["Tea must exist"])
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

        patch "/api/v1/customers/#{customer.id}/subscriptions/#{subscription1.id}"

        expect(response.status).to eq(202)
        json = JSON.parse(response.body, symbolize_names: true)
        data = json[:data] 
        expect(data).to be_a(Hash)
        expect(data[:attributes][:status]).to eq("Cancelled")
        expect(Subscription.find(subscription1.id).status).to eq("Cancelled")
      end
    end

    context 'failure' do
      it 'returns 404 if there is no subscription with the given id' do
        customer = create(:customer)
        tea = create(:tea)

        patch "/api/v1/customers/#{customer.id}/subscriptions/1"

        expect(response.status).to eq(404)
        json = JSON.parse(response.body, symbolize_names: true) 
        expect(json[:errors]).to eq("Invalid Subscription ID")
      end
    end
  end

end