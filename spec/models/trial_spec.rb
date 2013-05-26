require 'spec_helper'

describe Trial do
  it { should belong_to(:user) }
  it { should belong_to(:experiment) }
  it { should belong_to(:participant) }
end
