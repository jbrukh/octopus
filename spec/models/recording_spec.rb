require 'spec_helper'

describe Recording do
  fixtures :users

  describe 'in general' do
    it { should belong_to :participant }
  end

  context 'when new' do
    before :each do
      @recording = Recording.new
    end
    it { expect(@recording.state).to eq('waiting_for_data') }
  end

  context 'with recording' do
    before :each do
      @recording = create :recording, :user => users(:user)
    end

    describe '#trash!' do
      before :each do
        @recording.trash!
      end

      it 'sets the trashed_at field' do
        expect(@recording.trashed_at).to_not eq(nil)
      end
    end
  end
end
