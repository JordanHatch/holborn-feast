FactoryGirl.define do

  factory(:eatery) do
    sequence(:name) {|n| "Eatery #{n}" }
    lat 51.517238
    lon -0.120561
    description "This eatery serves food."
  end

end
