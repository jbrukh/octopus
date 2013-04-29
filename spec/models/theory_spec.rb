require 'spec_helper'

describe Theory do
  it { should validate_presence_of(:name) }
end
