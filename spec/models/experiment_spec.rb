require 'spec_helper'

describe Experiment do
  it { should belong_to(:user) }
  it { should validate_presence_of(:name) }
  it { should strip_attribute(:name) }
end
