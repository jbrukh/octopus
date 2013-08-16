require 'spec_helper'

describe User do
  describe 'in general' do
    it { should belong_to(:organization) }

    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }

    it { should strip_attribute(:first_name) }
    it { should strip_attribute(:last_name) }
  end
end
