FactoryBot.define do
  factory :learned_tag do
    sequence(:name) { |i| "tag#{i}" }
  end
end
