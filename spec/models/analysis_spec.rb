require 'spec_helper'

describe Analysis do
  it { should belong_to(:user) }
  it { should belong_to(:recording) }

  it { should validate_presence_of(:jid) }
  it { should validate_presence_of(:algorithm) }
  it { should validate_presence_of(:state) }

  context 'when new' do
    before :each do
      @analysis = Analysis.new
    end
    it { expect(@analysis.state).to eq('processing') }
  end
end
