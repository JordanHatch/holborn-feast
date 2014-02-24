class User < ActiveRecord::Base

  class EmailNotPermitted < StandardError; end

  GDS_EMAIL_ADDRESS_BASE = /@digital\.cabinet\-office\.gov\.uk\z/
  before_create :ensure_gds_email

  has_many :recommendations
  has_many :recommended_eateries, through: :recommendations, source: :eatery

  def has_recommended?(eatery)
    recommended_eateries.where(id: eatery.id).any?
  end

  def self.find_or_create_from_auth_hash(auth_hash)
    existing_user = self.where(email: auth_hash[:info][:email]).first
    atts = {
      name: auth_hash[:info][:name],
      image_url: auth_hash[:info][:image],
      oauth_provider_uid: auth_hash[:uid]
    }

    if existing_user.present?
      existing_user.update_attributes(atts)
      existing_user
    else
      self.create!(atts.merge(
        email: auth_hash[:info][:email]
      ))
    end
  end

  private
  def ensure_gds_email
    unless email.match(GDS_EMAIL_ADDRESS_BASE)
      raise EmailNotPermitted.new(email)
    end
  end

end
