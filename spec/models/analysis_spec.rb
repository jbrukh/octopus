require 'spec_helper'

describe Analysis do
  fixtures :users

  it { should belong_to(:user) }
  it { should belong_to(:recording) }

  it { should validate_presence_of(:algorithm) }
  it { should validate_presence_of(:state) }

  it { should ensure_inclusion_of(:algorithm).in_array(['fft']) }

  context 'with new analysis' do
    before :each do
      @analysis = Analysis.new
    end

    it { expect(@analysis.state).to eq('pending') }
  end

  context 'with analysis' do
    let (:user) { users(:user) }
    let (:recording) { create :recording, :user => user }
    let (:analysis) { create :analysis, :user => user, :recording => recording }

    describe '#dispatch!' do
      it 'sets state to processing' do
        analysis.dispatch!('jid')
        expect(analysis.state).to eq('processing')
      end
    end
  end
end
