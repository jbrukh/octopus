require 'spec_helper'

describe Recording do
  fixtures :users, :organizations

  describe 'in general' do
    it { should belong_to :participant }
    it { should strip_attribute(:name) }
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

    describe '#upload' do
      before :each do
        @result = @recording.upload()
      end

      it 'uploads' do
        expect(@result).to eq(true)
      end
    end
  end

  describe '#viewable_by' do
    before :each do
      @mine       = create :recording, :user => users(:user)
      @friend     = create :recording, :user => users(:friend)
      @enemy      = create :recording, :user => users(:enemy)
      @stranger   = create :recording, :user => users(:stranger)
    end

    it 'return my recordings' do
      Recording.viewable_by(users(:user)).should include(@mine)
    end

    it 'returns my organization recordings' do
      Recording.viewable_by(users(:user)).should include(@friend)
    end

    it 'returns not return my enemies recordings' do
      Recording.viewable_by(users(:user)).should_not include(@enemy)
    end

    it 'returns not return strangers recordings' do
      Recording.viewable_by(users(:user)).should_not include(@stranger)
    end
  end
end
