FactoryBot.define do
  factory :location do
    sequence(:id) { |n| n }
    name { 'Amphitheatre Parkway' }
    lat  { 40.7142484 }
    lng { -73.9614103 }
  end
end
