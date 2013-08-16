module Viewable
  extend ActiveSupport::Concern

  included do
    # scopes the model to the user and also to the
    # users in the same organization
    scope :viewable_by, ->(user) {
      if user.organization_id.blank?
        where("user_id = ?", user.id)
      else
        joins(:user => :organization).where('organizations.id = ?', user.organization_id)
      end
    }
  end
end