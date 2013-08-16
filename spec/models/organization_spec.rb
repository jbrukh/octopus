require 'spec_helper'

describe Organization do
  describe 'in general' do
    it { should have_many(:users) }
    it { should validate_presence_of(:name) }
    it { should strip_attribute(:name) }
  end
end
