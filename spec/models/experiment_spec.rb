require 'spec_helper'

describe Experiment do
  it { should validate_presence_of(:name) }
end
