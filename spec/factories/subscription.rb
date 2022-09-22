FactoryBot.define do
  factory :subscription do
    price { 5.50 }
    status { "Active" }
    frequency { "Weekly" }
  end
end