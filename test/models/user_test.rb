require "test_helper"

describe User do

  it "is created from a valid auth hash" do
    auth_hash = {
      :provider => "google",
      :uid => "123456789",
      :info => {
          :name => "Winston Smith-Churchill",
          :email => "winston@digital.cabinet-office.gov.uk",
          :image => "https://lh3.googleusercontent.com/url/photo.jpg"
      }
    }
    user = User.find_or_create_from_auth_hash(auth_hash)
    user.reload

    assert_equal "Winston Smith-Churchill", user.name
    assert_equal "winston@digital.cabinet-office.gov.uk", user.email
    assert_equal "https://lh3.googleusercontent.com/url/photo.jpg", user.image_url
    assert_equal "123456789", user.oauth_provider_uid
  end

  it "rejects a non-GDS email address" do
    auth_hash = {
      :provider => "google",
      :uid => "123456789",
      :info => {
          :name => "Winston Smith-Churchill",
          :email => "winston@yahoo.co.uk",
          :image => "https://lh3.googleusercontent.com/url/photo.jpg"
      }
    }

    assert_raise User::EmailNotPermitted do
      User.find_or_create_from_auth_hash(auth_hash)
    end
  end

end
