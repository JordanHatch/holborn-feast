FactoryGirl.define do

  factory(:eatery) do
    sequence(:name) {|n| "Eatery #{n}" }
    lat 51.517238
    lon -0.120561
    description "This eatery serves food."

    trait :with_recommendations do
      ignore do
        recommendations 1
      end

      after(:create) do |eatery, evaluator|
        evaluator.recommendations.times do
          create(:recommendation, eatery: eatery)
        end
      end
    end

    factory :eatery_with_recommendations, traits: [:with_recommendations]
  end

end
