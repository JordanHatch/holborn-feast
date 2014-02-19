FactoryGirl.define do

  factory(:user) do
    name "Winston Smith-Churchill"
    email "winston.smith-churchill@digital.cabinet-office.gov.uk"
    oauth_provider_uid "12345678"
    image_url "http://example.com/winston.jpg"
  end

end
