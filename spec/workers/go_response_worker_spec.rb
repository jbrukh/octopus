require 'spec_helper'

describe GoResponseWorker do
  fixtures :users

  let(:worker) { GoResponseWorker.new }

  context '#perform' do
    let (:user) { users(:user) }
    let (:recording) { create :recording, :user => user }
    let (:analysis) { create :analysis, :user => user, :recording => recording, :state => 'processing' }

    before :each do
      expect(Analysis).to receive(:find).with('12345') { analysis }
      worker.perform('12345')
    end

   it { expect(analysis.state).to eq('processed') }
  end
end
