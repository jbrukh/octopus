require 'spec_helper'

describe Media do
  it { should validate_presence_of(:name) }
end
