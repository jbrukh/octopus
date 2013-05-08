require 'spec_helper'

describe Recording do
  context 'when new' do
    before :each do
      @recording = Recording.new
    end
    it { expect(@recording.state).to eq('waiting_for_data') }
  end
end
