FactoryBot.define do
  factory :tea do
    title { "Green Tea" }
    description { "nice green tea" }
    temperature { 80 }
    brew_time { 3 }
  end
end