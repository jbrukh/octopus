require 'spec_helper'

describe Organization do
  describe 'in general' do
    it { should belong_to(:owner) }
    it { should validate_presence_of(:name) }
    it { should strip_attribute(:name) }
  end
end
